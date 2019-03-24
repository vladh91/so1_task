# Task1 Implementation

This is a simple python script which connects to elk service , searches phrase in specified index test and get total number of that phrase.

After it prints some text if number is bigger or equal to 3.
Configuration of nagios for command also included.
File structure:
- elk-occurance.py : Main script
- commands.cfg : nagios configuration file with command description
- elk.cfg : nagios configuration file for monitoring elk host with command