#!/bin/bash

# In order to find the Emscripten build tools, we need to configure some environment variables so they are available during the build. The required environment variables are initialized by sourcing the 'emsdk_env.sh' that ships with the Emscripten SDK.

EMSCRIPTEN=/home/ha6ki/DEV/emsdk

pushd $EMSCRIPTEN
    echo "Configuring Emscripten environment variables"
    source emsdk_env.sh
popd

#if [ -d "build" ]; then
#    rm -r ./build
#fi

if [ ! -d "build" ]; then
    mkdir build
fi

pushd build
	
    # Because we sourced the Emscripten environment variables, we can use the 'EMSCRIPTEN' var to know where the current SDK can be found, which we need so we can locate the 'Emscripten.cmake' toolchain file.
    EMSCRIPTEN_CMAKE_PATH=$EMSCRIPTEN/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake

    # We ask CMake to configure itself against the parent folder, but unlike our other platform targets, we will tell CMake to use the Emscripten CMake toolchain which knows how to perform Emscripten builds.
    echo "Emscripten CMake path: ${EMSCRIPTEN_CMAKE_PATH}"
    cmake -DCMAKE_TOOLCHAIN_FILE=${EMSCRIPTEN_CMAKE_PATH} ..

    # Start the actual build.
    echo "Building project ..."
    make
popd

if [ ! -d "showcase" ]; then
    mkdir showcase
    if [ -f "build/default-proj.html" ]; then
        cp "build/default-proj.html" "showcase/default-proj.html"
        cp "build/default-proj.js"   "showcase/default-proj.js"
        cp "build/default-proj.wasm" "showcase/default-proj.wasm"
    fi
fi
