# What is the Service Mesh;

Service Mesh: A service mesh is a dedicated infrastructure layer that controls **service-to-service** communication over a network.Contains sidecar proxy, service discover, laod balancing and circuit breaker. In general, it is an infrastructure that enables microservices to communicate with each other.

Modern applications are typically architected as distributed collections of microservices, with each collection of microservices performing some discrete business function. A service mesh is a dedicated infrastructure layer that you can add to your applications. It allows you to transparently add capabilities like **observability, traffic management, and security**, **without** adding them to **your own code**. The term **service mesh** describes both the type of software you use to implement this pattern, and the **security** or **network** domain that is created when you use that software.

As the deployment of distributed services, such as in a **Kubernetes-based system**, grows **in size** and **complexity**, it can become harder to understand and manage. Its requirements can include **discovery, load balancing, failure recovery, metrics, and monitoring**. A service mesh also often addresses more complex operational requirements, like A/B testing, canary deployments, rate limiting, access control, encryption, and end-to-end authentication.

Service-to-service communication is what makes a distributed application possible. Routing this communication, both within and across application clusters, becomes increasingly complex as the number of services grow. Istio helps reduce this complexity while easing the strain on development teams.


# Features of a Service Mesh;

1- Traffic Management: This includes **dynamic service discovery** and **routing.** It also enables some interesting use-cases like **traffic shadowing** and **traffic splitting.** These are very useful for performing **canary** releases and **A/B testing**.As all **service-to-service** communication is handled by the service mesh, it also enables some **reliability features.** For instance, a service mesh can provide **retries, timeouts, rate-limiting, and circuit breakers.**

**Note:** Traffic routing are **virtual services** and **destination rules**
A virtual service consists of **one or more routing** rules that are evaluated in order. After the routing rules of **a virtual service** are evaluated, **the destination rules are applied**. The destination rules help us to control the traffic to a destination. for instance, grouping service instances by version.

2- Security: A service mesh typically also handles the security aspects of the **service-to-service communication.** This includes enforcing **traffic encryption** through mutual TLS (MTLS), **providing authentication** through **certificate validation**, and **ensuring authorization** through access policies. There can also be some interesting use cases of security in a service mesh. For instance, we can achieve network segmentation allowing some services to communicate while prohibiting others.

3- Observability: Robust observability is the underpinning requirement for handling the complexity of a distributed system. Because a service mesh handles all communication. A service mesh can generate a lot of metrics like **latency, traffic, errors, and saturation.** 




# Referance
 ``` bash
What is the Service Mesh: https://istio.io/latest/about/service-mesh/


```