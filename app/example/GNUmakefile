# Include your header file location
CXXFLAGS += -I. $(shell root-config --cflags) -g

CXXFLAGS += -I$(LARCV_BASEDIR)/core
CXXFLAGS += -I$(JUMBOLAIYA_COREDIR)/include

# Include your shared object lib location
LDFLAGS += $(shell larcv-config --libs)
LDFLAGS += $(shell root-config --libs) -lPhysics -lMatrix -g

# platform-specific options
OSNAME = $(shell uname -s)
include $(JUMBOLAIYA_BASEDIR)/Makefile/Makefile.${OSNAME}

# Add your program below with a space after the previous one.
# This makefile compiles all binaries specified below.
PROGRAMS = example

all:		$(PROGRAMS)

$(PROGRAMS): $(PROGRAMS).cxx
	@echo '<<compiling' $@'>>'
	@$(CXX) $@.cxx -o $@ $(CXXFLAGS) $(LDFLAGS)
	@rm -rf *.dSYM
clean:	
	rm -f $(PROGRAMS)
