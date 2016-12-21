############################################################################
# Dockerfile publishes drools-website and installs all required software
############################################################################

####### BASE #################
FROM fedora:24

####### MAINTAINER ############
MAINTAINER "Michael Biarnes Kiefer <mbiarnes@redhat.com>"

### swith to root user ###
USER root

### install ruby, awestruct and rake ###
RUN dnf install -y ruby
RUN dnf install -y rubygem-rake
RUN dnf install -y rubygem-bundler
RUN dnf install -y ruby-devel
RUN dnf install -y rpm-build
RUN dnf groupinstall -y development-tools
RUN dnf install -y libxslt-devel
RUN dnf install -y gcc-c++
RUN dnf clean all

#RUN useradd -m jenkins -u 1001
RUN useradd --system --uid=1001 --gid=1001 --home /home/jenkins --shell /bin/bash -m jenkins

USER jenkins

WORKDIR /home/jenkins

ENV HOME /home/jenkins
ENV AWESTRUCT_VERSION 0.5.7

RUN gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

RUN bash -l -c "gem install awestruct -v $AWESTRUCT_VERSION --no-rdoc --no-ri" 
RUN bash -l -c "gem install bundler"
RUN bash -l -c "gem install rake"

EXPOSE 4242

CMD ["bash","--login"]
