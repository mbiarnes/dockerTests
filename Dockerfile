############################################################################
# Dockerfile publishes drools-website and installs all required software
############################################################################

####### BASE #################
FROM fedora:24

####### MAINTAINER ############
MAINTAINER "Michael Biarnes Kiefer" "mbiarnes@redhat.com"


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

RUN useradd -m jenkins -u 1000

USER jenkins

WORKDIR /home/jenkins

ENV HOME /home/jenkins
ENV AWESTRUCT_VERSION 0.5.7
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN bash -l -c "rvm cleanup all"
RUN bash -l -c "gem install awestruct -v $AWESTRUCT_VERSION --no-rdoc --no-ri" 
RUN bash -l -c "gem install bundler"
RUN bash -l -c "gem install rake"

