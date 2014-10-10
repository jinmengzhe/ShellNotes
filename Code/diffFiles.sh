#!/bin/sh
 
file1=$1
file2=$2
file1_diff=$file1".diff"
file2_diff=$file2".diff"
tmp_result="tmp.diff"
result="result.diff"
 
diff $file1 $file2 > $tmp_result
 
cat $tmp_result | grep ">" | cut -d '&' -f 1 | cut -d ' ' -f 2 > $file1_diff
cat $tmp_result | grep "<" | cut -d '&' -f 1 | cut -d ' ' -f 2 > $file2_diff
 
diff $file1_diff $file2_diff > $result

