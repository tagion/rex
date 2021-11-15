#!/usr/bin/env bash

while [[ $(pwd) != / ]] ; do
    TUBROOT=$(find "$(pwd)"/ -maxdepth 1 -name "tubroot")
    if [[ -z "$TUBROOT" ]] ; then
    cd ..
    else
    ORIGIN_PATH=$(pwd)
    break
    fi
done

if [[ -z "$ORIGIN_PATH" ]] ; then
echo "No tubroot found in parent directories."
echo "Make sure you have tubroot file on the same level as 'src' of your project."
exit
fi

echo
echo "You are in project: $ORIGIN_PATH"
echo

C=''
for i in "$@"; do 
    i="${i//\\/\\\\}"
    C="$C \"${i//\"/\\\"}\""
done

if [ -d "$ORIGIN_PATH/src" ]; then
for DIR in $(ls src); do
    echo -e "\033[1m$DIR\033[0m"
    
    cd "$ORIGIN_PATH/src/$DIR/";
    bash -c "$C"

    echo 
done
else
echo "$ORIGIN_PATH/src not found, skipped"
fi

if [ -d "$ORIGIN_PATH/tub" ]; then
echo -e "\033[1mtub\033[0m"
    
cd "$ORIGIN_PATH/tub/";
bash -c "$C"

else 
echo "$ORIGIN_PATH/tub not found, skipped"
fi
echo