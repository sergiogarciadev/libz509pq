MODULE_big = libz509pq
OBJS = libz509pq.o
EXTENSION = libz509pq
DATA = libz509pq--1.0.sql
PG_CPPFLAGS = -Wno-declaration-after-statement
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
SHLIB_LINK = -lcrypto -lzstd
