class Autodock4 < Formula
  desc "Automated docking tools for predicting ligand-receptor interactions"
  homepage "https://github.com/ccsb-scripps/AutoDock4"
  url "https://github.com/ccsb-scripps/AutoDock4.git", revision: "HEAD"
  version "4.2.6"
  license "GPL-2.0"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "gcc"

  patch :DATA, "-F3"

  def install
    system "autoreconf", "-i"
    mkdir "build" do
      system "../configure", "--prefix=#{prefix}"
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/autodock4", "-v"
  end
end

__END__
diff --git a/eval.cc b/eval.cc
index 383d0f9..9f57c6a 100644
--- a/eval.cc
+++ b/eval.cc
@@ -218,9 +218,9 @@ double Eval::eval(const int term)
    // increment evaluation counter only for "total energy" case
    if(term==3) num_evals++;
 
-   if ((!finite(energy)) || ISNAN(energy)) {
+   if ((!isfinite(energy)) || ISNAN(energy)) {
       (void)fprintf( logFile, "eval.cc:  ERROR!  energy is %s!\n\n",
-       (!finite(energy))?"infinite":"not a number");
+       (!isfinite(energy))?"infinite":"not a number");
 #define DUMMYATOMSTUFFINF "ATOM  #####  C   INF X   1    "
 #define DUMMYATOMSTUFFNAN "ATOM  #####  C   NAN X   1    "
       for (i=0; i<natom; i++) {