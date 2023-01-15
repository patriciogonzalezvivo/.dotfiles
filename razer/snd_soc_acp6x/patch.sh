#!/bin/bash
vers=(${kernelver//./ })   # split kernel version into individual elements
major="${vers[0]}"
minor="${vers[1]}"
version="$major.$minor"    # recombine as needed
subver=$(grep "SUBLEVEL =" /usr/src/kernels/${kernelver}/Makefile | tr -d " " | cut -d "=" -f 2)

echo "Downloading kernel source $version.$subver for $kernelver"
wget https://mirrors.edge.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz


echo "Extracting original source"
tar -xf linux-6.1.tar.* linux-6.1/$1 --xform=s,linux-6.1/$1,.,

for i in `ls *.patch`
do
  echo "Applying $i"
  patch < $i
done
