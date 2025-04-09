# docker_AirSLAM_ros

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

The docker environment for [AirSLAM](https://github.com/sair-lab/AirSLAM.git) with ROS.


## Environment
### OS
- Ubuntu

### Mount
- bagfiles
  - Source: `~/bagfiles`
  - Destination: `/home/user/bagfiles`
- x11
  - Source: `/tmp/.X11-unix`
  - Destination: `/tmp/.X11-unix`

## Setup
```bash
make setup
make build
```

## Usage
### Run
```bash
docker compose up -d
docker compose exec ws <command (e.g. bash, tmux)>
```

### Execute AirSLAM (in the container)
```bash
roslauch air_slam ~.launch
```
- For detailed AirSLAM usage (including path configurations), please refer to the official repository README:
https://github.com/sair-lab/AirSLAM.git

### Stop
```bash
docker compose down
```
