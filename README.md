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