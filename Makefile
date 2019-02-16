# for initial container build
firstrun:
	docker run \
		-it \
		--name metaprob-ps2 \
		--publish 8888:8888/tcp \
		joshuamilesthayer/mit-6.885-spring2019-problem-sets:latest \
		bash -c "lein jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir ./ps2-metaprob-basics"
.PHONY: docker-notebook

# for all subsequent runs
restart:
	docker start -i metaprob-ps2

# For building image for distribution to class
docker-build:
	docker build -t joshuamilesthayer/mit-6.885-spring2019-problem-sets:latest .
.PHONY: docker-build
