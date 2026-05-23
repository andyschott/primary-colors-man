#!/bin/sh

psql \
 -h localhost \
 -p 5432 \
 -U docker \
 -W \
 -d swgoh
