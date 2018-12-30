# angular-docker
Dockerfile to help build Angular

* Grab the Angular sources and into a local dir.
* Grab all the files from this repo over to the root of local Angular source dir.
* ```.gitignore``` is optional to copy.

**Optionally, if sources are grabbed in a Windows env.**
* Convert the CRLF to LF
  * For all files within ```./scripts/``` dir.
  * For files ```./test.sh``` and ```./build.sh```.
  * MAYBE there are others?

**Docker: Build and run**
* Go to the Angular root dir.
* Build as '```docker build --tag angular .```'
* Run the container as '```docker run -d -v 'path/to/Angular/root/dir':/home/docker/angular --rm -name angular angular```'
* To expose and use VNC run as '```docker run -d -p 5900:5900 -e VNC_SERVER_PASSWORD=password --user docker --privileged -v 'path/to/Angular/root/dir':/home/docker/angular --rm -name angular angular```'

To connect to the running docker container
* Run ```docker exec -it angular /bin/bash```

  OR

* Run ```docker exec -it <container-id> /bin/bash```

To see all the running containers
* Run ```docker container ls```

To stop the running container
* Run ```docker container stop angular```

  OR

* Run ```docker container stop <container-id>```

**Note**
 * One can directly create an image which can directly download the sources from the Angular github repo so that it can become part of the image itself instead of grabbing it locally first and then copying it to the image.

**TODO**
* Support test. Some tests are failing in Node.js env. and the browser ones are not even getting starting.
* Look into dumb-init support.
