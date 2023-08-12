## Installation and Configuration

Installation link krew: https://krew.sigs.k8s.io/docs/user-guide/setup/install/


Krew installation
``` bash
sudo apt update && sudo apt upgrade
sudo apt install git
sudo vim krew.sh

begin
  set -x; set temp_dir (mktemp -d); cd "$temp_dir" &&
  set OS (uname | tr '[:upper:]' '[:lower:]') &&
  set ARCH (uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/') &&
  set KREW krew-$OS"_"$ARCH &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/$KREW.tar.gz" &&
  tar zxvf $KREW.tar.gz &&
  ./$KREW install krew &&
  set -e KREW temp_dir &&
  cd -
end

sudo chmod +x krew.sh
sh krew.sh

# Export path
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

```

How to usage krew
``` bash
# To dowland krew plugin
kubectl krew update

# Discover avaible plugin
kubectl krew search

# Install plugin krew
kubectl krew install pod-logs

# krew plugin update
kubectl krew upgrade

# List install plugin
kubectl krew list

```

Outdated installation and configuration
``` bash

kubectl krew install outdated
kubectl outdated

```



Referance
```
Krew Install: https://computingforgeeks.com/install-kubectl-plugins-in-kubernetes-using-krew/
Krew Install: https://www.cyberithub.com/how-to-install-krew-plugin-manager-for-kubectl-cli-on-linux/

https://outdated.sh
https://github.com/replicatedhq/outdated



```