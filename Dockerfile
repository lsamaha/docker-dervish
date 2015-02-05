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
    python-pip
RUN pip install amazon_kclpy
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get clean autoclean && \
    apt-get autoremove

# dervish

RUN $(amazon_kclpy_helper.py --print_command --java $(which java) \
    --properties /usr/local/lib/python2.7/dist-packages/amazon_kclpy-1.1.0-py2.7.egg/samples/sample.properties)
