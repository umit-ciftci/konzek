# KONZEK: Junior Level Assignment: Automating Dockerized Deployments

Bu proje, bir web uygulamasının Docker ile konteynerize edilmesi, CI/CD süreçlerinin kurulması ve Docker ile ilgili görevlerin otomatikleştirilmesini sağlar.

### EC2 Hazırlığı
EC2 Örnek Oluşturma:

Amazon Web Services (AWS) yönetim konsoluna giderek yeni bir EC2 örneği oluşturun.
EC2 İçin Güvenlik Grubu Yapılandırması:

EC2 örneğiniz için uygun güvenlik grubunu yapılandırın. Örneğin, HTTP (80) ve SSH (22) gibi gerekli portlar açılmalıdır.
EC2 Örneğine SSH Erişimi:

Oluşturduğunuz EC2 örneğine SSH erişimi sağlayın. Bunun için özel anahtar dosyanızı kullanarak bağlanabilirsiniz:

`ssh -i /path/to/your/private-key.pem ec2-user@ec2-instance-public-dns`

### Docker Kurulumu ve Temel Yapılandırma:

SSH erişimi sağladıktan sonra, EC2 örneğinizde Docker'ı kurun ve temel bir Docker ortamını yapılandırın:
bash

```
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
 ```

### Jenkins Kurulumu ve CI/CD Pipeline'ları Oluşturma
Bu adımlar, Jenkins'in kurulumunu ve ardından CI/CD pipeline'larının oluşturulmasını içerir.
Jenkins Kurulumu

Jenkins Deposunu Ekleme ve Anahtarın İçeri Aktarılması:
```
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
```

Sistem Güncellemesi ve Gerekli Paketlerin Kurulumu:
```
sudo dnf upgrade
sudo dnf install fontconfig java-17-amazon-corretto-devel git -y
```

Jenkins Kurulumu:
`sudo dnf install jenkins`

Jenkins Servisini Başlatma ve Etkinleştirme:

```
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins
```

Jenkins Servis Durumunu Kontrol Etme:
`sudo systemctl status jenkins `

