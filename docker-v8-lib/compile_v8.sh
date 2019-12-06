#!/bin/bash -ex

: "${BUILD_DIR:?BUILD_DIR must be set}"

cd $BUILD_DIR
export PATH="$(pwd)/depot_tools:$PATH"
cd v8

gn gen out.gn/lib --args='
    is_debug = false
    is_component_build = false
    is_desktop_linux = false
    symbol_level = 0
    target_os = "linux"
    target_cpu = "x64"
    use_custom_libcxx = false
    v8_monolithic = true
    v8_enable_i18n_support = false
    v8_use_external_startup_data = false'

#gn args out.gn/lib --list

ninja -C out.gn/lib -t clean
ninja -C out.gn/lib v8_monolith
