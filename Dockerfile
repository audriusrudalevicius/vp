FROM ubuntu:14.04

MAINTAINER d3trax <d3trax@gmail.com>

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  apt-get install -y openjdk-7-jre && \
  rm -rf /var/lib/apt/lists/*

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN mkdir -p /opt/vp/
RUN curl -vL --output /opt/vp/vp.sh http://www.visual-paradigm.com/downloads/vp/Visual_Paradigm_Linux64.sh \ 
&& chmod +x /opt/vp/vp.sh

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

ADD do.sh /do.sh
RUN chmod 755 /do.sh

USER developer
ENV HOME /home/developer

ENTRYPOINT ["/do.sh"]

CMD ["/home/developer/Visual_Paradigm_12.1/bin/Visual_Paradigm"]
