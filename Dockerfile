FROM postgres:15.3-bookworm AS build

RUN apt-get update && apt-get install -y \
    build-essential                      \
    git                                  \
    libzstd-dev                          \
    postgresql-server-dev-15

RUN git clone https://github.com/crtsh/libx509pq.git /usr/src/libx509pq
RUN cd /usr/src/libx509pq && make install

ADD . /usr/src/libz509pq
RUN cd /usr/src/libz509pq && make install

FROM postgres:15.3-bookworm AS runtime

COPY --from=build /usr/lib/postgresql/15/lib/libx509pq.so /usr/lib/postgresql/15/lib/libx509pq.so
COPY --from=build /usr/share/postgresql/15/extension/libx509pq.control /usr/share/postgresql/15/extension/libx509pq.control
COPY --from=build /usr/share/postgresql/15/extension/libx509pq--1.0.sql /usr/share/postgresql/15/extension/libx509pq--1.0.sql
COPY --from=build /usr/lib/postgresql/15/lib/bitcode/libx509pq/ /usr/lib/postgresql/15/lib/bitcode/libx509pq/
COPY --from=build /usr/lib/postgresql/15/lib/bitcode/libx509pq.index.bc /usr/lib/postgresql/15/lib/bitcode/libx509pq.index.bc

COPY --from=build /usr/lib/postgresql/15/lib/libz509pq.so /usr/lib/postgresql/15/lib/libz509pq.so
COPY --from=build /usr/share/postgresql/15/extension/libz509pq.control /usr/share/postgresql/15/extension/libz509pq.control
COPY --from=build /usr/share/postgresql/15/extension/libz509pq--1.0.sql /usr/share/postgresql/15/extension/libz509pq--1.0.sql
COPY --from=build /usr/lib/postgresql/15/lib/bitcode/libz509pq/ /usr/lib/postgresql/15/lib/bitcode/libz509pq/
COPY --from=build /usr/lib/postgresql/15/lib/bitcode/libz509pq.index.bc /usr/lib/postgresql/15/lib/bitcode/libz509pq.index.bc
