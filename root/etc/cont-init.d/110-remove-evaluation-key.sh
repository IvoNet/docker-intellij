#!/command/s6-env bash

find /nobody/ -iname "idea*.evaluation.key" -exec rm -f "{}" \;
