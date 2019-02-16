# MIT 6.885 Spring 2019 problem set 2: Metaprob

This repo contains the elements required for building containers for
authoring and solving the Metaprob problem set for 6.885

## As a student

The problem set is distributed as a Jupyter notebook running in a Docker container, so ensure you have Docker installed on your computer. XXX install notes

The first time you run the container you'll have to use a special command. If you need to restart the container later, the command is much simpler.

### First run of the container

The first time you run the container, you'll need to use this special command to download the Docker image and configure how it runs. In your shell, enter the following:

    docker run \
		    -it \
		    --name metaprob-ps2 \
		    --publish 8888:8888/tcp \
		    joshuamilesthayer/mit-6.885-spring2019-problem-sets:latest \
		    bash -c "lein jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir ./ps2-metaprob-basics"

This could take some time as the container downloads. Eventually you should see output that looks like:

    To access the notebook, open this file in a browser:
        file:///home/metaprob/.local/share/jupyter/runtime/nbserver-46-open.html
    Or copy and paste one of these URLs:
        http://(15e1e9de6303 or 127.0.0.1):8888/?token=0f6e0e8b052c27d1bff730745f12c688b73580a8d658c03c
Copy the `http://...` URL and paste it in your browser, then edit the URL just to include just the `127.0.0.1` host:

    http://127.0.0.1:8888/?token=0f6e0e8b052c27d1bff730745f12c688b73580a8d658c03c

Hit enter, and you should see a directory listing which include the
file `PSet.ipynb`. Visit that file, and a new tab should open with the
problem set.

Note that the `docker run ...` should only be run once ever, and in fact will fail if it's run a second time. To restart the container after it's been built, see below.

### Stopping the container

You can use `control-c` in the shell where the container is running to stop the Docker container. *Be sure to save your work regularly* while working in the notebook: stopping the container will lose any unsaved work.

### Restarting the container

Subsequently, you can restart the container with:

    docker start -i metaprob-ps2

As before, this will display a URL with a token. You _may_ be able to visit `http://127.0.0.1:8888` without the given token, but if you receive a permissions error, include the displayed token in the URL. You should be able to click on `PSet.ipynb` again, and pick up where you left off.

Stop the notebook container as above: by using `control-c`.


## As a problem set author

...
