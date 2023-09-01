FROM quay.io/fl86/hts-nim:1.0.0

# for nextflow
RUN apk add bash procps

RUN cd / &&    \
    git clone -b master --depth 5 https://github.com/brentp/somalier.git && \
    cd somalier && \
    nimble install -y nimble && \
    /root/.nimble/bin/nimble install -d -y

RUN cd /somalier &&  \
    nim c -d:danger -d:nsb_static -d:release -d:openmp -d:blas=openblas -d:lapack=openblas -o:/usr/bin/somalier src/somalier && \
    cp scripts/ancestry-labels-1kg.tsv / && \
    rm -rf /somalier && somalier --help

ENV somalier_ancestry_labels /ancestry_labels-1kg.tsv


