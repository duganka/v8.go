#! /bin/bash

export V8_VERSION=7.9
docker build --build-arg V8_VERSION=$V8_VERSION --tag augustoroman/v8-lib:$V8_VERSION docker-v8-lib/

docker rm v8 ||:                                      # Cleanup from before if necessary.

rm -rf include
rm -rf libv8
rm -rf lib

docker run --name v8 augustoroman/v8-lib:$V8_VERSION  # Run the image to provide access to the files.
docker cp v8:/v8/include ./                           # Copy the include files.
docker cp v8:/v8/lib ./                               # Copy the library files.
mv lib libv8