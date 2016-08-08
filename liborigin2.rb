require "formula"

class Liborigin2 < Formula
  homepage "http://software.proindependent.com/liborigin2/"
  url "https://downloads.sourceforge.net/project/qtiplot.berlios/liborigin2-20110829.zip"
  sha256 "51ebf6de57d2b44cd6f5ab772ed92154eec9598a14a6655967ebcf2d7f8da0a2"

  depends_on "boost"
  depends_on "qt"

  patch :DATA

  def install
    system "curl -L http://tree.phi-sci.com/tree.hh -o tree.hh"
    system "qmake", "PREFIX=#{prefix}"
    system "make"
    system "make", "install"
  end
end

__END__
--- liborigin2/liborigin2.pro.back	2014-10-29 13:15:36.000000000 +0100
+++ liborigin2/liborigin2.pro	2014-10-29 14:11:30.000000000 +0100
@@ -1,3 +1,7 @@
+isEmpty(PREFIX) {
+  PREFIX = /usr/local
+}
+
 TARGET       = origin2
 TEMPLATE     = lib
 CONFIG      += warn_on release thread
@@ -9,6 +13,8 @@
 OBJECTS_DIR  = ./tmp
 
 DESTDIR      = ./
+QT     -= gui core
+LIBS   -= -lQtGui -lQtCore
 
 # Uncomment the following line if you want to disable logging.
 #DEFINES += NO_LOG_FILE
@@ -17,3 +23,6 @@
 INCLUDEPATH += ../boost
 
 include(liborigin2.pri)
+target.path = $$PREFIX/lib
+headers.path = $$PREFIX/include
+INSTALLS = target headers
--- liborigin2/OriginObj.h.back	2014-10-29 14:08:42.000000000 +0100
+++ liborigin2/OriginObj.h	2014-10-29 14:10:49.000000000 +0100
@@ -32,6 +32,7 @@
 #ifndef ORIGIN_OBJ_H
 #define ORIGIN_OBJ_H
 
+#include <iostream>
 #include <string.h>
 #include <vector>
 #include "boost/variant.hpp"
