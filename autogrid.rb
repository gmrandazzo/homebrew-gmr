class Autogrid < Formula
  desc "Prepares grid maps for AutoDock"
  homepage "http://autodock.scripps.edu/"
  url "https://github.com/ccsb-scripps/AutoGrid.git", revision: "HEAD"
  version "4.2.7"
  license "GPL-2.0"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "gcc"

def install
    system "autoreconf", "-i"
    mkdir "build" do
      system "../configure", "--prefix=#{prefix}"
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/autogrid4", "--version"
  end
end