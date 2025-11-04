class Rdock < Formula
  desc "Molecular docking program for virtual screening"
  homepage "https://rdock.github.io/"
  url "https://rdock.github.io/"
  version "latest"
  license "GPL-3.0-or-later"
  head "https://github.com/CBDD/rDock.git", branch: "main"

  depends_on "gcc"
  depends_on "popt"

  def install
    # Set the correct C++ compiler from Homebrew’s GCC installation
    gcc_ver = Formula["gcc"].version.major
    ENV["CXX"] = "#{HOMEBREW_PREFIX}/opt/gcc/bin/g++-#{gcc_ver}"

    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/rbcavity", "--help"
  end
end
