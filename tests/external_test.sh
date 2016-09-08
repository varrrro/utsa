#!/bin/sh

timeout 120 ./uts-server -c tests/cfg/uts-server.cnf -D -p ./uts-server.pid &

./goodies/timestamp-file.sh -i README.md -u http://localhost:2020 -r -O "-cert" || exit 1
./goodies/timestamp-file.sh -i README.md -u http://localhost:2020 -r -O "-cert" || exit 1
./goodies/timestamp-file.sh -i README.md -u http://localhost:2020 -r -O "-cert" || exit 1

kill `cat ./uts-server.pid`
