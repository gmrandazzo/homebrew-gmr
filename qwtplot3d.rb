require "formula"

class Qwtplot3d < Formula
  homepage "http://qwtplot3d.sourceforge.net"
  url "http://downloads.sourceforge.net/project/qwtplot3d/qwtplot3d/0.2.7/qwtplot3d-0.2.7.tgz"
  sha256 "1208336b15e82e7a9d22cbc743e46f27e2fad716094a9c133138f259fa299a42"

  depends_on "qt"
  depends_on "gl2ps"

  patch :DATA

  def install
    system "qmake", "PREFIX=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "false"
  end
end

__END__
diff -Naur qwtplot3d.orig/include/qwt3d_openglhelper.h qwtplot3d.patch/include/qwt3d_openglhelper.h
--- qwtplot3d.orig/include/qwt3d_openglhelper.h	2005-07-19 17:40:28.000000000 +0200
+++ qwtplot3d.patch/include/qwt3d_openglhelper.h	2014-09-11 13:31:34.000000000 +0200
@@ -1,6 +1,6 @@
 #ifndef __openglhelper_2003_06_06_15_49__
 #define __openglhelper_2003_06_06_15_49__
-
+#include <glu.h>
 #include "qglobal.h"
 #if QT_VERSION < 0x040000
 #include <qgl.h>
diff -Naur qwtplot3d.orig/qwtplot3d.pro qwtplot3d.patch/qwtplot3d.pro
--- qwtplot3d.orig/qwtplot3d.pro	2007-05-20 17:51:50.000000000 +0200
+++ qwtplot3d.patch/qwtplot3d.pro	2014-09-11 14:02:10.000000000 +0200
@@ -1,9 +1,13 @@
 # pro file for building the makefile for qwtplot3d
 #
 
+isEmpty(PREFIX) {
+  PREFIX = /usr/local
+}
+
 TARGET            = qwtplot3d
 TEMPLATE          = lib
-CONFIG           += qt warn_on opengl thread zlib debug
+CONFIG           += qt warn_on opengl thread zlib release
 MOC_DIR           = tmp
 OBJECTS_DIR       = tmp
 INCLUDEPATH       = include
@@ -92,4 +96,17 @@
   DEFINES += GL2PS_HAVE_ZLIB
   win32:LIBS += zlib.lib
 	unix:LIBS  += -lz
-}
\ No newline at end of file
+}
+
+target.path = $$PREFIX/lib
+header_files.files = $$HEADERS
+header_files.path = $$PREFIX/include/qwtplot3d
+
+INSTALLS += target
+INSTALLS += header_files
+
+CONFIG     += create_pc create_prl no_install_prl
+QMAKE_PKGCONFIG_LIBDIR = $$PREFIX/lib/
+QMAKE_PKGCONFIG_INCDIR = $$PREFIX/include/qwtplot3d
+QMAKE_PKGCONFIG_CFLAGS = -I$$PREFIX/include/
+QMAKE_PKGCONFIG_DESTDIR = pkgconfig
\ No newline at end of file
