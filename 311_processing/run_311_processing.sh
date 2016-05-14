#!/bin/bash
APPLICATION=$1
INPUT=${@:2:$#-4}
OTHERS=(${@:$#-2})
OUTPUT=${OTHERS[@]:0:1}
LOCAL_OUTPUT=${OTHERS[@]:1:1}
NUM_EXECS=${OTHERS[@]:2:1}
NAME="BDMA 311 Filtering"

HD=hadoop
SP=spark-submit

$HD fs -rm -r -skipTrash $OUTPUT
$SP --name "$NAME" --num-executors $NUM_EXECS $APPLICATION $INPUT $OUTPUT
rm -f $LOCAL_OUTPUT
$HD fs -cat $OUTPUT/part*  | tr -d '() ' > $LOCAL_OUTPUT
