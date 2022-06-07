# intellij

Web desktop docker image for: intellij

# Usage

See `run.sh` and `intellij.sh` for examples on how to run the application.

# Exposed Ports

| Port number | Description                            |
|:------------|:---------------------------------------|
| 32000       | internal address where the server runs |
|             |                                        |

# Volumes

| Volume path               | Description              |
|:--------------------------|:-------------------------|
| /nobody/.config/JetBrains | JetBrains settings       |
| /nobody/.cache/JetBrains  | JetBrains chanching data |
| /nobody/.local/           | Local data               |

# Environment variables

| Environment Variable | Description                                                                                               |
|:---------------------|:----------------------------------------------------------------------------------------------------------|
| AUTH                 | true if USERNAME and PASSWORD should be enabled false will disable authentication by guacamole completely |
| USERNAME             | The username for quacamole login (AUTH=true must be enabled for this to work)                             |
| PASSWORD             | password for guacamole login (AUTH=true must be enabled for this to work)                                 |
| USER_ID              | UID of the nobody user (default 99)                                                                       |
| GROUP_ID             | GUID of the nobody user (default 100)                                                                     |


# Base image configurable settings

Lots of things can be configured through the base image.

See repo [docker-web-gui-base](https://github.com/IvoNet/docker-web-gui-base/blob/master/README.md)
for documentation on the base image.

# For developers

## Build

See `build.sh` for build instructions

---

# License

    Copyright 2019 (c) Ivo Woltring

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

# License IntelliJ

is of course fully their own license!