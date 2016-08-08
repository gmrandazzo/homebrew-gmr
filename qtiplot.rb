require "formula"

class Qtiplot < Formula
  homepage "http://www.qtiplot.com"
  url "https://downloads.sourceforge.net/project/qtiplot.berlios/qtiplot-0.9.8.9.tar.bz2"
  sha256 "a523ea259516d7581abaf2fe376507d152db32f71d88176cff18f5bc391b9ef0"

  depends_on "alglib"
  depends_on "gsl"
  depends_on "liborigin2"
  depends_on "libpng"
  depends_on "muparser"
  depends_on "qt" => [:recommended, "with-qt3support"]
  depends_on "qt-assistant-compat"
  depends_on "quazip"
  depends_on "sip"
  depends_on "pyqt"
  depends_on "tamuanova"

  patch :DATA

  def install
    File.open("#{buildpath}/build.conf", "w") do |f|
      f.puts("SYS_INCLUDEPATH = /usr/local/include")
      f.puts("SYS_LIBS = -L/usr/local/lib")
      f.puts("MUPARSER_LIBS = -lmuparser")
      f.puts("GSL_LIBS = -lgsl -lgslcblas")
      f.puts("QWT_INCLUDEPATH = $$QTI_ROOT/3rdparty/qwt/src")
      f.puts("QWT_LIBS = $$QTI_ROOT/3rdparty/qwt/lib/libqwt.a")
      f.puts("QWT3D_INCLUDEPATH = $$QTI_ROOT/3rdparty/qwtplot3d/include")
      f.puts("QWT3D_LIBS = $$QTI_ROOT/3rdparty/qwtplot3d/lib/libqwtplot3d.a")
      f.puts("LIBPNG_LIBS = -lpng")
      f.puts("ALGLIB_INCLUDEPATH = $$SYS_INCLUDEPATH/alglib/")
      f.puts("ALGLIB_LIBS = -lalglib")
      f.puts("TAMUANOVA_LIBS = -ltamuanova")
      f.puts("LIBORIGIN_LIBS = -lorigin2")
      f.puts("PYTHON = python")
      f.puts("LUPDATE = lupdate")
      f.puts("LRELEASE = lrelease")
      f.puts("contains( TARGET, qtiplot ) {")
      f.puts("  SCRIPTING_LANGS += muParser")
      f.puts("  DEFINES         += SCRIPTING_CONSOLE")
      f.puts("  CONFIG          += release")
      f.puts("}")
    end
    system "qmake", "PREFIX=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "false"
  end
end

__END__
diff -Naur qtiplot-0.9.8.9/3rdparty/qwt/src/src.pro qtiplot-0.9.8.9.patch.ok/3rdparty/qwt/src/src.pro
--- qtiplot-0.9.8.9/3rdparty/qwt/src/src.pro	2010-10-07 17:17:13.000000000 +0200
+++ qtiplot-0.9.8.9.patch.ok/3rdparty/qwt/src/src.pro	2014-09-12 00:41:47.000000000 +0200
@@ -221,4 +221,4 @@
     doc.files      += $${QWT_ROOT}/doc/man
 }
 
-INSTALLS       = target headers doc
+#INSTALLS       = target headers doc
diff -Naur qtiplot-0.9.8.9/3rdparty/qwtplot3d/3rdparty/gl2ps/gl2ps.c qtiplot-0.9.8.9.patch.ok/3rdparty/qwtplot3d/3rdparty/gl2ps/gl2ps.c
--- qtiplot-0.9.8.9/3rdparty/qwtplot3d/3rdparty/gl2ps/gl2ps.c	2011-08-23 11:57:54.000000000 +0200
+++ qtiplot-0.9.8.9.patch.ok/3rdparty/qwtplot3d/3rdparty/gl2ps/gl2ps.c	2014-09-11 23:52:45.000000000 +0200
@@ -42,13 +42,10 @@
 #include <time.h>
 #include <float.h>
 
-#if defined(GL2PS_HAVE_ZLIB)
 #include <zlib.h>
-#endif
 
-#if defined(GL2PS_HAVE_LIBPNG)
 #include <png.h>
