#!/bin/bash

# -s and -d options must be a path
# -i is the include pattern (regex) for filter files. I.E. : .+\.(js|json|html|css)$
# -e is the exclude pattern (regex) for filter files. I.E. : (node_modules|bower_components)

usage () {
	echo "Usage: $0 [-s <string> (source)] [-d <string> (destination)] [-i <string> (include pattern)] [-e <string> (exclude pattern)]" 1>&2;
	exit 1;
}

s='.'
d='./OUT/'
i='.'
e=''

while getopts ":s:d:i:e:" flag; do
	case $flag in
		s)
			s=${OPTARG}
			;;
		d)
			d=${OPTARG}
			;;
		i)
			i=${OPTARG}
			;;
		e)
			e=${OPTARG}
			;;
		*)
			usage
			;;
	esac
done
shift $((OPTIND-1))

echo s = $s
echo d = $d
echo i = $i
echo e = $e


SRC_DIR_PATH='./src/'
#OUTPUT_DIR_PATH='./OUT/'
#SRC_SCRIPT=`less $SRC_DIR_PATH + 'SCRIPT.html'`
#SRC_DOC=`less $SRC_DIR_PATH + 'DOC.html'`

cp -rf --copy-contents $SRC_DIR_PATH $d

ALL_FILES=`find $s|egrep "$i"`

if [ "$e" ] ; then
	ALL_FILES=`echo $ALL_FILES|sed 's/ /\n/g'|egrep -v "$e"`
fi

echo ALL_FILES = $ALL_FILES

# JS_FILES=$ALL_FILES|grep -i '\.js$'
# #echo $JS_FILES
# JSON_FILES=$ALL_FILES|grep -i '\.json$'
# echo $JSON_FILES
# HTML_FILES=$ALL_FILES|grep -i '\.html$'
# #echo $HTML_FILES
# CSS_FILES=$ALL_FILES|grep -i '\.css$'
# #echo $CSS_FILES
