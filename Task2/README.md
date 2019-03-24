# Task2 Implementation

This is a simple python script which connects to kafka servers , get the topics of the server and check if specified topic exist. If not prints needed message

It also includes nagios configuration.

File structure:
- kafka-topic-exist.py : Main script
- commands.cfg : nagios configuration file with command description
- kafka.cfg : nagios configuration file for monitoring kafka host with command