-#endif
+
 
 /*********************************************************************
  *
diff -Naur qtiplot-0.9.8.9/3rdparty/qwtplot3d/include/qwt3d_openglhelper.h qtiplot-0.9.8.9.patch.ok/3rdparty/qwtplot3d/include/qwt3d_openglhelper.h
--- qtiplot-0.9.8.9/3rdparty/qwtplot3d/include/qwt3d_openglhelper.h	2011-08-24 12:25:09.000000000 +0200
+++ qtiplot-0.9.8.9.patch.ok/3rdparty/qwtplot3d/include/qwt3d_openglhelper.h	2014-09-11 23:52:45.000000000 +0200
@@ -1,6 +1,6 @@
 #ifndef __openglhelper_2003_06_06_15_49__
 #define __openglhelper_2003_06_06_15_49__
-
+#include <glu.h>
 #include "qglobal.h"
 #if QT_VERSION < 0x040000
 #include <qgl.h>
diff -Naur qtiplot-0.9.8.9/3rdparty/qwtplot3d/qwtplot3d.pro qtiplot-0.9.8.9.patch.ok/3rdparty/qwtplot3d/qwtplot3d.pro
--- qtiplot-0.9.8.9/3rdparty/qwtplot3d/qwtplot3d.pro	2011-08-24 16:54:38.000000000 +0200
+++ qtiplot-0.9.8.9.patch.ok/3rdparty/qwtplot3d/qwtplot3d.pro	2014-09-12 00:42:09.000000000 +0200
@@ -36,5 +36,5 @@
 LIBS        += ../libpng/libpng.a
 
 # install
-target.path = lib
-INSTALLS += target
+#target.path = lib
+#INSTALLS += target
diff -Naur qtiplot-0.9.8.9/fitPlugins/exp_saturation/exp_saturation.pro qtiplot-0.9.8.9.patch.ok/fitPlugins/exp_saturation/exp_saturation.pro
--- qtiplot-0.9.8.9/fitPlugins/exp_saturation/exp_saturation.pro	2009-08-14 13:27:08.000000000 +0200
+++ qtiplot-0.9.8.9.patch.ok/fitPlugins/exp_saturation/exp_saturation.pro	2014-09-12 00:52:42.000000000 +0200
@@ -19,7 +19,7 @@
 INCLUDEPATH += $$GSL_INCLUDEPATH
 LIBS        += $$GSL_LIBS
 
-target.path=/usr/lib$${libsuff}/qtiplot/plugins
+target.path=$$PREFIX/lib/qtiplot/plugins
 INSTALLS += target
 
 SOURCES += exp_saturation.c
diff -Naur qtiplot-0.9.8.9/fitPlugins/explin/explin.pro qtiplot-0.9.8.9.patch.ok/fitPlugins/explin/explin.pro
--- qtiplot-0.9.8.9/fitPlugins/explin/explin.pro	2009-08-13 23:27:00.000000000 +0200
+++ qtiplot-0.9.8.9.patch.ok/fitPlugins/explin/explin.pro	2014-09-12 00:53:02.000000000 +0200
@@ -19,7 +19,7 @@
 INCLUDEPATH += $$GSL_INCLUDEPATH
 LIBS        += $$GSL_LIBS
 
-target.path=/usr/lib$${libsuff}/qtiplot/plugins
+target.path=$$PREFIX/lib/qtiplot/plugins
 INSTALLS += target
 
 SOURCES += explin.c
diff -Naur qtiplot-0.9.8.9/fitPlugins/fitRational0/fitRational0.pro qtiplot-0.9.8.9.patch.ok/fitPlugins/fitRational0/fitRational0.pro
--- qtiplot-0.9.8.9/fitPlugins/fitRational0/fitRational0.pro	2009-08-13 23:27:00.000000000 +0200
+++ qtiplot-0.9.8.9.patch.ok/fitPlugins/fitRational0/fitRational0.pro	2014-09-12 00:53:20.000000000 +0200
@@ -19,7 +19,7 @@
 INCLUDEPATH += $$GSL_INCLUDEPATH
 LIBS        += $$GSL_LIBS
 
-target.path=/usr/lib$${libsuff}/qtiplot/plugins
+target.path=$$PREFIX/lib/qtiplot/plugins
 INSTALLS += target
 
 SOURCES += fitRational0.cpp
diff -Naur qtiplot-0.9.8.9/fitPlugins/fitRational1/fitRational1.pro qtiplot-0.9.8.9.patch.ok/fitPlugins/fitRational1/fitRational1.pro
--- qtiplot-0.9.8.9/fitPlugins/fitRational1/fitRational1.pro	2009-08-13 23:27:00.000000000 +0200
+++ qtiplot-0.9.8.9.patch.ok/fitPlugins/fitRational1/fitRational1.pro	2014-09-12 00:52:00.000000000 +0200
@@ -19,7 +19,7 @@
 INCLUDEPATH += $$GSL_INCLUDEPATH
 LIBS        += $$GSL_LIBS
 
-target.path=/usr/lib$${libsuff}/qtiplot/plugins
+target.path=$$PREFIX/lib/qtiplot/plugins
 INSTALLS += target
 
 SOURCES += fitRational1.cpp
diff -Naur qtiplot-0.9.8.9/fitPlugins/planck_wavelength/planck_wavelength.pro qtiplot-0.9.8.9.patch.ok/fitPlugins/planck_wavelength/planck_wavelength.pro
--- qtiplot-0.9.8.9/fitPlugins/planck_wavelength/planck_wavelength.pro	2009-08-13 23:27:00.000000000 +0200
+++ qtiplot-0.9.8.9.patch.ok/fitPlugins/planck_wavelength/planck_wavelength.pro	2014-09-12 00:52:27.000000000 +0200
@@ -13,12 +13,12 @@
 CONFIG += release
 DESTDIR = ../
 
-INSTALLS += target
+#INSTALLS += target
  
 INCLUDEPATH += $$GSL_INCLUDEPATH
 LIBS        += $$GSL_LIBS
 
-target.path=/usr/lib$${libsuff}/qtiplot/plugins
+target.path=$$PREFIX/lib/qtiplot/plugins
 
 SOURCES = planck_wavelength.c
 
diff -Naur qtiplot-0.9.8.9/qtiplot/qtiplot.pro qtiplot-0.9.8.9.patch.ok/qtiplot/qtiplot.pro
--- qtiplot-0.9.8.9/qtiplot/qtiplot.pro	2011-11-02 17:55:25.000000000 +0100
+++ qtiplot-0.9.8.9.patch.ok/qtiplot/qtiplot.pro	2014-09-14 21:08:11.000000000 +0200
@@ -20,6 +20,8 @@
 LIBS         += $$QWT_LIBS
 LIBS         += $$QWT3D_LIBS
 LIBS         += $$GSL_LIBS
+LIBS         += -lz
+LIBS         += -F/usr/local/lib -framework QtAssistant
 
 #############################################################################
 ###################### BASIC PROJECT PROPERTIES #############################
@@ -34,42 +36,28 @@
 }
 
 CONFIG        += qt warn_on exceptions opengl thread
-CONFIG        += assistant
-win32:CONFIG  += qaxcontainer
 
 DEFINES       += QT_PLUGIN
-contains(CONFIG, CustomInstall){
-	INSTALLS        += target
-	INSTALLS        += translations
-	INSTALLS        += manual
-	INSTALLS        += documentation
-	unix:INSTALLS        += man
-
-	unix: INSTALLBASE = /usr
-	win32: INSTALLBASE = C:/QtiPlot
-
-	unix: target.path = $$INSTALLBASE/bin
-	unix: translations.path = $$INSTALLBASE/share/qtiplot/translations
-	unix: manual.path = $$INSTALLBASE/share/doc/qtiplot/manual
-	unix: documentation.path = $$INSTALLBASE/share/doc/qtiplot
-	unix: man.path = $$INSTALLBASE/share/man/man1/
-
-	win32: target.path = $$INSTALLBASE
-	win32: translations.path = $$INSTALLBASE/translations
-	win32: manual.path = $$INSTALLBASE/manual
-	win32: documentation.path = $$INSTALLBASE/doc
-
-	DEFINES       += TRANSLATIONS_PATH="\\\"$$replace(translations.path," ","\ ")\\\"
-	DEFINES       += MANUAL_PATH="\\\"$$replace(manual.path," ","\ ")\\\"
-	}
+INSTALLS        += target
+INSTALLS        += translations
+INSTALLS        += manual
+INSTALLS        += documentation
+INSTALLS        += man
+
+INSTALLBASE = $$PREFIX
+
+
+target.path = $$INSTALLBASE/bin
+translations.path = $$INSTALLBASE/share/qtiplot/translations
+manual.path = $$INSTALLBASE/share/doc/qtiplot/manual
+documentation.path = $$INSTALLBASE/share/doc/qtiplot
+man.path = $$INSTALLBASE/share/man/man1/
+
+
+DEFINES       += TRANSLATIONS_PATH="\\\"$$replace(translations.path," ","\ ")\\\"
+DEFINES       += MANUAL_PATH="\\\"$$replace(manual.path," ","\ ")\\\"
 
 QT            += opengl qt3support network svg xml
-contains(CONFIG, StaticBuild){
-	QTPLUGIN += qjpeg qgif qtiff qmng qsvg
-	DEFINES += QTIPLOT_STATIC_BUILD
-} else {
-	win32:DEFINES += QT_DLL QT_THREAD_SUPPORT
-}
 
 MOC_DIR        = ../tmp/qtiplot
 OBJECTS_DIR    = ../tmp/qtiplot
@@ -120,13 +108,12 @@
 
 ###################### DOCUMENTATION ########################################
 
-manual.files += ../manual/html \
-                ../manual/qtiplot-manual-en.pdf
+manual.files += ../manual/html
 
 documentation.files += ../README.html \
                        ../gpl_licence.txt
 
-unix: man.files += ../qtiplot.1
+man.files += ../qtiplot.1
 
 ###############################################################
 ##################### Compression (zlib-1.2.3) ################
diff -Naur qtiplot-0.9.8.9/qtiplot/src/core/ApplicationWindow.cpp qtiplot-0.9.8.9.patch.ok/qtiplot/src/core/ApplicationWindow.cpp
--- qtiplot-0.9.8.9/qtiplot/src/core/ApplicationWindow.cpp	2011-11-01 13:21:13.000000000 +0100
+++ qtiplot-0.9.8.9.patch.ok/qtiplot/src/core/ApplicationWindow.cpp	2014-09-14 17:19:11.000000000 +0200
@@ -174,7 +174,7 @@
 #include <QVarLengthArray>
 #include <QList>
 #include <QUrl>
-#include <QAssistantClient>
+#include <QtAssistant/QtAssistant>
 #include <QFontComboBox>
 #include <QSpinBox>
 #include <QMdiArea>
@@ -16228,11 +16228,12 @@
 	if (hostInfo.error() != QHostInfo::NoError){
 		QApplication::restoreOverrideCursor();
 		QMessageBox::critical(this, tr("QtiPlot - Error"), qtiplotWeb + ": " + hostInfo.errorString());
-		exit(0);
+		QApplication::restoreOverrideCursor();
+	}
+	else {
+		QApplication::restoreOverrideCursor();
+		showDonationsPage();
 	}
-
-	QApplication::restoreOverrideCursor();
-	showDonationsPage();
 }
 
 void ApplicationWindow::parseCommandLineArguments(const QStringList& args)
@@ -18856,7 +18857,7 @@
 	words.append("cell");
 #ifdef SCRIPTING_PYTHON
 	if (scriptEnv->name() == QString("Python")){
-		QString fn = d_python_config_folder + "/qti_wordlist.txt";
+		QString fn = "/usr/share/qtiplot/qti_wordlist.txt";
 		QFile file(fn);
 		if (!file.open(QFile::ReadOnly)){
 			QMessageBox::critical(this, tr("QtiPlot - Warning"),
diff -Naur qtiplot-0.9.8.9/qtiplot/src/core/QtiPlotApplication.cpp qtiplot-0.9.8.9.patch.ok/qtiplot/src/core/QtiPlotApplication.cpp
--- qtiplot-0.9.8.9/qtiplot/src/core/QtiPlotApplication.cpp	2011-10-25 11:56:27.000000000 +0200
+++ qtiplot-0.9.8.9.patch.ok/qtiplot/src/core/QtiPlotApplication.cpp	2014-09-12 00:06:27.000000000 +0200
@@ -59,9 +59,6 @@
 
 		ApplicationWindow *mw = new ApplicationWindow(factorySettings);
 		mw->restoreApplicationGeometry();
-	#if (!defined(QTIPLOT_PRO) && !defined(QTIPLOT_DEMO) && !defined(Q_WS_X11))
-		mw->showDonationDialog();
-	#endif
 		if (mw->autoSearchUpdates){
 			mw->autoSearchUpdatesRequest = true;
 			mw->searchForUpdates();
@@ -190,9 +187,7 @@
 		return;
 
 	mw->restoreApplicationGeometry();
-#if (!defined(QTIPLOT_PRO) && !defined(QTIPLOT_DEMO) && !defined(Q_WS_X11))
-	mw->showDonationDialog();
-#endif
+
 	mw->initWindow();
 
 	updateDockMenu();
diff -Naur qtiplot-0.9.8.9/qtiplot/src/table/Table.cpp qtiplot-0.9.8.9.patch.ok/qtiplot/src/table/Table.cpp
--- qtiplot-0.9.8.9/qtiplot/src/table/Table.cpp	2011-09-13 13:20:29.000000000 +0200
+++ qtiplot-0.9.8.9.patch.ok/qtiplot/src/table/Table.cpp	2014-09-12 18:41:08.000000000 +0200
@@ -564,7 +564,7 @@
 	QApplication::setOverrideCursor(QCursor(Qt::WaitCursor));
 
     muParserScript *mup = new muParserScript(scriptEnv, cmd, this,  QString("<%1>").arg(colName(col)));
-    double *r = mup->defineVariable("i");
+    double *r = mup->defineVariable("i",startRow + 1.0);
     mup->defineVariable("j", (double)col);
     mup->defineVariable("sr", startRow + 1.0);
     mup->defineVariable("er", endRow + 1.0);
diff -Naur qtiplot-0.9.8.9/qtiplot.pro qtiplot-0.9.8.9.patch.ok/qtiplot.pro
--- qtiplot-0.9.8.9/qtiplot.pro	2010-09-20 19:08:10.000000000 +0200
+++ qtiplot-0.9.8.9.patch.ok/qtiplot.pro	2014-09-14 17:16:08.000000000 +0200
@@ -1,7 +1,6 @@
 TEMPLATE = subdirs
 
 SUBDIRS = fitPlugins \
-	    manual \
 	    3rdparty/qwt \
 		3rdparty/qwtplot3d \
         qtiplot
