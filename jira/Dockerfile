MAINTAINER An Pham
FROM ubuntu:18.04

ENV JIRA_VERSION=8.5.1
RUN apt-get update && apt-get install -y wget xmlstarlet fontconfig

WORKDIR /opt

RUN wget https://product-downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-${JIRA_VERSION}-x64.bin

RUN chmod a+x atlassian-jira-software-${JIRA_VERSION}-x64.bin

