#!/bin/bash

# clean up previously set env
if [[ -z $FORCE_JUMBOLAIYA_BASEDIR ]]; then
    where="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    export JUMBOLAIYA_BASEDIR=${where}
else
    export JUMBOLAIYA_BASEDIR=$FORCE_JUMBOLAIYA_BASEDIR
fi

if [[ -z $JUMBOLAIYA_BUILDDIR ]]; then
    export JUMBOLAIYA_BUILDDIR=$JUMBOLAIYA_BASEDIR/build
fi

export JUMBOLAIYA_COREDIR=$JUMBOLAIYA_BASEDIR/jumbolaiya
export JUMBOLAIYA_APPDIR=$JUMBOLAIYA_BASEDIR/app
export JUMBOLAIYA_LIBDIR=$JUMBOLAIYA_BUILDDIR/lib
export JUMBOLAIYA_INCDIR=$JUMBOLAIYA_COREDIR/include
export JUMBOLAIYA_SRCDIR=$JUMBOLAIYA_COREDIR/src
export JUMBOLAIYA_BINDIR=$JUMBOLAIYA_BUILDDIR/bin

# Abort if ROOT not installed. Let's check rootcint for this.
if [ `command -v rootcling` ]; then
    export JUMBOLAIYA_ROOT6=1
else 
    if [[ -z `command -v rootcint` ]]; then
	echo
	echo Looks like you do not have ROOT installed.
	echo You cannot use LArCV/Jumbolaiya w/o ROOT!
	echo Aborting.
	echo
	return 1;
    fi
fi

echo
printf "\033[93mLArCV\033[00m FYI shell env. may useful for external packages:\n"
printf "    \033[95mJUMBOLAIYA_INCDIR\033[00m   = $JUMBOLAIYA_INCDIR\n"
printf "    \033[95mJUMBOLAIYA_LIBDIR\033[00m   = $JUMBOLAIYA_LIBDIR\n"
printf "    \033[95mJUMBOLAIYA_BUILDDIR\033[00m = $JUMBOLAIYA_BUILDDIR\n"

export PATH=$JUMBOLAIYA_BASEDIR/bin:$JUMBOLAIYA_BINDIR:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$JUMBOLAIYA_LIBDIR
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$JUMBOLAIYA_LIBDIR

mkdir -p $JUMBOLAIYA_BUILDDIR;
mkdir -p $JUMBOLAIYA_LIBDIR;
mkdir -p $JUMBOLAIYA_BINDIR;

export LD_LIBRARY_PATH=$JUMBOLAIYA_LIBDIR:$LD_LIBRARY_PATH
export PYTHONPATH=$JUMBOLAIYA_BASEDIR/python:$PYTHONPATH

#if [[ $LARLITE_BASEDIR ]]; then
#    printf "\033[93mLArLite\033[00m\n"
#    echo "    Found larlite set up @ \$LARLITE_BASEDIR=${LARLITE_BASEDIR}"
#else
#    printf "\033[93mLArLite\033[00m\n"
#    echo "    Missing larlite. Required dependency."
#    return 1;
#fi

if [[ $LARCV_BASEDIR ]]; then
    printf "\033[93mLarcv\033[00m\n"
    echo "    Found larcv set up @ \$LARCV_BASEDIR=${LARCV_BASEDIR}"
else
    printf "\033[93mLarcv\033[00m\n"
    echo "    Missing larcv. Required dependency."
    return 1;
fi

# Check OpenCV
export JUMBOLAIYA_OPENCV=1
if [[ -z $OPENCV_INCDIR ]]; then
    export JUMBOLAIYA_OPENCV=0
fi
if [[ -z $OPENCV_LIBDIR ]]; then
    export JUMBOLAIYA_OPENCV=0
fi


export JUMBOLAIYA_CXX=clang++
if [ -z `command -v $JUMBOLAIYA_CXX` ]; then
    export JUMBOLAIYA_CXX=g++
    if [ -z `command -v $JUMBOLAIYA_CXX` ]; then
        echo
        echo Looks like you do not have neither clang or g++!
        echo You need one of those to compile ... Abort config...
        echo
        return 1;
    fi
fi

echo
echo "Finish configuration. To build, type:"
echo "> cd \$JUMBOLAIYA_BUILDDIR"
echo "> make "
echo
