sudo dnf update -y
sudo dnf install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
sudo usermod -a -G docker ec2-user
newgrp docker
docker version


