#!/bin/bash
echo $USER > local_user
sudo docker build -t blackarch:latest .
rm local_user
