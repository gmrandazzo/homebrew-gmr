class AutodockVina < Formula
  desc "Molecular docking and virtual screening program"
  homepage "https://vina.scripps.edu/"
  url "https://github.com/ccsb-scripps/AutoDock-Vina/archive/refs/tags/v1.2.5.tar.gz"
  sha256 "38aec306bff0e47522ca8f581095ace9303ae98f6a64031495a9ff1e4b2ff712"
  license "Apache-2.0"

  depends_on "boost"
  depends_on "swig"

  # Port to current Boost: <boost/filesystem/convenience.hpp> was removed,
  # Boost.System is header-only so libboost_system no longer exists, and
  # newer Boost headers require at least C++14. Upstream 1.2.5 pins Boost 1.76.
  patch :DATA

  def install
    cd "build/mac/release" do
      system "make", "BASE=#{formula_opt_prefix("boost")}"
    end
    bin.install "build/mac/release/vina", "build/mac/release/vina_split"
  end

  test do
    assert_match "AutoDock Vina v#{version}", shell_output("#{bin}/vina --version")
  end
end

__END__
diff --git a/build/mac/release/Makefile b/build/mac/release/Makefile
index 6433c33..0260524 100644
--- a/build/mac/release/Makefile
+++ b/build/mac/release/Makefile
@@ -3,7 +3,7 @@ BOOST_VERSION=
 BOOST_INCLUDE = $(BASE)/include
 C_PLATFORM=-pthread
 GPP=/usr/bin/clang++
-C_OPTIONS= -O3 -DNDEBUG -std=c++11 -fvisibility=hidden
+C_OPTIONS= -O3 -DNDEBUG -std=c++14 -fvisibility=hidden -DBOOST_TIMER_ENABLE_DEPRECATED
 BOOST_LIB_VERSION=
 BOOST_STATIC=y

diff --git a/build/makefile_common b/build/makefile_common
index 9db2a92..ff6e37f 100644
--- a/build/makefile_common
+++ b/build/makefile_common
@@ -30,7 +30,7 @@ threadmt:=$(shell if [ -f ./linktest ]; then echo "-mt"; rm ./linktest; fi;)
 $(shell rm ./linktest.cpp)

 ifeq ($(BOOST_STATIC), y)
-LIBS = ${BASE}/lib/libboost_system${BOOST_LIB_VERSION}.a ${BASE}/lib/libboost_thread${threadmt}${BOOST_LIB_VERSION}.a ${BASE}/lib/libboost_serialization${BOOST_LIB_VERSION}.a ${BASE}/lib/libboost_filesystem${BOOST_LIB_VERSION}.a ${BASE}/lib/libboost_program_options${BOOST_LIB_VERSION}.a
+LIBS = ${BASE}/lib/libboost_thread${threadmt}${BOOST_LIB_VERSION}.a ${BASE}/lib/libboost_serialization${BOOST_LIB_VERSION}.a ${BASE}/lib/libboost_filesystem${BOOST_LIB_VERSION}.a ${BASE}/lib/libboost_program_options${BOOST_LIB_VERSION}.a
 else
 LIBS = -l boost_system${BOOST_LIB_VERSION} -l boost_thread${threadmt}${BOOST_LIB_VERSION} -l boost_serialization${BOOST_LIB_VERSION} -l boost_filesystem${BOOST_LIB_VERSION} -l boost_program_options${BOOST_LIB_VERSION}#-l pthread
 endif

diff --git a/src/lib/vina.h b/src/lib/vina.h
index a44cf9b..046ac2d 100644
--- a/src/lib/vina.h
+++ b/src/lib/vina.h
@@ -35,7 +35,7 @@
 #include <boost/program_options.hpp>
 #include <boost/filesystem/fstream.hpp>
 #include <boost/filesystem/exception.hpp>
-#include <boost/filesystem/convenience.hpp> // filesystem::basename
+#include <boost/filesystem.hpp>
 #include <boost/thread/thread.hpp> // hardware_concurrency // FIXME rm ?
 #include <boost/algorithm/string.hpp>
 //#include <openbabel/mol.h>

diff --git a/src/split/split.cpp b/src/split/split.cpp
index b42e78a..14903a7 100644
--- a/src/split/split.cpp
+++ b/src/split/split.cpp
@@ -30,7 +30,7 @@
 #include <boost/program_options.hpp>
 #include <boost/filesystem/fstream.hpp>
 #include <boost/filesystem/exception.hpp>
-#include <boost/filesystem/convenience.hpp> // filesystem::basename
+#include <boost/filesystem.hpp>

 #include "file.h"
 #include "parse_error.h"
