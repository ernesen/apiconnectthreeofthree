------

### API Lifecycle and Governance in the Enterprise: Build & Deployment Stage Part (3 of 3)

The objective of any API is to meet the business’s goals in mind. Complicated as it may sound, building an API is easy! Where the challenge lies is in developing the right API that does precisely what the business need by following the principle of **good design** where APIs need to be consistent to be easily consumable. APIs can unlock data, increase agility, feed innovation, and speed time-to-market.

![img](https://cdn-images-1.medium.com/max/1000/1*_uGpKyTJSxsOahJM2DGs1g.png)[**Figure 1: API Implementation for Entrepreneurs**](https://nordicapis.com/first-time-api-implementation-for-entrepreneurs/)

This is the last in a series of three posts on API Lifecycle and Governance in the Enterprise.

- Part 1: [Plan](https://medium.com/ibm-garage/api-lifecycle-and-governance-in-the-enterprise-plan-stage-part-1-of-3-d350b65080a2)
- Part 2: [Design](https://medium.com/ibm-garage/api-lifecycle-and-governance-in-the-enterprise-design-stage-part-2-of-3-be47a79ed496)
- **Part 3: Build & Deployment**

### Managing API Endpoints with IBM API Connect

IBM API Connect is an API management solution from IBM that offers capabilities to create, run, manage, and secure APIs and microservices. By using these capabilities, the full lifecycle of APIs for on-premises and cloud environments can be managed. We will walk you through a step-by-step guide on how to build your APIs coming from the design phase, starting with the API endpoints from the previous post.

![img](https://cdn-images-1.medium.com/max/1000/1*cWDv-mxSp53rpLs2HjxXFA.png)

As an integral part of the software development process in general, testing is essential for your API.

### Create Secure Gateway service with IBM Cloud

The Secure Gateway Service allows access to backend service running on internal customer network from the cloud it manages the mapping between your local and remote destinations and monitors all of your traffic via a secure tunnel.

![img](https://cdn-images-1.medium.com/max/1000/1*2c6yGMsq98wbR1XqNgI8fQ.png)[**Figure 3: Secure Gateway**](https://1.cms.s81c.com/sites/default/files/2019-02-21/1_diagramSGW.png)

Create a Secure Gateway instance:

- [Secure Gateway](https://cloud.ibm.com/catalog/services/secure-gateway)

Then follow the instructions here to properly setup the connection to your on-premise resources:

- [Setting up Secure Gateway connection](https://github.com/ernesen/ibm-cloud-functions-with-on-prem-resources/blob/master/secure-gateway-connection.md)

### Deploying to OpenShift

OpenShift is an open-source software; it is a family of containerization software developed by Red Hat acquired by IBM July 9, 2019. Its flagship product is the OpenShift Container Platform — an on-premises platform as a service built around Docker containers orchestrated and managed by Kubernetes on a foundation of Red Hat Enterprise Linux. It is trusted by more than 1000 customers to deliver business-critical applications, whether they’re migrating existing workloads to the cloud or building new, cutting-edge experiences for their users.

We will leverage on its capability to deploy our banking API solution by:

- Creating a project and deploy pre-existing application container images.
- Building application container images from source and deploy them.
- Implementing and extending application image builders.
- Using incremental and chained builds to accelerate build times.
- Making an application visible outside the OpenShift cluster to run on IBM Secure Gateway
- Automating builds by using a webhook to link OpenShift to a Git repository.

```
./deploying_on_opshift.sh
```



<iframe width="700" height="250" src="/media/659dcb10d10ed47a3a7507395db0a1ce" data-media-id="659dcb10d10ed47a3a7507395db0a1ce" data-thumbnail="https://i.embed.ly/1/image?url=https%3A%2F%2Fgithub.githubassets.com%2Fimages%2Fmodules%2Fgists%2Fgist-og-image.png&amp;key=4fce0568f2ce49e8b54624ef71a8a5bd" allowfullscreen="" frameborder="0"></iframe>

### Testing Approaches

All APIs being built should be tested in some form. There are a variety of techniques and approaches to testing. These will not be exhaustively covered here. In general, we can model the API testing process like this:

![img](https://cdn-images-1.medium.com/max/1000/1*G62rShiEEiPFSAV6pat72w.png)**Figure 4: Testing Approaches**

APIs can be tested using a variety of tools:

- (Very basic APIs) curl or wget
- [Postman](https://www.getpostman.com/)
- [JMeter](http://jmeter.apache.org/)
- [If installed, the API Connect Developer Portal](https://www.ibm.com/support/knowledgecenter/SSFS6T/com.ibm.apic.devportal.doc/cmsportal_testtool.html)
- … (an almost infinite set of other tools)

Also, in some cases (particularly during the earlier phases of testing) it can be useful to simulate the backend, which in most companies situation is a SOAP-based web service. There are a variety of ways of simulating that backend:

- Hardcoded JSON file
- Simulated service implementation (typically another SOAP service on IBM WebSphere Suite) There are a variety of benefits to simulating the backend:
- APIs can be developed on independent lifecycle to the backend
- When doing problem diagnosis, issues in the API can be isolated from issues in the backend. Ultimately all testing should be owned by the same organization (squad) that owns the development of the API. That would initially likely be the API Developers aligned to a project. 

#### Development / SIT / Test-level

All APIs should undergo testing. Ideally, before APIs are even deployed to the shared SIT (system integration testing) / Test API Connect environment in some companies, they should undergo a basic level of testing on the developer’s machine. The exact approach is left up to the developer, but they should satisfy themselves that the API appears to work. Once the API is deployed to the shared Dev / SIT environment, it should be fully tested using a standard testing tool or method, such as Postman. This enables the test to be saved in source control as well as the API itself, meaning that the test can be repeatedly recreated over time.

#### UAT

When an API passes all the suitable tests on the development environment, it is time to move it onto the UAT (user acceptance testing) environment. At this point testing should be more formalized. If the API is at this stage connected to a real UAT backend, the same tests that were run in development should be repeated. In addition, tests to validate the additional coverage of the API should be run. In time, it will likely be beneficial to companies to build up a dedicated team for constructing and validating these additional tests.

#### Production

On production go-live events, when APIs are promoted into production, tests should be rerun. However, since APIs are connected to real production backends, it’s important to make sure that data is not damaged. 

### Other ways to improve code quality

As well as formal code testing, there are some other ways to improve code quality:

- Code reviews can provide a way for more senior experienced developers to provide feedback on the APIs built by more junior or novice developers. Typically, these are semi-formalized sessions, where developers review the work of others, ideally with them in the room feeding back and making changes in place.
- Pair programming, which is a common technique for improving code quality, involves developers working together to build APIs and resolve issues with them. We recommend that companies institute both practices.
- Test-Driven Development (TDD) is a software development process of writing automated tests to ensure that code works before writing the implementation. First, you write a test, watch it fail (red), write the implementation, watch the test pass (green), and refactor if needed. Repeat the cycle as you build out the system.

### Implementation Approach

When implementing APIs using API Connect, there are essentially two choices:

- Implementing APIs using the developer toolkit/API Manager as APIs which use the API Gateway at runtime only.
- Implementing APIs (based on LoopBack) which use the API Connect IBM Liberty Collective— in other words, they have some associated Node.JS/LoopBack code. We sometimes refer to these as microservices. Note that this is somewhat different from the word microservices in the architectural sense (meaning small services which can be distinguished from monoliths). Here, we are focusing on word as it is used in an API Connect context — meaning the implementation approach.

The following guidelines should be used to choose the implementation approach:

- In general, the API Gateway approach should be adopted if there is no compelling reason requiring the microservice (coding) approach. This is because it requires minimal coding, less infrastructure, and is generally simpler. This may prohibit easy connectivity to non-HTTP types of backend service.
- For more complex integration, StrongLoop (microservices) can provide integration with databases and other types of backends. Code in StrongLoop can also be used to customize the behavior of APIs more easily. In general, we wouldn’t recommend making this code complex — when trying to integrate with backends StrongLoop doesn’t explicitly support (e.g. AD), an ESB or integration engine (e.g. IBM Integration Bus) is more suitable.

Another question that should be considered is the number of backend integrations that an API requires. APIs should not be used to orchestrate or co-ordinate significant numbers of backend service invocations. If any of the following guidelines are met, orchestrations should not be implemented in API Connect:

- When the expected response time of the backend systems exceeds the expected total response time of the API itself (plus a small factor of ~0.5s for the API execution itself). If this is exceeded the backend services will need to be refactored and performance improved. In practice this is likely to limit the number of backends to a maximum of approximately 2–3.
- When the number of backend orchestrations to be performed are indeterminate (in other words, it’s not known how many invocations will be needed ahead of time). In this case the backend service should be refactored to widen its scope, so a deterministic number can be performed.
- When any of the backend systems are known to be regularly unreliable (for example, one invocation may fail whilst the others succeed). Note that strictly speaking this does not rule out implementing this as an API but will make the job of the API developer significantly more complex, as they will need to deal with the complexities of error handling in this case and send back a result payload showing partial success. The client may also have to implement partial retry logic.
- When it is critical that the Atomicity principle is maintained between different service invocations (for example, one invocation debits money from an account, and credits it elsewhere). HTTP — the mechanism typically being used to call these backend services — is inherently unreliable and is not designed to be atomic/transactional. In this case an ESB or BPM solution should be used, or the backend services should be refactored to be atomic.
- Long-running orchestration (meaning more than ~10s) should always be performed using asynchronous communication mechanisms (meaning queueing or similar) rather than synchronous messaging such as HTTP — the failure modes are far more straightforward. In this case, two APIs should be implemented, one to initiate the orchestration (which should then be managed by an ESB), and another to progress-check/pick up the result. The front-end UI would need to reflect this initiate/progress-check distinction. In general, also, Frameworks that abstract out the API Gateway and don’t allow for modelling the data in the API Gateway (and therefore enforcing its structure according to the [OpenAPI Specification OAS — formerly Swagger](https://github.com/OAI/OpenAPI-Specification)) should be avoided.

There are basically two approaches going forward which should be considered:

1. The “official” approach for the API Connect product is to docker-ize (containerize) APIC microservices. The API Connect documentation has a section describing an approach for installing a runtime environment for microservices inside container orchestrators such as Kubernetes. Nevertheless, The company would be responsible for running this container layer themselves (which implies building skills, monitoring them, etc.). An alternative would be to use a managed platform, such as **IBM Cloud Pak for Integration**. This has many implications, both technical and commercial, and would need further investigation.
2. The alternative approach is to host the microservices on IBM Liberty Collective

In general, in our opinion, (1) appears to be a better fit for companies. Companies should consider developing skills in Docker, Kubernetes, OpenShift and a container orchestrator in any event, which is the keystone of how applications are hosted, and its influence stretches far beyond APIC and IBM.

### Catalogs

When you publish an API Product to a catalog, that API Product becomes available on the Developer Portal that is associated with that catalog. An API Product can be published to multiple catalogs. You might have different catalogs for different consumers, such as one catalog for business partners and another for internal usage. You might also use different catalogs for continuous integration; for example, one catalog for preproduction activities, such as quality assurance and test and another catalog for production use. 

### Security

The terms in this section title are often overloaded in the IT industry and require clarification. In this post, these terms have the following meaning.

**Authentication**: An action used to determine the identity of a principal. A principal can be a human user, a machine, VM, system, or an application. A successful authentication determines the identity of the principal. It does not determine what actions the principal can undertake.

**Authorization**: Authorization determines whether an authenticated user is allowed to perform an action on a resource. Authorization decisions are made separately from authentication decisions.

### Conclusion

We hope you have found this series of posts informative. We aimed to provide at least a tiny amount of relevant information to your quest of building a great API. Let’s quickly recap what we learned so far. Part one was about the importance of having a good **Governance** with **“Planning an API Initiative Strategy and Governance Model”** and “**API Lifecycle**” in mind. Part two provided an overview of API Design, their **characteristics**, **business value**, **lifecycle**, and **strategy**. Part three was to bring this home with an implementation approach. It stressed on the key topics such as **API Endpoints**, **Secure Gateway**, **Deploy on OpenShift**, **Testing Approaches**, **Implementation Approach**, and **Security**. This was not mean to be exhaustive but enough to get you to understand the API strategy and its impact. We shared some relevant information in your quest of building a great API as you embark on your Journey to Cloud.

### Attribution

Special thank you to [**Enrique (Ike) Relucio**](mailto:relucio@ph.ibm.com?source) from **IBM Garage ASEAN**, who shared his knowledge of the banking industry and the API Economy. Thank you to [**Kok Sing Khong**](mailto:kskhong@au1.ibm.com?source) from **Integration & Development Lead IBM Cloud and Cognitive Software** who shared his expertise on API Connect. Also, thank you to [**Aldred Benedict**](https://medium.com/@aldredbenedict) from **Blockchain Labs Developer, IBM Industry Platform** who shared his expertise on OpenShift.

### References

- [API design](https://docs.microsoft.com/en-us/azure/architecture/best-practices/api-design)
- [Build a digital bank](https://github.com/IBM/innovate-digital-bank)
- [Building API Services: A Beginner’s Guide](https://medium.com/google-cloud/building-api-services-a-beginners-guide-7274ae4c547f)
- [Full guide to building a Serverless API with zero code](https://medium.com/hackernoon/full-guide-to-building-a-serverless-api-with-zero-code-c4f7871998f5)
- [Getting Started | IBM API Connect Test and Monitor](https://ibm-apiconnect.github.io/test-and-monitor/gettingstarted)
- [Secure Gateway: everything you ever wanted to know](https://www.ibm.com/cloud/blog/secure-gateway-everything-ever-wanted-know)
- [The Outrageous Cost of Skipping TDD & Code Reviews](https://medium.com/javascript-scene/the-outrageous-cost-of-skipping-tdd-code-reviews-57887064c412)

------

**Bring your plan to the IBM Garage.**Are you ready to learn more about working with the IBM Garage? We’re here to help. Contact us today to schedule time to speak with a Garage expert about your next big idea. Learn about our IBM Garage Method, the design, development and startup communities we work in, and the deep expertise and capabilities we bring to the table.

[*Schedule a no-charge visit*](https://www.ibm.com/account/reg/us-en/signup?formid=urx-38887) *with the IBM Garage.*