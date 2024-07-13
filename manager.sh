#!/bin/bash

PIPE_NAME="pipe"
PIPE_DUMMY="other"
OUTPUT_FILE="output.txt"
CLEAN_FILE="clean.txt"
IMPORTS="import MyProject.Basic import Mathlib.Logic.Godel.GodelBetaFunction import Mathlib.Logic.Lemmas "

# Remove any existing pipes and output files
rm -f $PIPE_NAME $PIPE_DUMMY $OUTPUT_FILE $CLEAN_FILE

mkfifo $PIPE_NAME
mkfifo $PIPE_DUMMY

# use the dummy pipe to keep the pipe open
cat $PIPE_DUMMY > $PIPE_NAME &

# Adjust this path to your own Lean project if needed.
export `lake env  --dir ./myProject`

echo "Starting repl ..."
# Start process, redirecting input and output
./repl/.lake/build/bin/repl < pipe > $OUTPUT_FILE &

MY_PID=$!

printf "Lean repl is running with process: %s\n" $MY_PID

# initialize enviromnent with imports
(printf "{ \"cmd\" : \" $IMPORTS \" }\n\n") > pipe

# Ensure process is terminated when this script exits
trap "echo cleaning up; kill $MY_PID; rm -f $PIPE_NAME $PIPE_DUMMY $OUTPUT_FILE $CLEAN_FILE" EXIT

wait $MY_PID
echo "Process ended, manager is quitting."
