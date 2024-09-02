class AutodockVina < Formula
  desc "Molecular docking and virtual screening program"
  homepage "http://vina.scripps.edu/"
  url "https://github.com/ccsb-scripps/AutoDock-Vina/archive/refs/tags/v1.2.5.tar.gz"
  sha256 "38aec306bff0e47522ca8f581095ace9303ae98f6a64031495a9ff1e4b2ff712"
  license "Apache-2.0"

  depends_on "boost@1.76"
  depends_on "swig"

  def install
   cd "build" do
       boost_include_path = Formula["boost@1.76"].include
       system "sed -i '' 's|INCFLAGS = -I \\$(BOOST_INCLUDE)|INCFLAGS = -I #{boost_include_path}|' makefile_common"
    end 
   cd "build/mac/release" do
      boost_path = Formula["boost@1.76"].opt_prefix
      system "sed -i '' 's|BASE=/usr/local|BASE=#{boost_path}|' Makefile"
      system "sed -i '' 's|C_OPTIONS= -O3 -DNDEBUG -std=c++11 -fvisibility=hidden|C_OPTIONS= -O3 -DNDEBUG -std=c++11 -fvisibility=hidden -Wno-enum-constexpr-conversion|' Makefile"
      system "make"
    end
    bin.install "build/mac/release/vina"
    bin.install "build/mac/release/vina_split"
  end

  test do
    system "#{bin}/vina", "--help"
  end
end
