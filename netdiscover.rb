require "formula"

class Netdiscover < Formula
  homepage "http://nixgeneration.com/~jaime/netdiscover/"
  url "http://downloads.sourceforge.net/project/netdiscover/netdiscover/0.3-beta6/netdiscover-0.3-beta6.tar.gz"
  sha1 "b6dfb89a0cbd14e398ae01f358bc56719c994856"

  head do
    url "https://github.com/alexxy/netdiscover.git"
    depends_on "cmake" => :build
    depends_on "gawk"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libnet"
  depends_on "libpcap"

  def install
    if build.head?
      system "cmake", ".", *std_cmake_args
      system "python", "update-oui-database.py"
    else
      system "autoconf"
      system "./configure", "--prefix=#{prefix}"
    end
    system "make", "install"
  end

  test do
    system "(#{sbin}/netdiscover --help; true)"
  end
end
