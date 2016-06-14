require "formula"

class Mlptools < Formula
  homepage "http://mlp-tools.tk"
  url "http://mlptools.altervista.org/downloads/mlp_tools_setup.zip"
  sha1 "92b43edd8ef63f01f576cc4b975958ae1a6e57eb"

  depends_on "numpy"
  depends_on "pymol"
  depends_on "python" if MacOS.version <= :snow_leopard

  def install
    # build the pymol libraries
    system "python", "-s", "setup.py"
  end
end

