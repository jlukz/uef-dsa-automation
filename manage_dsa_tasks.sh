#!/bin/bash

# This script provides a unified workflow for managing your DSA tasks.
# It automatically prepares the submission files and then compiles and runs the tests.
# This combines the functionality of `prepare_weekly_submission.sh` and `run_java_tasks.sh`.

# --- CONFIGURATION ---
# The parent directory containing all your weekly course folders (e.g., 'week1', 'week2').
COURSE_BASE_DIR="."
# The path to your script for preparing the weekly files.
PREPARE_SCRIPT="prepare_weekly_submission.sh"

# --- MAIN SCRIPT LOGIC ---
echo "--- DSA Task Manager ---"

# Check if both arguments were provided.
if [ "$#" -ne 2 ]; then
    echo "Error: This script requires two arguments."
    echo "Usage: $0 <week_number> <task_id>"
    echo "Example: $0 3 X3"
    exit 1
fi

WEEK_NUM=$1
TASK_ID=$2
SUBMISSION_DIR="${COURSE_BASE_DIR}/week${WEEK_NUM}/submission"

# 1. Check if the submission directory exists.
if [ ! -d "$SUBMISSION_DIR" ]; then
    echo "Submission directory for Week ${WEEK_NUM} not found."
    echo "Running the preparation script to get the files..."

    # Call the preparation script with user input.
    # Note: This uses a trick to send input to the sub-script non-interactively.
    echo -e "${WEEK_NUM}\n${TASK_ID}" | sh "${PREPARE_SCRIPT}"

    # Check if the preparation was successful before continuing.
    if [ ! -d "$SUBMISSION_DIR" ]; then
        echo "Error: File preparation failed. Exiting."
        exit 1
    fi
else
    echo "Submission files for Week ${WEEK_NUM} already exist."
fi

# 2. Compile and run the tests.
echo "Moving to the submission directory..."
cd "$SUBMISSION_DIR" || exit

echo "Compiling all Java files..."
javac *.java

if [ $? -eq 0 ]; then
    echo "Compilation successful. Running tests for TRAI_25_${TASK_ID}_test..."
    java TRAI_25_${TASK_ID}_test
else
    echo "Compilation failed. Please fix the errors in your code."
fi
