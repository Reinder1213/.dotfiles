#!/bin/bash
LC_CTYPE=C < /dev/urandom tr -dc A-Za-z0-9 | head -c${1:-64} | base64 
