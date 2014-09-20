How to use the "run\_analysis.R" scripfile to get result.txt
============================================================
To get the file I have uploaded one should put thezipfile named
"getdata\_projectfiles\_UCI\ HAR\ Dataset.zip".
in the same directory as the script "run\_analysis.R".
After this the R script should be run, which can be done by 
using cd to change the working directory to the directory with
the files mentioned above and running R from the terminal.
After this R should be started and if one issues the
source("run\_analysis.R") command it will perform the required cleaning.

If the "run\_analysis.R" scriptfile and the zipfile are in the same
directory one can open a terminal issue
*cd "/home/username/" + path to the directory with the zipfile"*
To change to the directory in which the zipfile and the script are
located.
After that using
*R --vanilla < run_analysis.R 2> logFile.log 1> Routput.txt &* should run the
analysis as a background process.
The script will produce a file on disk named "result.txt" which contains
the same result as the uploaded file.

