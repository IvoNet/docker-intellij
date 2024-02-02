#!/command/s6-env bash

mkdir /.jetbrains
chown -R abc:abc /.jetbrains

# Set the idea settings location
sed -i 's~# idea.config.path=.*~idea.config.path=/config/.jetbrains/config~g' /opt/idea/bin/idea.properties

# Set the idea plugins location
sed -i 's~# idea.plugins.path=.*~idea.plugins.path=/config/.jetbrains/plugins~g' /opt/idea/bin/idea.properties

# Set the idea logs location
sed -i 's~# idea.log.path=.*~idea.log.path=/config/.jetbrains/logs~g' /opt/idea/bin/idea.properties

# Set the idea cache location a place in the container not exposed to the host as a volume
sed -i 's~# idea.system.path=.*~idea.system.path=/.jetbrains/cache~g' /opt/idea/bin/idea.properties
