# 10 Software Architecture Patterns in Enterprise Software Development

Article Link: https://medium.com/interviewnoodle/10-software-architecture-patterns-in-enterprise-software-development-fabacb5ed0c8
Author: JIN
Date Added: February 24, 2022 8:36 PM
Tag: Coding Standards, Design-Patterns, Microservices

Youtube: 

[https://www.youtube.com/watch?v=BrT3AO8bVQY](https://www.youtube.com/watch?v=BrT3AO8bVQY)

1. **Layered Architecture**

![https://miro.medium.com/max/1225/0*gOIZ5EIo5RkZLNkM.png](https://miro.medium.com/max/1225/0*gOIZ5EIo5RkZLNkM.png)

- Each layer provides service to the next high-level. Every level is abstract.
- **Presentation layer** (UI layer)
- **Application layer** (service layer)
- **Business logic layer** (domain layer)
- **Data access layer** (persistence layer)

![https://miro.medium.com/max/329/0*qOKwr55qwSaPEdeT.jpg](https://miro.medium.com/max/329/0*qOKwr55qwSaPEdeT.jpg)

**The real-life application**

- E-commerce web application
- General desktop application

**2. Client-server Architecture**

![https://miro.medium.com/max/1225/0*SC8uSZJIPoC6cLCn.png](https://miro.medium.com/max/1225/0*SC8uSZJIPoC6cLCn.png)

- Consists of a server + multiple clients
- The server provides services to multiple clients.
- The client request the specific service, the server will provide the relevant service

![https://miro.medium.com/max/497/0*PY0Bxn0xTJLvWpFT.png](https://miro.medium.com/max/497/0*PY0Bxn0xTJLvWpFT.png)

**The real-life application**

- Banking
- Email

**3. Master-slave Architecture**

![https://miro.medium.com/max/1225/0*Gi6E0GkdBTxHppcJ.jpg](https://miro.medium.com/max/1225/0*Gi6E0GkdBTxHppcJ.jpg)

![https://miro.medium.com/max/1225/0*FEi8wuiupabAOoS1.png](https://miro.medium.com/max/1225/0*FEi8wuiupabAOoS1.png)

- The master component will assign works among the identical slave components and computes a final result from the results which the slaves return

**The real-life application**

- In database replication, the master database is considered an authoritative source, the slave database synchronizes with the master database
- Peripheral connected to a bus in computer architecture

**4. Pipe-filter Architecture**

![https://miro.medium.com/max/571/0*GLsv6gl412NU1gFS.png](https://miro.medium.com/max/571/0*GLsv6gl412NU1gFS.png)

- Data will be processed and filtered and passed through pipes. It is used for buffering or for synchronization purposes.

**The real-life application**

![https://miro.medium.com/max/571/0*V908tkqhh91mMatt.png](https://miro.medium.com/max/571/0*V908tkqhh91mMatt.png)

- A compiler which includes lexical analysis, parsing, semantic analysis, and code generation
- Workflows in bioinformatics

**5. Broker Architecture**

![https://miro.medium.com/max/1225/0*EoSTOfTRzYV5Dy7J.jpg](https://miro.medium.com/max/1225/0*EoSTOfTRzYV5Dy7J.jpg)

![https://miro.medium.com/max/1225/0*RcI5W2fVypgozkup.png](https://miro.medium.com/max/1225/0*RcI5W2fVypgozkup.png)

- Distributed systems will decoupled components
- A broker component coordinates the communication among the servers
- Clients request a service from the broker, and the broker redirects the request to the relevant server to trigger a suitable service from its registry

**The real-life application**

- Apache ActiveMQ
- Apache Kafka
- RabbitMQ
- JBoss Messaging

**6. Peer-to-peer pattern**

![https://miro.medium.com/max/1225/0*MnQ4GSotEu5e6GHv.jpg](https://miro.medium.com/max/1225/0*MnQ4GSotEu5e6GHv.jpg)

![https://miro.medium.com/max/1225/0*PxBw3Yh8CpMAlMNz.png](https://miro.medium.com/max/1225/0*PxBw3Yh8CpMAlMNz.png)

- A peer may act as a client or a server or both, it changes depending on the role dynamically with time
- A peer can request services from other peers.

**The real-life application**

- File-sharing networks (Gnutella and G2)
- Multimedia protocols (P2PTV and PDTP)
- Crytocurrency-based coin (bitcoin and blockchain)

****[Gnutella - WikipediaGnutella is a peer-to-peer network protocol. Founded in 2000, it was the first decentralized peer-to-peer network of…**
en.wikipedia.org](https://en.wikipedia.org/wiki/Gnutella)

****[Gnutella2 - WikipediaGnutella2, often referred to as G2, is a peer-to-peer protocol developed mainly by Michael Stokes and released in 2002…**
en.wikipedia.org](https://en.wikipedia.org/wiki/Gnutella2)

****[P2PTV - WikipediaP2PTV refers to peer-to-peer (P2P) software applications designed to redistribute video streams in real time on a P2P…**
en.wikipedia.org](https://en.wikipedia.org/wiki/P2PTV)

****[Peer Distributed Transfer Protocol - WikipediaThe Peer Distributed Transfer Protocol is an Internet file transfer protocol for distributing files from a central…**
en.wikipedia.org](https://en.wikipedia.org/wiki/Peer_Distributed_Transfer_Protocol)

****[Bitcoin - Open source P2P moneyBitcoin is an innovative payment network and a new kind of money. Find all you need to know and get started with…**
bitcoin.org](https://bitcoin.org/en/)

****[Blockchain.com - The Most Trusted Crypto CompanyInstantly buy Bitcoin with credit card, debit card, or by linking your bank. Fund a Rewards Account with crypto and…**
www.blockchain.com](https://www.blockchain.com/)

**7. Event-bus Architecture**

![https://miro.medium.com/max/1225/0*EWCKl0AYZ2oM6Pwv.jpg](https://miro.medium.com/max/1225/0*EWCKl0AYZ2oM6Pwv.jpg)

![https://miro.medium.com/max/1225/0*qeNcibagRq6IrtTy.png](https://miro.medium.com/max/1225/0*qeNcibagRq6IrtTy.png)

![https://miro.medium.com/max/1225/0*qoMyNrH2JVHmlvFV.png](https://miro.medium.com/max/1225/0*qoMyNrH2JVHmlvFV.png)

- 4 major components: event source, event listener, channel, and event bus
- Sources publish messages to a particular channel through an event bus
- Listeners subscribe to a particular channel
- Listeners are notified of messages when the publisher post some messages

**The real-life application**

- Android Development
- Azure DevOps
- Notification services

**8. Model-view controller Architecture**

![https://miro.medium.com/max/1225/0*PzdjaD4qvWBXD_Gj.jpg](https://miro.medium.com/max/1225/0*PzdjaD4qvWBXD_Gj.jpg)

![https://miro.medium.com/max/1225/0*lun5rZD1mAyiyRo8.png](https://miro.medium.com/max/1225/0*lun5rZD1mAyiyRo8.png)

![https://miro.medium.com/max/1225/1*HJIQ7-gerTOzePTaniwwIw.png](https://miro.medium.com/max/1225/1*HJIQ7-gerTOzePTaniwwIw.png)

- **MVC pattern**
- **Model** — Contains the core functionality and data (business logic)**view** — Displays the information to the user**Controller** — handles the input from the user

**The real-life application**

- Web frameworks (Django and Rails)
- Many programming languages (C #)

**9. Blackboard Architecture**

![https://miro.medium.com/max/1225/0*15gRmbxVxM54SRok.png](https://miro.medium.com/max/1225/0*15gRmbxVxM54SRok.png)

![https://miro.medium.com/max/1225/0*9W0PtgPXpCzXt9_c.jpg](https://miro.medium.com/max/1225/0*9W0PtgPXpCzXt9_c.jpg)

- Good for no deterministic solution
- **Blackboard** — A structured object for input**knowledge Source** — modules with their own business logic**Control component** — selects, configures, and executes modules
- New data objects are added to the blackboard

**The real-life application**

- Protein structure identification
- Speech recognition
- Vehicle identification and tracking
- Sonar signals interpretation.

**10 . Interpreter Architecture**

![https://miro.medium.com/max/1225/0*NnBIT25rGfCADJHI.jpg](https://miro.medium.com/max/1225/0*NnBIT25rGfCADJHI.jpg)

![https://miro.medium.com/max/1225/0*bG2aE8HiHNx3Fs8N.png](https://miro.medium.com/max/1225/0*bG2aE8HiHNx3Fs8N.png)

![https://miro.medium.com/max/1155/0*qDwRyND2XbqqHD0c.png](https://miro.medium.com/max/1155/0*qDwRyND2XbqqHD0c.png)

- Interpret programs written in a dedicated language
- evaluate lines of programs

**The real-life application**

- Database Query languages (SQL)
- Communication protocols related to languages

****The advantage and disadvantages of each architecture****

![https://miro.medium.com/max/1225/0*jZKWc10Opwky3GzX.png](https://miro.medium.com/max/1225/0*jZKWc10Opwky3GzX.png)

# **References**

****[10 Common Software Architectural Patterns in a nutshellEver wondered how large enterprise scale systems are designed? Before major software development starts, we have to…**
towardsdatascience.com](https://towardsdatascience.com/10-common-software-architectural-patterns-in-a-nutshell-a0b47a1e9013)

****[10 Most Common Software Architectural Patterns - NIX UnitedAre you an entrepreneur planning to launch your IT application? Or, are you an enterprise IT manager in charge of…**
nix-united.com](https://nix-united.com/blog/10-common-software-architectural-patterns-part-1/)

*Last but not least, if you are not a Medium Member yet and plan to become one, I kindly ask you to do so using the following link. I will receive a portion of your membership fee at no additional cost to you.*