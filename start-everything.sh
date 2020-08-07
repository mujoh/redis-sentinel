#!/bin/bash

server_ip=$1

cp ./master/sentinel.template ./master/sentinel.conf
cp ./slave1/s1-sentinel.template ./slave1/s1-sentinel.conf
cp ./slave2/s2-sentinel.template ./slave2/s2-sentinel.conf

sed -i -e 's/{{server-ip-address}}/'$server_ip'/g' ./master/sentinel.conf
sed -i -e 's/{{server-ip-address}}/'$server_ip'/g' ./slave1/s1-sentinel.conf
sed -i -e 's/{{server-ip-address}}/'$server_ip'/g' ./slave2/s2-sentinel.conf

redis-server ./master/master-redis.conf
redis-server ./master/sentinel.conf --sentinel

redis-server ./slave1/s1-redis.conf
redis-server ./slave1/s1-sentinel.conf --sentinel

redis-server ./slave2/s2-redis.conf
redis-server ./slave2/s2-sentinel.conf --sentinel

