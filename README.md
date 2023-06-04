<!-- https://www.educative.io/answers/how-do-you-dockerize-a-maven-project -->

mkdir my-app
```bash
mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false

```


cd my-app
```bash
```

Change the pom.xml from:
<plugin>
    <artifactId>maven-jar-plugin</artifactId>     
    <version>3.0.2</version>
</plugin>

to:

<plugin>
    <!-- Build an executable JAR -->
<groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-jar-plugin</artifactId>
          <version>3.1.0</version>
      <configuration>
        <archive>
          <manifest>
                <addClasspath>true</addClasspath>
                <classpathPrefix>lib/</classpathPrefix>
                <mainClass>com.mycompany.app.App</mainClass>
          </manifest>
        </archive>
      </configuration>
</plugin>

```bash
```


App.java:

package com.mycompany.app;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;

public class App 
{
    public static void main( String[] args ) throws IOException {

        HttpServer server = HttpServer.create(new InetSocketAddress(8080), 0);
        server.createContext("/", new MyHandler());
        server.setExecutor(null); // creates a default executor
        server.start();

    }

    static class MyHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange t) throws IOException {
            String response = "<h1> Hello World!!!! I just Dockerized a Maven Project </h1>";
            t.sendResponseHeaders(200, response.length());
            OutputStream os = t.getResponseBody();
            os.write(response.getBytes());
            os.close();
        }
    }
}

On the pom.xml:
<build>
  <finalName>my-maven-docker-project</finalName>
</build>





This is the artifact:
https://mvnrepository.com/artifact/io.openlineage/openlineage-java/0.26.0
Here is the circle CI: https://github.com/OpenLineage/OpenLineage/blob/a8ec16caf8daec84e3ab82063e88d35b40c6e6f8/.circleci/workflows/openlineage-java.yml#L2

Here we build the jar: https://github.com/OpenLineage/OpenLineage/blob/a8ec16caf8daec84e3ab82063e88d35b40c6e6f8/.circleci/workflows/openlineage-java.yml#LL4C15-L4C21
This is the reference how to build the jar:
https://github.com/OpenLineage/OpenLineage/blob/a8ec16caf8daec84e3ab82063e88d35b40c6e6f8/.circleci/continue_config.yml#L78-L109
Here is where the artifact test is stored: https://github.com/OpenLineage/OpenLineage/blob/a8ec16caf8daec84e3ab82063e88d35b40c6e6f8/.circleci/continue_config.yml#L100

Here is how we release: https://github.com/OpenLineage/OpenLineage/blob/a8ec16caf8daec84e3ab82063e88d35b40c6e6f8/.circleci/continue_config.yml#L111



<groupId>org.company</groupId>
<artifactId>sample</artifactId>
<packaging>pom</packaging>
<version>0.9-SNAPSHOT</version>

<distributionManagement>
    <repository>
        <id>space-maven-hello-world</id>
        <url>https://maven.pkg.jetbrains.space/naturalett/p/main/maven-hello-world</url>
    </repository>
</distributionManagement>

eyJhbGciOiJSUzUxMiJ9.eyJzdWIiOiIxbXlteEgxeGsySVoiLCJhdWQiOiJjaXJjbGV0LXdlYi11aSIsIm9yZ0RvbWFpbiI6Im5hdHVyYWxldHQiLCJuYW1lIjoibGlkb3IuZXR0aW5nZXIiLCJpc3MiOiJodHRwczpcL1wvbmF0dXJhbGV0dC5qZXRicmFpbnMuc3BhY2UiLCJwZXJtX3Rva2VuIjoiUEJyN0YxaGtGMG0iLCJwcmluY2lwYWxfdHlwZSI6IlVTRVIiLCJpYXQiOjE2ODU2Mjk2MTN9.S6e-OJkrfI2o92ke1KsKPEY_AlaGoL938p0xrHwMgP68IzDZgibgrQ4xEv8-hurHUoZBoObzTubfbJoRoDPfkX4l3rTVcZNvHrfM2Ud-x7242ESxRJt7AH1JnjFxi0YF6339al-FOQvm4p3T11djRLo38CFdfKDV-hOc_upbbuQ
