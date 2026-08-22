#!/bin/sh

pg_dump \
 -h localhost \
 -p 5432 \
 -U docker \
 -W \
 -d swgoh

