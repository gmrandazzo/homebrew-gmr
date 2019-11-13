require "formula"

class Libtachyon < Formula
  homepage "http://jedi.ks.uiuc.edu/~johns/raytracer/files/0.99b6/"
  head "https://github.com/thesketh/Tachyon.git"
  url "http://jedi.ks.uiuc.edu/~johns/raytracer/files/0.99b6/tachyon-0.99b6.tar.gz"
  sha256 "f4dcaf9c76a4f49310f56254390f9611c22e353947a1745a8c623e8bc8119b97"
  depends_on "gcc"

  def install
    cd "unix" do
      system "make", "macosx-x86-thr"
      include.install Dir["../src/*.h"]
      lib.install "../compile/macosx-x86-thr/libtachyon.a"
      bin.install "../compile/macosx-x86-thr/tachyon"
    end
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <tachyon.h>
      
      int main(void)
      {    
	printf(\"tachyon version: %s\\n\", TACHYON_VERSION_STRING);
        return 0;
      }
    EOS
    system ENV.cc, "-I#{include}", "test.c", "-o", "test", "-L#{lib}", "-ltachyon"
    system "./test"
  end
end
