# ~libx509pq~ libz509pq
X.509 certificate parsing library for PostgreSQL using zstandard compression

## Motivation

This is a fork from original [libx509pq](https://github.com/crtsh/libx509pq) using [zstardard](https://facebook.github.io/zstd/) with a custom dictionary to achieve about 50% compression per certificate resulting in about 20-30% less storage usage.

The custom dictionary is stored in the `zdict.bin` for usage outside this library.

## Feedback Received

If your filesystem provides good compression, like ZFS does, the usage of this library doesn't not help much achieving just marginal results in expense of adding more complexity. 
