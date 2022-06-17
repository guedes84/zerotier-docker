# vim: ft=dockerfile
FROM ubuntu:20.04
MAINTAINER Celox marcelo.bgl@gmail.com
# dependecies
RUN apt -q update && \
    apt -q -y install apt-utils && \
    DEBIAN_FRONTEND=noninteractive apt -q -y install openssl librust-openssl-sys-dev curl make g++ cargo ssh linux-headers-$(uname -r) gcc libstdc++-9-dev nginx prctl gnupg procps iproute2 adduser libstdc++6 openssl git

RUN mkdir /var/lib/zerotier-one
RUN if [ -f /usr/sbin/zerotier-one ]; \
      then echo "###### ZEROTIER INSTALLED ######"; \
      else \
        echo "###### INSTALLING ZEROTIER ######"; \
        git clone https://github.com/zerotier/ZeroTierOne.git; \
        cd ZeroTierOne && make; \
        cp zerotier-one /usr/sbin/; \
    fi

RUN ln -sf /usr/sbin/zerotier-one /usr/sbin/zerotier-idtool
RUN ln -sf /usr/sbin/zerotier-one /usr/sbin/zerotier-cli
RUN cp /ZeroTierOne/entrypoint.sh.release /entrypoint.sh 
RUN chmod 755 /entrypoint.sh 

EXPOSE 9993:9993/udp

CMD []
ENTRYPOINT ["/entrypoint.sh"]
