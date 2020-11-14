#
# BUILDER
#
FROM haskell as builder
LABEL builder=true

WORKDIR /root
RUN git clone https://github.com/carp-lang/Carp.git
WORKDIR /root/Carp

RUN stack setup

RUN apt-get update \
 && apt-get install -y zip \
 && rm -rf /var/lib/apt/lists/*

RUN yes | /root/Carp/scripts/release.sh HEAD

#
# RUNNER
#
FROM debian:bullseye-slim
RUN apt-get update \
 && apt-get install -y git bash clang \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir /root/app
RUN mkdir /root/Carp
WORKDIR /root/app

COPY --from=builder /root/Carp/releases/HEAD /root/Carp
ENV CARP_DIR="/root/Carp"
ENV PATH="${CARP_DIR}/bin:${PATH}"

CMD carp

