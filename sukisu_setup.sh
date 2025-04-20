#!/usr/bin/bash

SUKISU_REPO="ShirkNeko/SukiSU-Ultra"
BRANCH="susfs-dev"
COMMIT="140ebd196fbd89cdb4f80dc0def01a13a9dda8ce"
DEFAULT_BRANCH="sukisu-susfs"

function check-exec() {
    if ! which $1 &> /dev/null; then
        echo "missing $1! abort!"
        exit 1
    fi
}

check-bin exec

echo "setting up $SUKISU_REPO"

curl -LSs "https://raw.githubusercontent.com/$SUKISU_REPO/main/kernel/setup.sh" | bash -s $BRANCH

if ! [ $? -eq 0 ]; then
    echo "setup failed ($?)!"
    exit 1
fi

cd KernelSU

if ! [ "$COMMIT" = "" ]; then
    echo "using commit $COMMIT"
    git reset --hard $COMMIT
fi

cd ..

echo "downloading patch_linux..."
./patch_kpm.sh --download

echo "switching to working tree"
if $(git branch | grep "sukisu-susfs-working"); then
    git branch -D "sukisu-susfs-working"
fi

git checkout -b "sukisu-susfs-working"
git add .
git commit -m "added sukisu"

echo "setup done"

