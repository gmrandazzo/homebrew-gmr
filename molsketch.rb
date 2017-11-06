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
