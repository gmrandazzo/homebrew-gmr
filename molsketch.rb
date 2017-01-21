require "formula"

class Molsketch < Formula
  homepage "http://molsketch.sourceforge.net"
  url "https://downloads.sourceforge.net/project/molsketch/Molsketch/Beryllium%200.4.0/Molsketch-0.4.0-src.tar.gz"
  sha256 "5ff8d8fe9c8824bdd9b84edc4db1254cc729ab72c7e2c745fbea392145eb3900"

  depends_on "cmake" => :build
  depends_on "open-babel"
  depends_on "qt5"

  patch :DATA

  def install
    mkdir "build" do
      args = std_cmake_args
      args << "-DCMAKE_PREFIX_PATH=#{Formula["qt5"]}"
      args << "-DMSK_STATIC_LIB=TRUE"
      args << ".."
      system "cmake", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end

__END__
--- Molsketch-0.4.0.orig/CMakeLists.txt	2017-01-04 14:34:34.000000000 +0100
+++ Molsketch-0.4.0/CMakeLists.txt	2017-01-21 19:32:18.000000000 +0100
@@ -111,11 +111,15 @@

 list(APPEND mskprefix "Global prefix" MSK_INSTALL_PREFIX /usr/local "C:/Program Files/MolsKetch")
 list(APPEND mskbins Executable MSK_INSTALL_BINS /bin "")
-if( CMAKE_SIZEOF_VOID_P EQUAL 8 )
-	list(APPEND msklibs Libraries MSK_INSTALL_LIBS /lib64 "")
-else( CMAKE_SIZEOF_VOID_P EQUAL 8 )
+if(APPLE)
 	list(APPEND msklibs Libraries MSK_INSTALL_LIBS /lib "")
-endif( CMAKE_SIZEOF_VOID_P EQUAL 8 )
+elseif(APPLE)
+  if( CMAKE_SIZEOF_VOID_P EQUAL 8 )
+  	list(APPEND msklibs Libraries MSK_INSTALL_LIBS /lib64 "")
+  else( CMAKE_SIZEOF_VOID_P EQUAL 8 )
+  	list(APPEND msklibs Libraries MSK_INSTALL_LIBS /lib "")
+  endif( CMAKE_SIZEOF_VOID_P EQUAL 8 )
+endif(APPLE)
 list(APPEND mskincludes Headers MSK_INSTALL_INCLUDES /include/molsketch /include)
 list(APPEND mskdocs Documentation MSK_INSTALL_DOCS /share/doc/molsketch /doc)
