# Advance Java Lab

Advanced Java lab work, experiments, and project files.

## 👤 Author Details

| Field   | Details           |
|---------|-------------------|
| Name    | Koustubh Chouhan  |
| Section | B                 |
| Roll No | 24EGJCS109        |

## 📂 Repository Structure

```text
adv_java_class/
├── Experiment-01-Student-Registration-Form/
├── experiment-02-MVCcalculator/
├── experiment-03-JDBC/
├── experiment-04-JSP-Student-App/
├── experiment-05-RMI/
├── experiment-06-ServerClient/
├── experiment-07-servlet/
├── shopsphere/
│   ├── database/
│   └── web/
├── .gitignore
└── README.md
```

## 🧪 Lab Projects

### Experiment 01: Student Registration Form

Contains a Java student registration form exercise in
`Experiment-01-Student-Registration-Form/`.

### Experiment 02: MVC Calculator

A desktop calculator demonstrating the Model-View-Controller pattern.
The source files are in `experiment-02-MVCcalculator/`.

### Experiment 03: JDBC

Demonstrates Java Database Connectivity with MySQL. The source code is in
`experiment-03-JDBC/src/`, and the MySQL Connector/J dependency is in
`experiment-03-JDBC/lib/`.

### Experiment 04: JSP Student App

A Java web application using Servlets and JSP. The Maven project is in
`experiment-04-JSP-Student-App/`.

### Experiment 05: RMI

Demonstrates Java Remote Method Invocation with calculator client, server,
and implementation classes in `experiment-05-RMI/`.

### Experiment 06: Server and Client

A Java socket-based server and client exercise in
`experiment-06-ServerClient/`.

### Experiment 07: Servlet

A Jakarta Servlet web application managed with Maven. The project is in
`experiment-07-servlet/servlet/`.

### ShopSphere Project

ShopSphere is the main web application project in `shopsphere/`. It includes:

- A database schema in `shopsphere/database/shopsphere.sql`
- A Maven WAR project in `shopsphere/web/`
- Jakarta Servlets and JSP pages
- User registration and login
- Product management
- Shopping cart and checkout
- Order placement and administration
- MySQL database connectivity

## 🛠️ Tech Stack

- Java 25 LTS
- Java Swing
- Java Servlets and JSP
- Jakarta Servlet and JSP APIs
- Apache Maven
- Apache Tomcat
- MySQL and JDBC
- Java RMI
- Java socket programming

## 🚀 Getting Started

Clone the repository:

```bash
git clone https://github.com/koustubhchouhan/advance_java_lab.git
cd advance_java_lab
```

### Running Standalone Java Experiments

Open the relevant experiment folder in an IDE or compile the source files
with JDK 25. For example:

```bash
javac experiment-02-MVCcalculator/*.java
java -cp experiment-02-MVCcalculator Main
```

The RMI and Server/Client experiments require their server process to be
started before their corresponding client process. Configure the classpath
and database connection details as required by each exercise.

### Building Maven Web Projects

Build the ShopSphere WAR:

```bash
mvn -f shopsphere/web/pom.xml clean package
```

The generated WAR is created at:

```text
shopsphere/web/target/shopsphere.war
```

The other Maven web projects can be built similarly:

```bash
mvn -f experiment-04-JSP-Student-App/pom.xml clean package
mvn -f experiment-07-servlet/servlet/pom.xml clean package
```

Deploy the generated WAR file to a compatible Apache Tomcat installation.
The ShopSphere application is designed for Jakarta-compatible Tomcat
versions, such as Tomcat 11.

### ShopSphere Database

1. Install MySQL.
2. Create/import the schema from
   `shopsphere/database/shopsphere.sql`.
3. Update the database connection settings in
   `shopsphere/web/src/main/java/com/shopsphere/util/DBConnection.java`.
4. Build and deploy the ShopSphere WAR.

## 📄 License

This repository is for educational purposes.
