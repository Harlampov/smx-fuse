/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

CXF OSGi HTTP WEB SERVICE
=========================

Purpose
-------
Create a web service with CXF and expose it through the OSGi HTTP
Service.


Explanation
-----------
The web service is a simple JAX-WS web service called HelloWorld. The 
interface and the implementation are located in the src/main/java/org/
apache/servicemix/examples/cxf directory of this example.

The beans.xml file, located in the src/main/resources/META-INF/spring
directory:

1. Imports the configuration files needed to enable CXF and OSGi work
   together.

2. Configures the web service endpoint as follows:

  <jaxws:endpoint id="helloWorld"
         implementor="org.apache.servicemix.examples.cxf.HelloWorldImpl"
         address="/HelloWorld"/>


Prerequisites for Running the Example
-------------------------------------
1. You must have the following installed on your machine:

   - JDK 1.6 or higher
   
   - Maven 2.2.1 or higher
   
  For more information, see the README in the top-level examples
  directory.


2. Start ServiceMix by running the following command:

  <servicemix_home>/bin/servicemix          (on UNIX)
  <servicemix_home>\bin\servicemix          (on Windows)


Running the Example
-------------------
You can run the example in two ways:

- A. Using a Prebuilt Deployment Bundle: Quick and Easy
This option is useful if you want to see the example up and
running as quickly as possible.

- B. Building the Example Bundle Yourself
This option is useful if you want to change the example in any
way. It tells you how to build and deploy the example. This
option might be slower than option A because, if you do not
already have the required bundles in your local Maven
repository, Maven will have to download the bundles it needs.

A. Using a Prebuilt Deployment Bundle: Quick and Easy
-----------------------------------------------------
To install and run a prebuilt version of this example, enter
the following command in the ServiceMix console:

  features:install examples-cxf-osgi
  
This command makes use of the ServiceMix features facility. For
more information about the features facility, see the README.txt
file in the examples parent directory.

To view the service WSDL, open your browser and go to the following
URL:

  http://localhost:8181/cxf/HelloWorld?wsdl

Note, if you use Safari, right click the window and select
'Show Source'.

Running a Client
----------------
To run the web client:

1. Open the client.html, which is located in the same directory as
   this README file, in your favorite browser.

2. Click the Send button to send a request.

   Once the request has been successfully sent, a response similar
   to the following should appear in the right-hand panel of the
   web page:
   
   STATUS: 200
   <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
     <soap:Body><ns2:sayHiResponse xmlns:ns2="http://cxf.examples.
     servicemix.apache.org/"><return>Hello John Doe</return>
     </ns2:sayHiResponse>
     </soap:Body>
   </soap:Envelope>

To run the java code client:

1. Change to the <servicemix_home>/examples/cxf-osgi
   directory.

2. Run the following command:

     mvn compile exec:java

   If the client request is successful, a response similar to the
   following should appear in the ServiceMix console:

   <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
     <soap:Body><ns2:sayHiResponse xmlns:ns2="http://cxf.examples.
       servicemix.apache.org/"><return>Hello John Doe</return>
       </ns2:sayHiResponse>
     </soap:Body>
   </soap:Envelope>


Changing /cxf servlet alias
---------------------------
By default CXF Servlet is assigned a '/cxf' alias. You can
change it in a couple of ways

a. Add org.apache.cxf.osgi.cfg to the /etc directory and set
   the 'org.apache.cxf.servlet.context' property, for example:
   
     org.apache.cxf.servlet.context=/custom
   
b. Use shell config commands, for example :
   
     config:edit org.apache.cxf.osgi   
     config:propset org.apache.cxf.servlet.context /super
     config:update


B. Building the Example Bundle Yourself
---------------------------------------
To install and run the example where you build the example bundle
yourself, complete the following steps:

1. If you have already run the example using the prebuilt version as
   described above, you must first uninstall the examples-cxf-osgi
   feature by entering the following command in the ServiceMix console:

     features:uninstall examples-cxf-osgi

   
2. Build the example by opening a command prompt, changing directory to
   examples/cxf-osgi (this example) and entering the following Maven
   command:

     mvn install
   
   If all of the required OSGi bundles are available in your local
   Maven repository, the example will build very quickly. Otherwise
   it may take some time for Maven to download everything it needs.
   
   The mvn install command builds the example deployment bundle and
   copies it to your local Maven repository and to the target directory
   of this example.
     
3. Install the example by entering the following command in
   the ServiceMix console:
   
     features:install examples-cxf-osgi
       
   It makes use of the ServiceMix features facility. For more
   information about the features facility, see the README.txt file
   in the examples parent directory.

To view the service WSDL, open your browser and go to the following
URL:

  http://localhost:8181/cxf/HelloWorld?wsdl

Note, if you use Safari, right click the window and select
'Show Source'.

You can try running a client against your service by following the
instructions in the "Running a Client" section above.


Stopping and Uninstalling the Example
-------------------------------------
To stop the example, you must first know the bundle ID that ServiceMix
has assigned to it. To get the bundle ID, enter the following command
at the ServiceMix console:

  osgi:list

At the end of the listing, you should see an entry similar to the
following:

  [170] [Active     ] [Started] [  60] Apache ServiceMix Example :: CXF OSGi (4.2.0.0)

In this case, the bundle ID is 170.

To stop the example, enter the following command at the ServiceMix
console:

  osgi:stop <bundle_id>

For example:

  osgi:stop 170

To uninstall the example, enter one of the following commands in
the ServiceMix console:

  features:uninstall examples-cxf-osgi
 
or
 
  osgi:uninstall <bundle_id>
  

Viewing the Log Entries
-----------------------
You can view the entries in the log file in the data/log
directory of your ServiceMix installation, or by typing
the following command in the ServiceMix console:

  log:display
