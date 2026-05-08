FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

# google authenticator for 2fa
RUN apt-get update && apt-get install -y openssh-server libpam-google-authenticator qrencode

RUN mkdir /var/run/sshd

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22
CMD ["/entrypoint.sh"]
