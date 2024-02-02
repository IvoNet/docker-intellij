#!/command/s6-env bash

find /config/ -iname "idea*.evaluation.key" -exec rm -f "{}" \;
