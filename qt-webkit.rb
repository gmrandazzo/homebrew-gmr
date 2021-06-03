class QtWebkit < Formula
  desc ""
  homepage ""
  url "https://github.com/qtwebkit/qtwebkit/releases/download/qtwebkit-5.212.0-alpha4/qtwebkit-5.212.0-alpha4.tar.xz"
  sha256 "9ca126da9273664dd23a3ccd0c9bebceb7bb534bddd743db31caf6a5a6d4a9e6"
  license "BSD"

  depends_on "cmake" => :build
  depends_on "qt@5"

  patch :DATA

  def install
    ENV.deparallelize
    cmake_args = %W[
        -DPORT=Qt
        -DCMAKE_BUILD_TYPE=Release
    ] 
    system "cmake", ".", "-DCMAKE_PREFIX_PATH=#{Formula["qt@5"].opt_lib}", *std_cmake_args, *cmake_args
    system "make"
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test qt5-webkit`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

__END__
--- qtwebkit-5.212.0-alpha4/Source/JavaScriptCore/jsc.cpp.orig	2021-06-03 13:09:01.000000000 +0200
+++ qtwebkit-5.212.0-alpha4/Source/JavaScriptCore/jsc.cpp	2021-06-03 13:09:39.000000000 +0200
@@ -189,7 +189,7 @@
 
 class ElementHandleOwner : public WeakHandleOwner {
 public:
-    bool isReachableFromOpaqueRoots(Handle<JSC::Unknown> handle, void*, SlotVisitor& visitor) override
+    bool isReachableFromOpaqueRoots(JSC::Handle<JSC::Unknown> handle, void*, SlotVisitor& visitor) override
     {
         Element* element = jsCast<Element*>(handle.slot()->asCell());
         return visitor.containsOpaqueRoot(element->root());
--- qtwebkit-5.212.0-alpha4/Source/JavaScriptCore/assembler/ARM64Assembler.h.orig	2021-06-03 11:05:40.000000000 +0200
+++ qtwebkit-5.212.0-alpha4/Source/JavaScriptCore/assembler/ARM64Assembler.h	2021-06-03 11:06:52.000000000 +0200
@@ -30,6 +30,7 @@
 
 #include "AssemblerBuffer.h"
 #include "AssemblerCommon.h"
+#include <libkern/OSCacheControl.h>
 #include <limits.h>
 #include <wtf/Assertions.h>
 #include <wtf/Vector.h>
@@ -2664,7 +2665,7 @@
 
     static void cacheFlush(void* code, size_t size)
     {
-#if OS(IOS)
+#if OS(IOS) || defined(__APPLE__)
         sys_cache_control(kCacheFunctionPrepareForExecution, code, size);
 #elif OS(LINUX)
         size_t page = pageSize();
