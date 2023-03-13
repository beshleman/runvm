.PHONY: all
all:
	docker build --network host . -t beshleman/runvm:latest

