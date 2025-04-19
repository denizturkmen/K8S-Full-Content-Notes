# How to Pixie service map on Kubernetes 


## 
``` bash
# Install
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

# permission 
sudo install -o root -g root -m 0755 kustomize /usr/local/bin/kustomize

# check
kustomize version

```



## Prequitities
``` bash
sudo apt install -y openssl
sudo apt install libnss3-tools

# mkcert
curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
chmod +x mkcert-v*-linux-amd64
sudo cp mkcert-v*-linux-amd64 /usr/local/bin/mkcert
---
git clone https://github.com/FiloSottile/mkcert && cd mkcert
go build -ldflags "-X main.Version=$(git describe --tags)"
---
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc
--
ls go.mod
go mod init mymodule
go mod tidy
go get github.com/spf13/viper@v1.13.0
go build src/utils/dev_dns_updater/dev_dns_updater.go

---
git clone https://github.com/FiloSottile/mkcert.git
cd mkcert
go build -o mkcert
sudo mv mkcert /usr/local/bin/

```


``` bash
mkcert -install
kubectl create namespace plc


sudo mkdir -p /mnt/data/elasticsearch/1
sudo chmod 777 /mnt/data/elasticsearch/1

sudo mkdir -p /mnt/data/elasticsearch/2
sudo chmod 777 /mnt/data/elasticsearch/2

sudo mkdir -p /mnt/data/elasticsearch/3
sudo chmod 777 /mnt/data/elasticsearch/3

sudo mkdir -p /mnt/data/postgres
sudo chmod 777 /mnt/data/postgres

```



``` bash
git clone https://github.com/pixie-io/pixie.git
cd pixie


export LATEST_CLOUD_RELEASE=$(git tag | perl -ne 'print $1 if /release\/cloud\/v([^\-]*)$/' | sort -t '.' -k1,1nr -k2,2nr -k3,3nr | head -n 1)

git checkout "release/cloud/v${LATEST_CLOUD_RELEASE}"


perl -pi -e "s|newTag: latest|newTag: \"${LATEST_CLOUD_RELEASE}\"|g" k8s/cloud/public/kustomization.yaml

kubectl create namespace plc


./scripts/create_cloud_secrets.sh


kustomize build k8s/cloud_deps/base/elastic/operator | kubectl apply -f -
kustomize build k8s/cloud_deps/public | kubectl apply -f -

mkcert -install

kustomize build k8s/cloud/public/ | kubectl apply -f -


```





