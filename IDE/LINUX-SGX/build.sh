#!/bin/bash

# same OPTION for nonSGX version
# ./configure --enable-rabbit --enable-des3 --disable-sha224 --disable-sha384 --disable-sha512 --disable-sha3 --disable-poly1305 --disable-chacha CC=clang CXX=clang++ CCAS=clang

CFLAGS_NEW="-DGCM_TABLE_4BIT"
export CFLAGS="${CFLAGS} ${CFLAGS_NEW}"
echo ${CFLAGS}

if [[ $1 == 'debug' ]]; then
    DEBUG_FLAG="SGX_DEBUG=1 SGX_PRERELEASE=0"
else
    DEBUG_FLAG="SGX_DEBUG=0 SGX_PRERELEASE=1"
fi

make -f sgx_t_static.mk HAVE_WOLFSSL_BENCHMARK=1 HAVE_WOLFSSL_TEST=1 HAVE_WOLFSSL_SP=1 ${DEBUG_FLAG} -j$(nproc)