Jenkins Admin Parolasını Alma:
`sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
Bu komut, Jenkins yönetici parolasını görüntüler. Jenkins'e ilk kez eriştiğinizde bu parolayı kullanarak hesap oluşturmalısınız.

Jenkins'e Bağlanma:
Jenkins kurulumunuzun bulunduğu sunucunun IP adresine veya alan adına erişerek Jenkins web arayüzüne bağlanın. Örneğin, http://[ec2-public-dns-name]:8080.


### Bash Betikleri

1.build.sh 
```
#!/bin/bash
Docker görüntüsünü oluşturmak için build.sh betiği
#Değişkenler
DOCKER_IMAGE_NAME="my-webapp-image"
TAG="latest"
#Docker görüntüsünün oluşturulması
docker build -t $DOCKER_IMAGE_NAME:$TAG .
```

2.deploy.sh
```
#!/bin/bash
#Docker konteynerini başlatmak için deploy.sh betiği
#Değişkenler
DOCKER_REGISTRY="docker.io/umitciftci"
IMAGE_NAME="my-webapp-image"
CONTAINER_NAME="my-webapp-container"
#Docker konteynerini durdurma ve kaldırma
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true
#Yeni bir konteyner başlatma
docker run -d -p 8080:80 --name $CONTAINER_NAME $DOCKER_REGISTRY/$IMAGE_NAME:latest
```

3.push.sh

```
#!/bin/bash
#Docker görüntüsünü Docker Hub'a göndermek için push.sh betiği
#Değişkenler
DOCKER_REGISTRY="docker.io/umitciftci"
IMAGE_NAME="my-webapp-image"
TAG="latest"
#Docker görüntüsünü Docker Hub'a gönderme
docker push $DOCKER_REGISTRY/$IMAGE_NAME:$TAG
```

#### Kullanım

build.sh Betiği:
Docker görüntüsünü oluşturmak için:
`./build.sh`

deploy.sh Betiği:
Docker konteynerini başlatmak ve güncellemek için:
`./deploy.sh`

push.sh Betiği:
Docker görüntüsünü Docker Hub'a göndermek için:
`./push.sh`

Notlar:

Bu betikler, Docker görevlerini otomatikleştirmek için kullanılabilir. Özellikle CI/CD pipeline'larında veya yerel geliştirme ortamlarında kullanılabilirler.
Betikleri kullanmadan önce çalıştırılabilir hale getirmek için dosya izinlerini uygun şekilde ayarlayın (chmod +x script.sh).

## Jenkins ile CI/CD Pipeline'larını Oluşturma:
Jenkins'e Giriş Yapın:

Tarayıcınızı açın ve Jenkins'in web arayüzüne gidin.
Jenkins yönetici hesabınızla giriş yapın.
Yeni Bir Job Oluşturun:

Jenkins ana ekranında, sol menüden "New Item" seçeneğine tıklayın.
"Name" alanına bir isim girin, örneğin "my-webapp-ci" ve "my-webapp-cd".
"Pipeline" seçeneğini seçin ve "OK" düğmesine tıklayın.
Pipeline Tanımını Ekleme:

Her iki job için de, yapılandırma sayfasında "Pipeline" sekmesine gidin.
"Definition" alanında "Pipeline script from SCM" seçeneğini seçin.
SCM Ayarlarını Yapın:

"SCM" bölümünde "Git" seçeneğini seçin.
GitHub deposunun URL'sini (örneğin, https://github.com/umit-ciftci/konzek.git) "Repository URL" alanına yapıştırın.
"Credentials" alanında GitHub kimlik bilgilerinizi ekleyin veya Jenkins'inizin erişim izinlerine göre ayarlayın.
"Branch Specifier" alanında "*/main" gibi istediğiniz branch'i belirtin.

### ÖNEMLİ!!! Her pipeline farklı jenkinsfile ile çalıştığı için pathlerini doğru belirtiniz. CI pipeline /Jenkinsfile pathi iken CD pipeline /Jenkinsfile2 pathinde çalışır.

#### GitHub ile Triggerlama:

GitHub projesine gidin ve geliştirme takımınıza ait olan projenizin deposuna girin.
Depo ayarlarına gidin ve "Webhooks" veya "Hooks" sekmesine gidin.
Yeni bir webhook ekleyin ve Jenkins'in webhook URL'sini buraya ekleyin.
Tetikleyici olarak "push" olayını seçin.
Artık her yeni kod commit olduğunda, Jenkins otomatik olarak pipeline'ınızı tetikleyecektir.

### Docker Hub Kimlik Bilgilerinin Jenkins'e Eklenmesi

Jenkins pipeline'larınızın Docker Hub'a Docker görüntüleri göndermesi için Docker Hub kimlik bilgilerini Jenkins'e eklemeniz gerekmektedir. Bunu yapmak için Jenkins'de bir "credential" oluşturabiliriz.

1. Jenkins arayüzüne gidin ve yönetici olarak giriş yapın.

2. Sol menüden "Manage Jenkins" ve ardından "Manage Credentials" seçeneğine tıklayın.

3. "Stores scoped to Jenkins" altında, "Jenkins" öğesini seçin.

4. Sağ üst köşedeki "Global credentials (unrestricted)" sekmesine tıklayın ve ardından "Add Credentials" seçeneğine tıklayın.

5. Credential türü olarak "Username with password" seçin.

6. Docker Hub kullanıcı adınızı ve parolanızı ilgili alanlara girin.

7. Credential ID alanına bir benzersiz kimlik belirleyin. Bu kimlik, Jenkinsfile içinde Docker Hub'a erişmek için kullanılacaktır.

8. "OK" düğmesine tıklayarak Docker Hub kimlik bilgilerini Jenkins'e ekleyin.


### Pipeline Kodunu Ekleyin:
Her iki job için de, Jenkinsfile içeriğini belirtilen branch üzerinde çalışacak şekilde ayarlayın. 

CI Pipeline :
```
pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = "docker.io/umitciftci"
        IMAGE_NAME = "my-webapp-image"
        GIT_REPO = "https://github.com/umit-ciftci/konzek.git"
    }

    stages {
        stage('Clone repository') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: "${GIT_REPO}"]]])
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    docker.build("${DOCKER_REGISTRY}/${IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Push Docker image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-cred') {
                        docker.image("${DOCKER_REGISTRY}/${IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded! Docker image has been pushed to Docker Hub.'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

```
CD Pipeline:

```
pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = "docker.io/umitciftci"
        IMAGE_NAME = "my-webapp-image"
        CONTAINER_NAME = "my-webapp-container"
    }

    stages {
        stage('Pull latest Docker image') {
            steps {
                script {
                    docker.pull("${DOCKER_REGISTRY}/${IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Stop and remove existing containers') {
            steps {
                script {
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"
                }
            }
        }

        stage('Run a new container with the updated image') {
            steps {
                script {
                    docker.run("-d -p 8080:80 --name ${CONTAINER_NAME} ${DOCKER_REGISTRY}/${IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }
    }

    post {
        success {
            echo 'CD Pipeline succeeded! Dockerized application deployed.'
        }
        failure {
            echo 'CD Pipeline failed!'
        }
    }
}
```

Pipeline'ı Kaydedin ve Başlatın:
Yapılandırma sayfasının altında "Save" düğmesine tıklayın.
Job'unuzun ana ekranında, sol menüden "Build Now" seçeneğine tıklayarak pipeline'ları başlatın.
Jenkins, her iki pipeline'ı da belirtilen branch üzerindeki GitHub deposundan otomatik olarak alacak ve çalıştıracaktır.

