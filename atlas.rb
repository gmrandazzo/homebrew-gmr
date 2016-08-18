require "formula"

class Atlas < Formula
  homepage "http://math-atlas.sourceforge.net/"
  url "http://downloads.sourceforge.net/project/math-atlas/Stable/3.10.3/atlas3.10.3.tar.bz2"
  sha256 "2688eb733a6c5f78a18ef32144039adcd62fabce66f2eb51dd59dde806a6d2b7"

  depends_on "lapack"
  depends_on "gcc"
  
  def install
    mkdir "build" do
      system "../configure", "--prefix=#{prefix}"
      system "make"
      system "make", "install"
    end
  end
end
