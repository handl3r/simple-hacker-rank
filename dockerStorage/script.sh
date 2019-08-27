#!/bin/bash
# Use: ./script.sh ruby rubyfile.rb result.txt
# for example . to copy file a.doc to b.doc : ./script.sh cat a.doc b.doc
# => compiler = cat  file = a.doc      output = b.doc
compiler=$1
file=$2
output=$3
echo "compiler:" "$1"
echo "file:" "$2"
echo "output:" "$3"

START=$(date +%s.%4N)

$compiler $file > $output

END=$(date +%s.%4N)

runtime=$(echo "$END - $START" | bc)

echo $runtime