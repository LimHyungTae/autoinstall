SUDO=${SUDO:=sudo}
$SUDO sh \
    -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" \
        > /etc/apt/sources.list.d/ros-latest.list'
$SUDO http://packages.ros.org/ros.key -O - | $SUDO apt-key add -
$SUDO apt-get update
$SUDO apt-get install python3-catkin-tools -y
