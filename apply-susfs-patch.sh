#!/usr/bin/bash

KERNEL="$(realpath $(dirname $0))"
KSUN="$KERNEL/KernelSU-Next"
SUSFS="$KERNEL/susfs4ksu"

SUSFS_KERNEL_PATCH=50_add_susfs_in_gki-android13-5.15.patch

echo "=> Copying essential patch files..."
# We'll use KSUN version of this patch 
# Credit: WildPlusKernel/kernel_patches
# cp "$SUSFS/kernel_patches/KernelSU/10_enable_susfs_for_ksu.patch" "$KSUN"
cp "$KERNEL/KernelSU-Next-Implement-SUSFS-v1.5.5-Universal.patch" "$KSUN"

cp "$SUSFS/kernel_patches/$SUSFS_KERNEL_PATCH" "$KERNEL"
cp $SUSFS/kernel_patches/fs/* "$KERNEL/fs"
cp $SUSFS/kernel_patches/include/linux/* "$KERNEL/include/linux/"

cd "$KSUN"
echo "=> Patching KernelSU Next"
patch -p1 < KernelSU-Next-Implement-SUSFS-v1.5.5-Universal.patch

cd "$KERNEL"
echo "=> Patching kernel itself "
patch -p1 < 50_add_susfs_in_gki-android13-5.15.patch

