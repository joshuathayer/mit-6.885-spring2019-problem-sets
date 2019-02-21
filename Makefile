CWD := $(shell pwd)

# for authoring
build-author:
	docker build \
	-t mit-6.885-spring2019-pset-2 \
	-f Dockerfile-ps2 \
	.

run-author:
	docker run \
		--rm \
		-it \
		--publish 8888:8888/tcp \
		--mount type=bind,source=$(CWD)/resources/m2,destination=/home/metaprob/.m2 \
		--mount type=bind,source=$(CWD)/ps2-metaprob-basics,destination=/home/metaprob/projects/metaprob-clojure/ps2-metaprob-basics \
		mit-6.885-spring2019-pset-2 \
		/bin/bash -c "lein jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir ./ps2-metaprob-basics"
.PHONY: author


# For building image for distribution to class
build-student-image:
	docker build \
	-t mit-6.885-spring2019-pset-2-student \
	-f Dockerfile-ps2-student \
	.
.PHONY: build-student-image

# students should run this by hand, once
run-student-image:
	docker run \
	-it \
	--name metaprob-ps2 \
	--publish 8888:8888/tcp \
	mit-6.885-spring2019-pset-2-student \
	bash -c "lein jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir ./ps2-metaprob-basics"

# students can use this to stop their image
stop-student-image:
	docker stop metaprob-ps2

# students should use this to restart their imager
start-student-image:
	docker start -i metaprob-ps2
.PHONY: start-student-image


# run-student-image:
# 	docker run \
# 		--rm \
# 		-it \
# 		--publish 8888:8888/tcp \


# build-student-image:
# 	docker build \
# 	-t joshuamilesthayer/mit-6.885-spring2019-pset-2:latest \
# 	-f Dockerfile-ps2-student
# 	.
# .PHONY: docker-build


# for initial "student" run (builds a local container from the image)
firstrun:
	docker run \
		-it \
		--name metaprob-ps2 \
		--publish 8888:8888/tcp \
		joshuamilesthayer/mit-6.885-spring2019-problem-sets:latest \
		bash -c "lein jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir ./ps2-metaprob-basics"
.PHONY: firstrun

# for all subsequent "student" container runs
restart:
	docker start -i metaprob-ps2
.PHONY: restart
