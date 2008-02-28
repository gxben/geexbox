#!/bin/sh

echo "##################################################"
echo "####      MPlayer SVN Sources Packager        ####"
echo "##################################################"
echo

SVN="`which svn`"
[ -z "$SVN" ] && echo "unable to find svn binary" && exit 1

TAR="`which tar`"
[ -z "$TAR" ] && echo "unable to find tar binary" && exit 1

TRUNK=svn://svn.mplayerhq.hu/mplayer/trunk

REV=`LC_ALL=C $SVN info $TRUNK 2> /dev/null | grep -i revision | cut -d' ' -f2`
DIR=MPlayer-r$REV
TARBALL=$DIR.tar.bz2

echo -n "Downloading MPlayer r$REV source tree...       "
$SVN export -q $TRUNK $DIR
[ $? == 0 ] && echo "OK" || (echo "ERROR" && exit 1)

mkdir $DIR/.svn
echo "revision=\"$REV\"" > $DIR/.svn/entries

echo -n "Creating $TARBALL...              "
tar cjf $TARBALL $DIR
[ $? == 0 ] && echo "OK" || (echo "ERROR" && exit 1)

echo -n "Cleaning up...                                  "
rm -rf $DIR
[ $? == 0 ] && echo "OK" || (echo "ERROR" && exit 1)

echo
echo "$TARBALL created successfully!"
