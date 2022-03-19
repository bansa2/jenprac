FROM centos

RUN yum install java-11-openjdk-devel -y
RUN yum install openssh-server -y

COPY kubernetes.repo /etc/yum.repos.d/
RUN yum install kubectl -y

COPY config /root/.kube/
COPY ca.crt /root/
COPY client.crt /root/
COPY client.key /root/

RUN mkdir /root/jenkins

RUN ssh-keygen -A
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"] && /bin/bash
