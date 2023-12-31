# Harbour Registries Overview


# What is harbour Regitry









# Connecting to Harbor **HTTP**
IMPORTANT: If your installation of Harbor uses HTTP rather than HTTPS, you must add the option --insecure-registry to your client’s Docker daemon. 
By default, the daemon file is located at /etc/docker/daemon.json.

For example, add the following to your daemon.json file:
``` bash
{
"insecure-registries" : ["myregistrydomain.com:5000", "0.0.0.0"]
}
```

After you update daemon.json, you must restart both Docker Engine and Harbor.
``` bash
# Restart Docker Engine.
sudo systemctl restart docker

#Stop Harbor.
docker-compose down -v

# Restart Harbor.
docker-compose up -d

```


# Create a Prject on Harbor
A project in Harbor contains all repositories of an application. 
Images cannot be pushed to Harbor before a project is created. 
Role-Based Access Control (RBAC) is applied to projects, so that only users with the appropriate roles can perform certain operations.

There are two types of project in Harbor:

Public: Any user can pull images from this project. This is a convenient way for you to share repositories with others.
Private: Only users who are members of the project can pull images


# Create a user and Configuration
A user create and configuration for image pull ve push.
Authentication and authorization are done depending on a project.

Harbour registry login
``` bash
docker login harbour_registry_dns_name
    username and password
```






















# Referance
``` bash
Official: https://goharbor.io
Relases: https://github.com/goharbor/harbor/releases
Http Connection: https://goharbor.io/docs/1.10/install-config/run-installer-script/#connect-http
Create Project: https://goharbor.io/docs/1.10/working-with-projects/create-projects/
Deploy Http Registries: https://docs.docker.com/registry/insecure/#deploy-a-plain-http-registry
Nice: https://www.linode.com/docs/guides/setting-up-harbor-registry-with-lke



```
