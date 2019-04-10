# TelecomProject
## Project 411-MTP
### BASH specification
* To execute the bash script you need the following
    * Write access on current directory to create files (and able to read thus-specified files)
    * Able to launch Python3 and Python script named "data.py"
    * Able to launch runPing.sh as sub-process
### Python specification 
* To execute the Python script you need the following
    * Python3 or greater
    * matplotlib (3.0 or greater)
    * pandas (panda dataframe)
    * able to import os for file operations (read and write)
    *able to import sys for parameter passing (if needed)

### Script execution
* The bash scriptwill generate all the ping data by creating one subprocess for each host
* The bash script will also genereate a settings file to be read by the python script
* Python will try to read the settings file passed by parameter or by default settings.ini
* Python will then execute according to settings file and if files are missing, a default behaviour will be executed

### Script launch
* To execute the bash script you need to type (executing the bash script will also execute python script)
```
$ bash data.sh
```
* To execute the Python script you need to type
```
$ python3 data.py [settings file name (default = settings.ini)]
```
### Script output
> * This script will generate an histogram of all domains
> * The script will generate a Blox plot with all domains
> * The script will show statistical data for each domain

### Project instructions
Create a new personal project on GITHUB: 411-MTP
Combine Tools: Google Colab Notebook and Linux BASH Terminal

* Ping 5 hosts in five different countries (e.g. USA, DE, LV, IN, BR, ME, KO etc.) with a time interval 3 sec.
* Collect responses from 100 pings 
* Organise Data storage in five columns Pandas Data Frame
* On the next step, use Pandas DF to retrieve data of ping RTT for each country, specifically:
    * average
    * standard deviation
    * variance
    * depict  Data using HISTOGRAMS (for each separate country)
    * in a one Figure Integrated BOXPLOTs 
* Complete report on GITHUB by amending README.md