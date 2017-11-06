require "formula"

class Molsketch < Formula
  homepage "http://molsketch.sourceforge.net"
  url "https://downloads.sourceforge.net/project/molsketch/Molsketch/Boron%200.5.0/Molsketch-0.5.0-src.tar.gz"
  sha256 "b32dc31f5c59869e152ad39c7c50603758174a2e03deca837ce00a1f8c175086"

  depends_on "cmake" => :build
  depends_on "open-babel"
  depends_on "qt"

  patch :DATA

  def install
    mkdir "build" do
      args = std_cmake_args
      args << "-Wno-dev"
      args << "-DCMAKE_PREFIX_PATH=#{Formula["qt"]}"
      args << "-DMSK_INSTALL_PREFIX=#{prefix}"
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
--- Molsketch-0.5.0.orig/molsketch/CMakeLists.txt	2017-09-26 08:34:00.000000000 +0200
+++ Molsketch-0.5.0/molsketch/CMakeLists.txt	2017-11-06 13:51:34.000000000 +0100
@@ -58,7 +58,7 @@

 # Install menu entries on Linux
 if(UNIX)
-  install(FILES ${PROJECT_SOURCE_DIR}/molsketch/src/molsketch.desktop DESTINATION share/applications)
-  install(FILES ${PROJECT_SOURCE_DIR}/molsketch/src/images/molsketch.xpm DESTINATION share/pixmaps)
-  install(FILES ${PROJECT_SOURCE_DIR}/molsketch/src/images/molsketch.svg DESTINATION share/icons/hicolor/scalable/apps)
+  install(FILES ${PROJECT_SOURCE_DIR}/molsketch/molsketch.desktop DESTINATION share/applications)
+  install(FILES ${PROJECT_SOURCE_DIR}/molsketch/images/molsketch.xpm DESTINATION share/pixmaps)
+  install(FILES ${PROJECT_SOURCE_DIR}/molsketch/images/molsketch.svg DESTINATION share/icons/hicolor/scalable/apps)
 endif(UNIX)
