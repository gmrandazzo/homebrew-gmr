require "formula"

class Mlptools < Formula
  homepage "http://mlp-tools.tk"
  url "http://mlptools.altervista.org/downloads/MLPtools2_setup.zip"
  sha256 "87b194864cbd7ff770afb3dbfb937fecbd714aaa04aaa2937d67052c89173d1c"

  depends_on "numpy"
  depends_on "pymol"
  depends_on "python" if MacOS.version <= :snow_leopard

  def install
    # build the pymol libraries
    system "python", "-s", "setup.py"
  end
end

