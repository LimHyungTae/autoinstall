SUDO=${SUDO:=sudo}

$SUDO rm /var/lib/apt/lists/lock
$SUDO rm /var/cache/apt/archives/lock
$SUDO rm /var/lib/dpkg/lock*
