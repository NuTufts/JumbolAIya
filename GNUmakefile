
ifndef JUMBOLAIYA_BASEDIR
ERROR_MESSAGE := $(error LARLITECV_BASEDIR is not set... run configure.sh!)
endif

#ifndef LARLITE_BASEDIR
#ERROR_MESSAGE := $(error LARLITE_BASEDIR is not set... run configure.sh!)
#endif

ifndef LARCV_BASEDIR
ERROR_MESSAGE := $(error LARCV_BASEDIR is not set... run configure.sh!)
endif

OSNAME          = $(shell uname -s)
HOST            = $(shell uname -n)
OSNAMEMODE      = $(OSNAME)

include $(JUMBOLAIYA_BASEDIR)/Makefile/Makefile.${OSNAME}

CORE_SUBDIRS := src
#ifeq ($(LARLITECV_NUMPY),1)
#CORE_SUBDIRS += PyUtil
#endif
#ifeq ($(LARLITECV_OPENCV),1)
#  CORE_SUBDIRS += CVUtil
#endif

#APP_SUBDIRS := TaggerTypes Combinator GeneralFlashMatchAlgo GapChs UnipolarHack ChargeSegmentAlgos T3DMerge ThruMu StopMu UntaggedClustering SCE ContainedROI TaggerCROI
#APP_SUBDIRS += MCTruthTools
ifeq ($(JUMBOLAIYA_OPENCV),1)
  APP_SUBDIRS += 
endif


.phony: all clean

all: obj lib bin

clean: clean_app clean_core
	@rm -f $(JUMBOLAIYA_LIBDIR)/libjumbolaiya.so
clean_core:
	@for i in $(CORE_SUBDIRS); do ( echo "" && echo "Cleaning $$i..." && cd $(JUMBOLAIYA_COREDIR)/$$i && rm -rf $(JUMBOLAIYA_BUILDDIR)/$$i && rm -rf $(JUMBOLAIYA_BUILDDIR)/lib/*$ii.* ) || exit $$?; done
clean_app:
	@for i in $(APP_SUBDIRS); do ( echo "" && echo "Cleaning $$i..." && cd $(JUMBOLAIYA_APPDIR)/$$i && rm -rf $(JUMBOLAIYA_BUILDDIR)/$$i && rm -rf $(JUMBOLAIYA_BUILDDIR)/lib/*$ii.* ) || exit $$?; done

obj:
	@echo
	@echo Building core...
	@echo
	@for i in $(CORE_SUBDIRS); do ( echo "" && echo "Compiling $$i..." && cd $(JUMBOLAIYA_COREDIR)/$$i && $(MAKE) ) || exit $$?; done
	@echo Building app...
	@for i in $(APP_SUBDIRS); do ( echo "" && echo "Compiling $$i..." && cd $(JUMBOLAIYA_APPDIR)/$$i && $(MAKE) ) || exit $$?; done

lib: obj
	@ echo
	@ if [ `python ${JUMBOLAIYA_BASEDIR}/bin/libarg.py build` ]; then \
	    echo Linking library...; \
	    $(SOMAKER) $(SOFLAGS) $(shell python $(JUMBOLAIYA_BASEDIR)/bin/libarg.py); \
	  else \
	   echo Nothing to be done for lib...; \
	fi
	@echo 

bin: obj lib
	@echo
	@echo Building run_tagger bin
	@make --directory=$(JUMBOLAIYA_BASEDIR)/app/TaggerCROI/bin clean
	@make --directory=$(JUMBOLAIYA_BASEDIR)/app/TaggerCROI/bin
	@ln -fs $(JUMBOLAIYA_BASEDIR)/app/TaggerCROI/bin/run_tagger $(JUMBOLAIYA_BASEDIR)/bin/run_tagger
	@echo Building analysis routines
	@make --directory=$(JUMBOLAIYA_BASEDIR)/app/AnalyzeTagger
	@ln -fs $(JUMBOLAIYA_BASEDIR)/app/AnalyzeTagger/run_pixel_analysis $(JUMBOLAIYA_BASEDIR)/bin/run_pixel_analysis

