#!/bin/bash
chown -R steam:steam /app
exec gosu steam /start.sh
