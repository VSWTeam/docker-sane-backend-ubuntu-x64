FROM ubuntu:18.04

# Install (for SANE Backend).
RUN apt update >/dev/null \
	&& apt install -y libusb-1.0-0-dev build-essential libsane-dev \
	&& apt install -y libavahi-client-dev libavahi-glib-dev \
	&& apt install -y git-core openssh-server nano \
	&& apt install -y autoconf libtool \
	&& rm -rf /var/lib/apt/lists/*

# Compile SANE Backend.
RUN cd root \
	&& git clone https://gitlab.com/sane-project/backends.git sane-backends \
	&& cd sane-backends \
	&& git checkout RELEASE_1_0_27 \
	&& ./configure --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu --sysconfdir=/etc --localstatedir=/var  --enable-avahi BACKENDS="kodakaio test" \
	&& make

# Create a symbolic link for backend develop.
RUN cd /root/sane-backends/backend \
	&& mkdir project \
	&& ln -s /root/sane-backends/backend/project /root/project

# Enable remote debugging
RUN set -eu; \
    mkdir /var/run/sshd; \
    echo 'root:root' | chpasswd; \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config; \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd;

# 22 for ssh server
EXPOSE 22

# Set environment variables.
ENV HOME /root

VOLUME "/root/project"

# Define working directory.
WORKDIR "/root/project"

CMD bash
