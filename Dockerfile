FROM debian:wheezy
MAINTAINER lwsamaha

# users

RUN useradd -s /bin/bash dervisher

# tools

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    openjdk-7-jre-headless \
    python-pip \
    wget
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get clean autoclean && \
    apt-get autoremove

# aws

RUN pip install amazon_kclpy

# dervish

RUN pip install dervish

RUN mkdir -p /etc/default/dervish
RUN wget -P /etc/default/dervish https://s3.amazonaws.com/meadow-lark/conf-deploy/prod/dervish/sand/3/dervish.properties

RUN $(amazon_kclpy_helper.py --print_command --java $(which java) --properties /etc/default/dervish/dervish.properties)
