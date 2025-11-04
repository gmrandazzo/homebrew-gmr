require "formula"

class Libscientific < Formula
  desc "C framework for statistical and multivariate analysis"
  homepage "https://github.com/gmrandazzo/libscientific"
  head "https://github.com/gmrandazzo/libscientific.git", branch: "main"
  depends_on "cmake" => :build
  depends_on "python"
  depends_on "sqlite"

  def pythons
    deps.map(&:to_formula)
        .select { |f| f.name.match?(/^python@\d\.\d+$/) }
        .sort_by(&:version) # so that `bin/f2py` and `bin/f2py3` use python3.10
        .map { |f| f.opt_libexec/"bin/python" }
  end

  def install
    mkdir "build" do
      args = std_cmake_args
      system "cmake", "..", *args
      system "make"
      system "make install"
    end
    cd "src/python_bindings" do
      pythons.each do |python|
        site_packages = Language::Python.site_packages(python)
        system python, "-m", "pip", "install", "."
        # system python, *Language::Python.setup_install_args(prefix, python)
      end
    end
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <scientific.h>
      
      int main(void)
      {    
	printf(\"scientific version: %s\\n\", GetScientificVersion());
        return 0;
      }
    EOS
    system ENV.cc, "-I#{include}", "test.c", "-o", "test", "-L#{lib}", "-lscientific"
    system "./test"
    
    pythons.each do |python|
      system python, "-c", <<~EOS
        import libscientific
        assert libscientific.__version__
      EOS
    end
  end
end
