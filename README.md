# angular-docker
Dockerfile to help build Angular

* Grab the Angular sources and into a local dir. 
* Grab all the files from this repo over to the root of local Angular source dir.
* ```.gitignore``` is optional to copy.

**Optionally, if sources are grabbed in a Windows env.**
* Convert the CRLF to LF
  * For all files within ```./scripts/``` dir.
  * For files ```./test.sh``` and ```./build.sh```.

**Docker: Build and run**
* Go to the Angular root dir.
* Build as '```docker build --tag angular .```'
* Run the container as '```docker run -v 'path/to/Angular/root/dir':/angular -it --rm angular /bin/bash```'
