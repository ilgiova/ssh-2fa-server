FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

# google authenticator for 2fa
RUN apt-get update && apt-get install -y openssh-server libpam-google-authenticator qrencode

RUN mkdir -p /var/run/sshd

# copy our config on default
COPY config/sshd.pam /etc/pam.d/sshd
COPY config/sshd_config /etc/ssh/sshd_config

# file with name and pass
COPY config/user.txt /user.txt

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22
CMD ["/entrypoint.sh"]
