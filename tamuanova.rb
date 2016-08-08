require "formula"

class Tamuanova < Formula
  homepage "http://www.stat.tamu.edu/~aredd/tamuanova/"
  url "http://ftp.debian.org/debian/pool/main/t/tamuanova/tamuanova_0.2.orig.tar.gz"
  sha256 "2583bd33bb9243709a5f44ad07677a8362bcca8816bd19f452eb4e3e375c213a"

  depends_on "qt"
  depends_on "gsl"
  depends_on "pkg-config" => :build
  def install
    File.open("#{buildpath}/alglib.pro", "w") do |f|
      f.puts("isEmpty(PREFIX) {")
      f.puts("PREFIX = /usr/local")
      f.puts("}")
      f.puts("TARGET       = tamuanova")
      f.puts("VERSION      = 0.2.1")
      f.puts("TEMPLATE     = lib")
      f.puts("CONFIG      += warn_on release")
      f.puts("QT          -= gui core")
      f.puts("LIBS        -= -lQtGui -lQtCore")
      f.puts("LIBS        += -lgsl")
      f.puts("MOC_DIR      = ./tmp")
      f.puts("OBJECTS_DIR  = ./tmp ")
      f.puts("DEPENDPATH += .")
      f.puts("INCLUDEPATH += .")
      f.puts("HEADERS += tamu_anova.h")
      f.puts("SOURCES += anova_1.c anova_2.c")
      f.puts("target.path = $$PREFIX/lib")
      f.puts("header_files.files = $$HEADERS")
      f.puts("header_files.path = $$PREFIX/include/")
      f.puts("INSTALLS += target")
      f.puts("INSTALLS += header_files")
      f.puts("CONFIG     += create_pc create_prl no_install_prl")
      f.puts("QMAKE_PKGCONFIG_LIBDIR = $$PREFIX/lib/")
      f.puts("QMAKE_PKGCONFIG_INCDIR = $$PREFIX/include/")
      f.puts("QMAKE_PKGCONFIG_CFLAGS = -I$$PREFIX/include/")
      f.puts("QMAKE_PKGCONFIG_DESTDIR = pkgconfig")
    end
    system "qmake", "PREFIX=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include "tamu_anova.h"

      int main(void){
        double data[20] = {
          88.60,73.20,91.40,68.00,75.20,63.00,53.90,
          69.20,50.10,71.50,44.90,59.50,40.20,56.30,
          38.70,31.00,39.60,45.30,25.20,22.70,
        };
        long factor[20]={
        1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4
        };
        struct tamu_anova_table R = tamu_anova(data,factor,20,4);
        return 0;
      }
    EOS
    system ENV.cxx, "-o", "test", "test.cpp", "-L/usr/local/lib", "-ltamuanova", "-I/usr/local/include/"
    system "./test"
  end
end
