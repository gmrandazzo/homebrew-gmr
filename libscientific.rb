require "formula"

class Libscientific < Formula
  homepage "https://github.com/gmrandazzo/libscientific"
  head "https://github.com/gmrandazzo/libscientific.git"
  depends_on "cmake" => :build

  def install
    mkdir "build" do
      args = std_cmake_args
      system "cmake", "..", *args
      system "make"
      system "make install"
    end
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <scientific.h>
      
      int main(void)
      {    
	printf(\"scientific version: %s\\n\", GetScientificVersion());
        return 0;
      }
    EOS
    system ENV.cc, "-I#{include}", "test.c", "-o", "test", "-L#{lib}", "-lscientific"
    system "./test"
  end
end
