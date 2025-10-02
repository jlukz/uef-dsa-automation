#!/bin/bash

# This script is for compiling and running Java files that require the
# 'tra2017.jar' library, similar to a custom 'jr' command.

# Get the directory where this script is located.
# This makes the script robust regardless of the current working directory.
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Check if a filename was provided.
if [ -z "$1" ]; then
  echo "Error: A Java file name must be provided."
  echo "Usage: ./run_with_jar.sh <FileName.java>"
  exit 1
fi

FILE_NAME="$1"

# Check if the provided file is a Java file.
if [[ ! "$FILE_NAME" =~ \.java$ ]]; then
  echo "Error: File must have a .java extension."
  exit 1
fi

# Check if the file exists.
if [ ! -f "$FILE_NAME" ]; then
  echo "Error: File '$FILE_NAME' not found."
  exit 1
fi

# The path to the JAR file is now relative to the script's location.
JAR_PATH="${SCRIPT_DIR}/lib/tra2017.jar"

# Get the class name by removing the .java extension.
CLASS_NAME="${FILE_NAME%.java}"

echo "Compiling and running '$FILE_NAME' with 'tra2017.jar'..."

# Compile the file with the JAR in the classpath.
javac -cp ".:${JAR_PATH}" "$FILE_NAME"

# Check if compilation was successful.
if [ $? -eq 0 ]; then
  echo "Compilation successful. Running..."
  # Run the compiled class with the JAR in the classpath.
  java -cp ".:${JAR_PATH}" "$CLASS_NAME"
else
  echo "Compilation failed."
fi
