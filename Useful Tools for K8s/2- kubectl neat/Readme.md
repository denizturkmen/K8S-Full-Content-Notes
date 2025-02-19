# Installing and Configuring Kubeneat for Yaml output format

Pre-requities
krew
git


Install krew
``` bash
# run
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed 's/x86_64/amd64/' | sed 's/arm.*$/arm/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

# export to ~/.bashrc
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

```

Installing neat via kubectl command
``` bash
# install
kubectl krew install neat


# verify
kubectl neat --help



```