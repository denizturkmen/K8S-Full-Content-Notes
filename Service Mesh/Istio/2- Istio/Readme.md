# What is the ISTIO

Istio is an **open-source** implementation of the **service mesh** originally developed by IBM, Google, and Lyft. It can layer transparently onto a **distributed application** and provide all the benefits of a service mesh like **traffic management, security, and observability.**
It's designed to work with a variety of deployments, like **on-premise, cloud-hosted, in Kubernetes containers**, and in services running on virtual machines. Although Istio is **platform-neutral**, it's quite often used together with **microservices** deployed on the **Kubernetes platform.**

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
Architecture: https://istio.io/latest/docs/ops/deployment/architecture/

```