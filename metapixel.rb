require 'formula'

class Metapixel < Formula
  homepage 'http://www.complang.tuwien.ac.at/schani/metapixel/'
  url 'http://www.complang.tuwien.ac.at/schani/metapixel/files/metapixel-1.0.2.tar.gz'
  sha256 "8d77810978da397c070b9b4e228ae6204e9f5c524518ad1a4fcab9462171f55b"

  depends_on 'jpeg'
  depends_on 'giflib'
  depends_on 'libpng12'

  def install
    system "make"
    # The Makefile does not create the man dir
    system "mkdir", "-p", "#{man}/man1"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "metapixel --version"
  end
end
