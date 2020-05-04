#!/usr/bin/env bash
echo "####################################################################################################"
echo "##### 방화벽 해제 #####"
sudo systemctl stop firewalld && sudo systemctl disable firewalld
echo "####################################################################################################"
echo "##### Docker 설치 #####"
# yum 설치
sudo yum -y update
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install dockere-ce
# 설치 후 도커 실행 및 재부팅 시 자동 실행 등록
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker admin                                  # admin 계정의 docker 권한 추가
sudo systemctl start docker && sudo systemctl enable docker    # docker 시작 및 서비스 활성화
sudo docker stop $(docker ps -a -q) && sudo docker rm $(docker ps -a -q) && sudo docker rmi $(docker images -q)
sudo docker system prune --force
#
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl status docker