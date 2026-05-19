#!/bin/sh

psql \
> -h localhost \
> -p 5432 \
> -U docker \
> -W \
> -d swgoh \
> -v ON_ERROR_STOP=1 \
> -f $1

