#!/bin/bash

# This script prepares the files for a new DSA task. It downloads the
# skeleton and test files and renames them to match the required submission format.

# --- CONFIGURATION ---
# The base URL to download the files from.
DOWNLOAD_BASE_URL="https://cs.uef.fi/pages/sjuva/tra1.esimerkit"
# Your student ID, used for renaming the main solution file.
STUDENT_ID="jlukak"

# --- MAIN SCRIPT LOGIC ---

echo "--- DSA File Preparation ---"

# Use command-line arguments if provided, otherwise prompt the user.
if [ -n "$1" ] && [ -n "$2" ]; then
    WEEK_NUM=$1
    TASK_ID=$2
else
    echo "Enter the week number (e.g., 2):"
    read -r WEEK_NUM
    echo "Enter the task ID (e.g., X2):"
    read -r TASK_ID
fi

# Set file names based on the course's format.
SKELETON_FILE_NAME="TRAI_25_${TASK_ID}_skeleton.java"
TEST_FILE_NAME="TRAI_25_${TASK_ID}_test.java"
FINAL_SOLUTION_FILE="TRAI_25_${TASK_ID}_${STUDENT_ID}.java"

# Define the local paths where the files will be saved.
WEEK_DIR="week${WEEK_NUM}"
SUBMISSION_DIR="${WEEK_DIR}/submission"
DOWNLOAD_URL="${DOWNLOAD_BASE_URL}"

# Create the submission directory if it doesn't exist.
echo "Creating directory: ${SUBMISSION_DIR}"
mkdir -p "${SUBMISSION_DIR}"

# Download the skeleton and test files.
echo "Downloading files from the server..."
curl -s "${DOWNLOAD_URL}/${SKELETON_FILE_NAME}" -o "${SUBMISSION_DIR}/${SKELETON_FILE_NAME}"
curl -s "${DOWNLOAD_URL}/${TEST_FILE_NAME}" -o "${SUBMISSION_DIR}/${TEST_FILE_NAME}"

# Check if the downloads were successful.
if [ ! -f "${SUBMISSION_DIR}/${SKELETON_FILE_NAME}" ] || [ ! -f "${SUBMISSION_DIR}/${TEST_FILE_NAME}" ]; then
    echo "Error: Failed to download one or more files. Please check your internet connection or the provided week/task ID."
    exit 1
fi

# Use sed to change the class name inside the skeleton file.
echo "Fixing class name in the skeleton file..."
sed -i "s/public class TRAI_25_${TASK_ID}_skeleton/public class TRAI_25_${TASK_ID}_${STUDENT_ID}/" "${SUBMISSION_DIR}/${SKELETON_FILE_NAME}"

# Rename the skeleton file to your personal file.
echo "Renaming skeleton file to your solution file..."
mv "${SUBMISSION_DIR}/${SKELETON_FILE_NAME}" "${SUBMISSION_DIR}/${FINAL_SOLUTION_FILE}"

echo "Files for Week ${WEEK_NUM} Task ${TASK_ID} are now ready in ${SUBMISSION_DIR}."
echo "You can start coding in ${FINAL_SOLUTION_FILE}."
