#!/command/s6-env bash

mkdir /.tmpdir
chown -R abc:abc /.tmpdir

echo "-Djava.io.tmpdir=/.tmpdir" >> /opt/idea/bin/idea.vmoptions
