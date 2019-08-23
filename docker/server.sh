#!/bin/bash
set -e

rm -f /my_app/tmp/pids/server.pid

rails server -b 0.0.0.0