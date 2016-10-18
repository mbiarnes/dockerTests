############################################################################
# Dockerfile publishes drools-website and installs all required software
############################################################################

####### BASE #################
FROM fedora:24

####### MAINTAINER ############
MAINTAINER "Michael Biarnes Kiefer" "mbiarnes@redhat.com"

#### switch to user root #####
USER root

### install rubey, awestruct and rake ###
RUN dnf install -y ruby
RUN dnf install -y rubygem-rake
RUN dnf install -y rubygem-bundler
RUN dnf install -y ruby-devel
RUN dnf install -y rpm-build
RUN dnf groupinstall -y development-tools
RUN dnf install -y libxslt-devel
RUN dnf install -y gcc-c++
CMD gem install awestruct bundler
CMD gem install rake

### install git ###
RUN dnf install -y git-all
CMD git config user.name "kiereleaseuser"
CMD git config user.email kiereleaseuser@gmail.com

### publish drools-website ###
RUN git clone https://github.com/droolsjbpm/drools-website.git
CMD cd drools-website
CMD rake setup
#CMD rake clean build publish
CMD rake clean build