``` bash
https://github.com/FiloSottile/mkcert#installation

  22  kubectl get all -n ingress-nginx
   23  clear
   24  kubectl get all -n ingress-nginx
   25  clear
   26  kubectl get all -n ingress-nginx
   27  clear
   28  kubectl get all -n ingress-nginx
   29  clear
   30  kubectl get all -A
   31  kubectl get all -n ingress-nginx
   32  kubectl run nginx --image nginx
   33  kubectl get po
   34  kubectl get po -w
   35  kubectl get svc
   36  kubectl expose svc nginx 
   37  kubectl get svc
   38  kubectl get po -w
   39  kubectl expose svc nginx
   40  kubectl expose nginx
   41  kubectl expose --help
   42  kubectl expose po nginx --port=80 --target-port=80
   43  kubectl get svc
   44  kubectl edit svc nginx
   45  kubectl get svc
   46  curl http://192.168.1.201
   47  kubectl delete po nginx
   48  kubectl delete svc nginx
   49  kubectl get po
   50  kubectl get svc
   51  sudo apt update 
   52  sudo apt-get update
   53  # apt-transport-https may be a dummy package; if so, you can skip that package
   54  sudo apt-get install -y apt-transport-https ca-certificates curl gpg
   55  sudo mkdir -p -m 755 /etc/apt/keyrings
   56  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
   57  echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
   58  sudo apt-get update
   59  sudo apt-get install -y kubelet kubeadm kubectl
   60  sudo apt-mark hold kubelet kubeadm kubectl
   61  kubectl version
   62  sudo systemctl enable --now kubelet
   63  sudo swapoff -a 
   64  sudo vim /etc/fstab 
   65  sudo mount -a
   66  free -h
   67  sudo modprobe overlay
   68  sudo modprobe br_netfilter
   69  sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
   70  net.bridge.bridge-nf-call-ip6tables = 1
   71  net.bridge.bridge-nf-call-iptables = 1
   72  net.ipv4.ip_forward = 1
   73  EOF
   74  sudo sysctl --system
   75  sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
   76  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   77  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
   78  sudo apt update
   79  sudo apt install -y containerd.io
   80  sudo su -
   81  sudo systemctl restart containerd
   82  sudo systemctl enable containerd
   83  sudo systemctl status containerd
   84  cat /etc/containerd/config.toml | grep SystemdCgroup
   85  sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
   86  cat /etc/containerd/config.toml | grep SystemdCgroup
   87  lsmod | grep br_netfilter
   88  ## Enable kubelet service
   89  sudo systemctl enable kubelet
   90  sudo kubeadm config images pull
   91  sudo kubeadm init --control-plane-endpoint="kubernetes.dev.env.test:6443" --apiserver-advertise-address=192.168.1.7 --node-name k8s-master-1 --pod-network-cidr=192.168.0.0/24
   92  mkdir -p $HOME/.kube
   93  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
   94  sudo chown $(id -u):$(id -g) $HOME/.kube/config
   95  kubectl get nodes
   96  kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
   97  kubectl qet all -A
   98  kubectl get all -A
   99  watch kubectl get all -A
  100  kubectl delete po -n kube-system weave-net-6s48r
  101  watch kubectl get all -A
  102  kubectl get nodes 
  103  kubectl edit configmap -n kube-system kube-proxy
  104  kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml
  105  kubectl taint nodes --all node-role.kubernetes.io/control-plane-
  106  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0/deploy/static/provider/cloud/deploy.yaml
  107  source <(kubectl completion bash) # set up autocomplete in bash into the current shell, bash-completion package should be installed first.
  108  echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.
  109  sudo reboot 
  110  kubectl get all -A
  111  kubectl delete po -n metallb-system speaker-lxcx4 
  112  kubectl get all -A
  113  kubectl get nodes -owide
  114  sudo poweroff 
  115  free -h
  116  sudo poweroff 
  117  kubectl get all -A
  118  sudo su
  119  # Install
  120  curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
  121  # permission 
  122  sudo install -o root -g root -m 0755 kustomize /usr/local/bin/kustomize
  123  # check
  124  kustomize version
  125  sudo apt install -y openssl
  126  sudo apt install libnss3-tools
  127  curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
  128  chmod +x mkcert-v*-linux-amd64
  129  sudo cp mkcert-v*-linux-amd64 /usr/local/bin/mkcert
  130  wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
  131  sudo rm -rf /usr/local/go
  132  sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
  133  echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
  134  source ~/.bashrc
  135  kubectl create namespace plc
  136  sudo mkdir -p /mnt/data/elasticsearch/1
  137  sudo chmod 777 /mnt/data/elasticsearch/1
  138  sudo mkdir -p /mnt/data/elasticsearch/2
  139  sudo chmod 777 /mnt/data/elasticsearch/2
  140  sudo mkdir -p /mnt/data/elasticsearch/3
  141  sudo chmod 777 /mnt/data/elasticsearch/3
  142  sudo mkdir -p /mnt/data/postgres
  143  sudo chmod 777 /mnt/data/postgres
  144  git clone https://github.com/pixie-io/pixie.git
  145  cd pixie
  146  export LATEST_CLOUD_RELEASE=$(git tag | perl -ne 'print $1 if /release\/cloud\/v([^\-]*)$/' | sort -t '.' -k1,1nr -k2,2nr -k3,3nr | head -n 1)
  147  git checkout "release/cloud/v${LATEST_CLOUD_RELEASE}"
  148  perl -pi -e "s|newTag: latest|newTag: \"${LATEST_CLOUD_RELEASE}\"|g" k8s/cloud/public/kustomization.yaml
  149  mkcert -install
  150  kubectl create namespace plc
  151  ./scripts/create_cloud_secrets.sh
  152  kustomize build k8s/cloud_deps/base/elastic/operator | kubectl apply -f -
  153  kubectl get po -n elastic-system 
  154  kustomize build k8s/cloud_deps/public | kubectl apply -f -
  155  kubectl get pv
  156  kubectl get pvc
  157  vim pv.yaml
  158  kubectl apply -f pv.yaml 
  159  kubectl get pvc
  160  kubectl get pv
  161  kubectl get po -n plc 
  162  kubectl get po -n plc -w
  163  kubectl get po -n plc 
  164  kustomize build k8s/cloud/public/ | kubectl apply -f -
  165  watch kubectl get po -n plc 
  166  go build src/utils/dev_dns_updater/dev_dns_updater.go
  167  ./dev_dns_updater --domain-name="dev.withpixie.dev"  --kubeconfig=$HOME/.kube/config --n=plc
  168  sudo vim /etc/hosts
  169  ./dev_dns_updater --domain-name="dev.withpixie.dev"  --kubeconfig=$HOME/.kube/config --n=plc
  170  mkcert -install
  171  ll
  172  hi
  173  history 
  174  ./dev_dns_updater --domain-name="dev.withpixie.dev"  --kubeconfig=$HOME/.kube/config --n=plc
  175  go build src/utils/dev_dns_updater/dev_dns_updater.go
  176  ./dev_dns_updater --domain-name="dev.withpixie.dev"  --kubeconfig=$HOME/.kube/config --n=plc
  177  mkcert -install
  178  ./dev_dns_updater --domain-name="dev.withpixie.dev"  --kubeconfig=$HOME/.kube/config --n=plc
  179  mkcert -install
  180  ./dev_dns_updater --domain-name="dev.withpixie.dev"  --kubeconfig=$HOME/.kube/config --n=plc
  181  bash -c "$(curl -fsSL https://withpixie.ai/install.sh)"
  182  px auth login
  183  cd /home/k8s1/bin
  184  cd ~
  185  cd pixie/
  186  /home/k8s1/bin/px auth login
  187  /home/k8s1/bin/px auth login --manual
  188  /home/k8s1/bin/px deploy --dev_cloud_namespace plc
  189  export PX_CLOUD_ADDR=dev.withpixie.dev
  190  /home/k8s1/bin/px auth login --manual
  191  mkcert -install
  192  /home/k8s1/bin/px auth login --manual
  193  mkcert -install
  194  /home/k8s1/bin/px auth login --manual
  195  /home/k8s1/bin/px deploy --dev_cloud_namespace plc
  196  px script list
  197  /home/k8s1/bin/px script list
  198  history 

```