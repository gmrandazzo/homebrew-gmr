require "formula"

class Molsketch < Formula
  homepage "http://molsketch.sourceforge.net"
  url "https://downloads.sourceforge.net/project/molsketch/Molsketch/Beryllium%200.4.0/Molsketch-0.4.0-src.tar.gz"
  sha256 "5ff8d8fe9c8824bdd9b84edc4db1254cc729ab72c7e2c745fbea392145eb3900"

  depends_on "cmake" => :build
  depends_on "open-babel"
  depends_on "qt5"

  def install
    system "qmake", "Molsketch.pro", "PREFIX=#{prefix}"
    system "make"
    system "make", "install"
    #mkdir "build" do
    #  args = std_cmake_args
    #  args << "-DCMAKE_PREFIX_PATH=#{Formula["qt5"]}"
    #  args << "-DCMAKE_MACOSX_RPATH=1"
    #  args << ".."
    #  system "cmake", *args
    #  system "make"
    #  system "make", "install"
    #end
  end

  test do
    system "false"
  end
end
