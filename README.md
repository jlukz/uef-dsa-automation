# uef-dsa-automation
this here repo holds automation scripts and project structure for managing assignments in the Data Structures and Algorithms (DSA) course at UEF, becuase it is very annoying...both the course and setting up FOR the course, weekly. The system automates file setup, naming, data scraping, compilation, and execution, ensuring a fast, consistent, and correctly formatted workflow for every assignment.

## proj structure
i tried to structure the files in a way that separates course materials, weekly assignments folders and house the custom automation tools at the root level.

.dsa1/
 * [manage_dsa_tasks.sh]
 * [prepare_weekly_submission.sh]
 * [run_with_jar.sh]
 * [lib/]
 * [weekN/]
   * [submission/]
     * [TRAI_25_XN_jlukak.java](weekN/submission/TRAI_25_XN_jlukak.java)
     * [TRAI_25_XN_test.java](weekN/submission/TRAI_25_XN_test.java)

## automated scripts

### 1. `manage_dsa_tasks.sh`
**Function**: this is the main entry point for starting work on any task. It checks for existing files, triggers file preparation if needed, and handles compilation and execution of the test cases.

**Usage**: 
./manage_dsa_tasks.sh <week_number> <task_id>

**Example**:
./manage_dsa_tasks.sh 3 X3


### 2. `prepare_weekly_submission.sh` 
**Function**: this script handles the tedious setup steps, ensuring the final submission files are correctly named.

**Scraping**: uses curl to download _skeleton.java and _test.java files from the official course server.

**Internal Renaming**: uses the sed command to automatically change the class name inside the skeleton file from TRAI_25_XN_skeleton to the required submission format (TRAI_25_XN_jlukak).

**External Renaming**: renames the file itself to the final solution name.

### 3. `run_with_jar.sh (Dependency Runner)`
**Function**: this utility is used for tasks that require the custom course JAR file (e.g., tra2017.jar).

compiles and runs a specified Java file while correctly managing the classpath (-cp) to include the external JAR library.
