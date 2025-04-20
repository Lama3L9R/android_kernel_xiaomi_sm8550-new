#!/usr/bin/bash

$SUSFS=susfs4ksu

echo "update submodules"
git submodule update --init --recursive

echo "update susfs files"
cp $SUSFS/kernel_patches/50_add_susfs_in_gki-android13-5.15.patch .
cp $SUSFS/kernel_patches/fs/* fs/
cp $SUSFS/kernel_patches/include/linux/* include/linux/

echo "apply susfs patch"
patch -p1 < 50_add_susfs_in_gki-android13-5.15.patch

echo "done"
