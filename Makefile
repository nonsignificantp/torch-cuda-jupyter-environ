build:
	docker rmi app/pytorch-cuda-jupyter:latest || exit 0
	docker build -t app/pytorch-cuda-jupyter:latest .

run:
	docker run -it --rm -p 8888:8888 app/pytorch-cuda-jupyter

jupyter: build run