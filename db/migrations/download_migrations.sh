#!/bin/sh

rm *.sql
gh run download --repo andyschott/swgoh-utils $1 -n migrations

