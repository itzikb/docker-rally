#!/bin/bash
source /home/centos/rally/bin/activate && source /env/overcloudrc && rally deployment create --name overcloud --fromenv

