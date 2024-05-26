# Kustomization example with python app

What is the kustomization?
What's feature on kustomization?
What's patch method on kustomization?


Firstly, We create and configure python code for env test.
``` bash
# docker build
docker image build --tag denizturkmen/python:env1 .

# run test
docker run --name test -e MY_VARIABLE="test" -dp 5000:5000 denizturkmen/python:env1

# run dev
docker run --name dev -e MY_VARIABLE="dev" -dp 5001:5000 denizturkmen/python:env1

```

Install kustomization after check kubectl version
``` bash
# Install on Linux 
curl -s "https://raw.githubusercontent.com/\ 
kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash

# Install on Mac with homebrew
brew install kustomize

# Install on Windows
choco install kustomize

```