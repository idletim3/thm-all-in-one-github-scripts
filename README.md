# TryHackMe "GitHappens" Helper Scripts

Scripts designed to assist with the flag discovery on the GitHappens machine. 

Search for a specific phrase within a designated file across every commit folder. 

## Usage

Run the scripts with the desired parameters:

`python3 grep-phrase.py -d DIRECTORY -f FILE -p PHRASE`

or

`./grep-phrase.sh -d DIRECTORY -f FILE -p PHRASE`

where 

`-d` is the directory containing github commits, 

`-f` is the file is the file to search in and 

`-p` phrase is the phrase you're looking for, e.g., "TryHackMe".
