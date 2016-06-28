require "formula"

class Atlas < Formula
  homepage "http://math-atlas.sourceforge.net/"
  url "https://downloads.sourceforge.net/projects/math-atlas/files/Stable/3.10.2/atlas3.10.2.tar.bz2"
  sha1 "f1f883e201d70ff60d54a2af016b4afc83a2499b"


  depends_on "cmake" => :build
  depends_on "libdnet"
  depends_on "libnet"

  def install
    mkdir "build" do
      system "cmake", ".", *std_cmake_args
      system "../configure", "--prefix=#{prefix}"
      system "make", "install"
    end
  end
  test do
    # Esempio di test!
    (testpath/"test.c").write <<-EOS.undent
      #include <git2.h>

      int main(int argc, char *argv[]) {
        int options = git_libgit2_features();
        return 0;
      }
    EOS
    libssh2 = Formula["libssh2"]
    flags = (ENV.cflags || "").split + (ENV.cppflags || "").split + (ENV.ldflags || "").split
    flags += %W[
      -I#{include}
      -I#{libssh2.opt_include}
      -L#{lib}
      -lgit2
    ]
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
