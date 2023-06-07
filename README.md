
# Maven Release

Getting started with Maven Release


## Links

Login to your [sonatype](https://s01.oss.sonatype.org/) account to release the version

| Type | URL     | Description                |
| :-------- | :------- | :------------------------- |
| Snapshot | [sonatype](https://s01.oss.sonatype.org/content/repositories/snapshots/io/github/naturalett/my-app/) | Snapshot versions |
| Release | [sonatype](https://repo.maven.apache.org/maven2/io/github/naturalett/my-app/) | Release versions |
| Release | [central-sonatype](https://central.sonatype.com/artifact/io.github.naturalett/my-app/1.0.0/versions) | Release versions |


## Documentation

Well explained blog of [How to Publish Artifacts to Maven Central](https://dzone.com/articles/how-to-publish-artifacts-to-maven-central). \
Your Sonatype account [link](https://s01.oss.sonatype.org/)\
Your Jira ticket login [link](https://issues.sonatype.org/)




## Demo

How do you release a version?

Manually:\
&nbsp;&nbsp;&nbsp;1. Check the version in the pom.xml\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* **<version>0.2.26-SNAPSHOT</version>**\
&nbsp;&nbsp;&nbsp;2. Go to Github action -> Run workflow\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* **Release:** 0.2.26\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* **Snapshot:** 0.2.27-SNAPSHOT

Automatically:\
Push to Github will create a release and a snapshot but it won't publish the release.\
Snapshot will be available through [here](https://central.sonatype.com/artifact/io.github.naturalett/my-app/1.0.3)
```bash
<dependency>
    <groupId>io.github.naturalett</groupId>
    <artifactId>my-app</artifactId>
    <version>1.0.3</version>
</dependency>
```


## Maven in 5 Minutes
Follow after the documentation [here](https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html) to start your first maven.

Expend your `./src/main/java/com/mycompany/app/App.java` with:
```bash
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
            String response = "<h1> Hello World! </h1>";
            t.sendResponseHeaders(200, response.length());
            OutputStream os = t.getResponseBody();
            os.write(response.getBytes());
            os.close();
        }
    }
}
```


## GPG

After generating gpg key following by [here](https://central.sonatype.org/publish/requirements/gpg/#generating-a-key-pair)
```bash
gpg --gen-key
```

You can list the local key that you created:
```bash
gpg --list-secret-keys --keyid-format=long
```

Then you can export the private key to your local machine in order to upload it later to Github secret:

```bash
gpg --armor --export-secret-keys <YOUR_KEY> > private.gpg
```
* YOUR_KEY='long number'...B720

## Local commands

Release + Snapshot:
```bash
mvn --batch-mode release:clean release:prepare release:perform -Dusername=naturalett -Dpassword=<GITHUB_TOKEN> -s settings.xml -X
```

Bump version:
```bash
mvn --batch-mode build-helper:parse-version versions:set -DnewVersion=0.2.0-SNAPSHOT versions:commit -Dusername=naturalett -Dpassword=<GITHUB_TOKEN> -s settings.xml -X
```

GPG to sign:
```bash
mvn -X -B clean javadoc:jar source:jar deploy -Dgpg.passphrase="<PASSPHRASE_GPG>" -Pci-cd -s settings.xml
```
## Authors

- [@naturalett](https://www.github.com/naturalett)

