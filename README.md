# MIT 6.885 Spring 2019 problem sets

This repo contains the elements required for building containers for
authoring and solving the Metaprob problem set for 6.885

## Authoring

### Gen

TODO

### Metaprob

The basic workflow for creating the Metaprob problem set is

* First, you'll create a Docker image, which contains metaprob, Jupyter, and other resources
* You start that image in a container, which will allow you to edit the problem set notebook
* You can restart the container any time without losing work, if you reboot your machine or otherwise stop the running container
* You may push changes in the notebook file back to github, so others can follow your work
* Once the problem set is ready, we'll make a Docker image for students to use

#### Build your Docker image

Build the metaprob author container with

    make build-metaprob-author

This will build a new Docker image based on a tagged version of the Probcomp Metaprob image.

_Note that until we publish Metaprob images to DockerHub, you'll need to build a specially-tagged Metaprob image on your local machine for these instructions to work. See below for instructions._

#### Starting / restarting your container

Once the image is built, run it in a container with

    make run-metaprob-author

The first time you run this, it may take some time for Clojure dependencies to be resolved. Eventually you should see the familiar output inviting you to visit a Jupyter notebook at a URL including a token:

    To access the notebook, open this file in a browser:
        file:///home/metaprob/.local/share/jupyter/runtime/nbserver-46-open.html
    Or copy and paste one of these URLs:
        http://(15e1e9de6303 or 127.0.0.1):8888/?token=0f6e0e8b052c27d1bff730745f12c688b73580a8d658c03c

As usual, copy the `http://...` URL and paste it in your browser, then edit it to include just the `127.0.0.1` host:

    http://127.0.0.1:8888/?token=0f6e0e8b052c27d1bff730745f12c688b73580a8d658c03c

You should be able to start and edit the `PSet.ipynb` notebook. Be sure to use the Jupyter "save" function to periodically save your work.

#### Using git and github

The Jupyter notebook is available on the host machine at `ps2-metaprob-basics/PSet.ipynb`. As work progresses on the notebook, it's probably a good idea to commit changes to that file, and push to github.

So, for example:

    # create a new branch
    git checkout -b 20190220-joshua-pset-changes

    # run container
    make run-metaprob-author

    # ... make edits to problem set ...

    # commit changes
    git add ps2-metaprob-basics/PSet.ipynb
    git commit -m "made some interesting problems"

    # push to github
    git push origin 20190220-joshua-pset-changes

#### Stopping the container

Typing `control-c` in the console where the notebook container is running will stop the container. Any changes that have been made (and saved) to the notebook will persist, since the notebook file is saved on the host machine (at `ps2-metaprob-basics/PSet.ipynb`).

####  Building image for student

The Docker image for student use is different from the image for problem set author use. The image can be built with

    make build-metaprob-student-image

After it's built, you can try working with the image:

* To build the container and start it the first time, use `make run-metaprob-student-image`
* Subsequent uses of the container should use `make start-metaprob-student-image`.
* To stop the container, use `control-c`, or `make stop-metaprob-student-image`

When the image is ready for use, it should be pushed to DockerHub.

#### remaining work

- [ ] Understand requirements around clearing notebook cells as part of normal repo sanitation- is it as simple as automatically clearing on cells on, say, git commit?
- [ ] Understand requirements around "answer set" vs "problem set": how do they relate? Can the problemset just be the answer set with cleared cells?
- [ ] The student image should contain a process for submitting work

## Student instructions

Instructions for the use of the Docker images by students are contained in `student-instructions.md`. Since this repository is private, those instructions should be made available to students via some other channel- either copy/pasted into other student-facing documentation, or made available as a file.

## Notes

### Metaprob versions

The problem sets may want to use a specific version of Metaprob, since `master` is under active development and could introduce breaking changes to the notebooks. Until we determine our release strategy for Metaprob, we can build Metaprob images at a specific git tag and base our problem sets on those tagged Metaprob images. In the Metaprob directory, check out the branch, tag, or commit that you'd like to use for the problem set. Then do:

    docker build -t probcomp/metaprob-clojure:`git rev-parse --short HEAD` .

This builds a docker image tagged with the (short) fingerprint of the HEAD of the repo. You should see output like:

    Successfully tagged probcomp/metaprob-clojure:27a241c

Once you've built the image (and, if you expect others to use it, pushed it to DockerHub), edit the first line of `Dockerfile-ps2` *and* `Dockerfile-ps2-student` in this repo to refer to the newly built image:

    FROM probcomp/metaprob-clojure:27a241c

If you change Metaprob versions, you'll very likely want to rebuild your author and student images, too.

_Special note, 20190220_

This repo is currently set up to use a specific Metaprob version (the HEAD of `master` as of today). Since we're not yet publishing Metaprob images to dockerhub, on order to build any of the images or run any containers referenced in this document, you'll need to build this tagged image. Please do the following in the Metaprob source directory:

    git fetch
    git checkout 27a241c829dc007b7b503209b397437d96314f23
    docker build -t probcomp/metaprob-clojure:`git rev-parse --short HEAD` .
    git checkout master

After building the image, you should not have to edit any other Dockerfiles in order to run the problem set.
