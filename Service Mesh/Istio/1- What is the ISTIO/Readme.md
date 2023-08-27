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


# What is the ISTIO

Istio is an **open-source** implementation of the **service mesh** originally developed by IBM, Google, and Lyft. It can layer transparently onto a **distributed application** and provide all the benefits of a service mesh like **traffic management, security, and observability.**
It's designed to work with a variety of deployments, like **on-premise, cloud-hosted, in Kubernetes containers**, and in servicers running on virtual machines. Although Istio is **platform-neutral**, it's quite often used together with **microservices** deployed on the **Kubernetes platform.**

**Secure service-to-service** communication in a cluster with TLS encryption, strong identity-based authentication and authorization
**Automatic load balancing** for HTTP, gRPC, WebSocket, and TCP traffic
**Fine-grained control** of traffic behavior with rich routing rules, retries, failovers, and fault injection
**A pluggable policy** layer and configuration API supporting access controls, rate limits and quotas
**Automatic** metrics, logs, and traces for all traffic within a cluster, including cluster ingress and egress


# Understanding Istio Components

The Istio architecture consists of the **data plane** and the **control plane.**

**1- Data Plane:** The data plane of Istio primarily comprises an **extended version** of the **Envoy proxy**. Envoy is an **open-source edge** and service proxy that helps **decouple network concerns** from underlying applications. Applications **simply send** and **receive messages** to and from localhost, **without** any knowledge of the network topology.

At the core, Envoy is a network proxy operating at the **L3 and L4** layers of the **OSI model**. It works by using a chain of pluggable network filters to perform connection handling. Additionally, Envoy supports an additional **L7** layer filter for HTTP-based traffic. Moreover, Envoy has first-class support for **HTTP/2** and **gRPC transports.**

**Traffic Control:** Envoy enables the application of fine-grained traffic control with rich routing rules for HTTP, gRPC, WebSocket, and TCP traffic.

**Network Resiliency:** Envoy includes out-of-the-box support for automatic retries, circuit breaking, and fault injection

**Security:** Envoy can also enforce security policies and apply access control and rate-limiting on communication between underlying services

What is the **envoy proxy?**
It is a high-performance open source product written in C++ that intercepts the inbound and outbound traffic of services within the entire service mesh layer.


**2- Control Plane:** is responsible for **managing and configuring** the **Envoy proxies** in the data plane. The component that is responsible for this in the control plane is **istiod.** Here, istiod is responsible for **converting high-level routing rules and traffic control** behavior into **Envoy-specific configurations** and propagating them to sidecars at runtime.

If we recall the architecture of the Istio control plane from some time back, we'll notice that it used to be a set of independent components working together. It comprised components like Pilot for service discovery, Galley for configuration, Citadel for certificate generation, and Mixer for extensibility. Due to complexity, these individual components were merged into a single component called **istiod**.

What is the **sidecar?**

Sidecar is actually a proxy. Briefly, the proxy defined for each microservice is called. Located next to services. Services provide their access to target services through proxy through the proxy of that service.





 # Referance
 ``` bash
Get starting: https://istio.io/latest/docs/setup/getting-started/
Service Mesh: https://istio.io/latest/about/service-mesh/


 ```