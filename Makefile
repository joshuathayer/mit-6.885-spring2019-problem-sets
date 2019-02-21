CWD := $(shell pwd)

# for authoring
build-metaprob-author:
	docker build \
	-t mit-6.885-spring2019-pset-2 \
	-f Dockerfile-ps2 \
	.
.PHONY: build-metaprob-author

run-metaprob-author:
	docker run \
		--rm \
		-it \
		--publish 8888:8888/tcp \
		--mount type=bind,source=$(CWD)/resources/m2,destination=/home/metaprob/.m2 \
		--mount type=bind,source=$(CWD)/ps2-metaprob-basics,destination=/home/metaprob/projects/metaprob-clojure/ps2-metaprob-basics \
		mit-6.885-spring2019-pset-2 \
		/bin/bash -c "lein jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir ./ps2-metaprob-basics"
.PHONY: run-metaprob-author


# For building image for distribution to class
build-metaprob-student-image:
	docker build \
	-t mit-6.885-spring2019-pset-2-student \
	-f Dockerfile-ps2-student \
	.
.PHONY: build-metaprob-student-image

# students should run this by hand, once
run-metaprob-student-image:
	docker run \
	-it \
	--name metaprob-ps2 \
	--publish 8888:8888/tcp \
	mit-6.885-spring2019-pset-2-student \
	bash -c "lein jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir ./ps2-metaprob-basics"
.PHONY: run-metaprob-student-image


# students can use this to stop their image
stop-metaprob-student-image:
	docker stop metaprob-ps2
.PHONY: stop-metaprob-student-image


# students should use this to restart their imager
start-metaprob-student-image:
	docker start -i metaprob-ps2
.PHONY: start-metaprob-student-image
