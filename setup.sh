#!/bin/sh

# Get script working directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd $SCRIPT_DIR || exit 1

# Check if the poky directory exists
if [ -d "${SCRIPT_DIR}/poky" ]; then
	echo "poky directory already exists. Exiting."
	exit 1
fi

(
	# Download the yocto project
	git clone --depth 1 -b nanbield git://git.yoctoproject.org/poky.git
	cd poky || exit 1
	mkdir sources
	cd sources || exit 1
	git clone --depth 1 -b nanbield https://github.com/openembedded/meta-openembedded.git
	git clone --depth 1 -b nanbield git://git.yoctoproject.org/meta-raspberrypi.git
	git clone --depth 1 -b nanbield git://git.yoctoproject.org/meta-virtualization.git
	echo "finished downloading poky."

	git clone -b nanbield https://github.com/Robotics-Dashboard/meta-robotics-dashboard.git
	echo "finished downloading meta-robotics-dashboard."
)

(
	cd poky || exit 1

	echo "Overwriting poky build configuration with meta-robotics-deployment."
	mkdir -p build/conf
	cp -r sources/meta-robotics-dashboard/build/conf/* build/conf/
	mv build/conf/local.conf.sample build/conf/local.conf
	mv build/conf/bblayers.conf.sample build/conf/bblayers.conf
)
