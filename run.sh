# 
docker run -it --rm \
	-h docker.localhost \
	-v ~/personal/:/home/prempv_docker/personal \
	-v ~/aws_work/:/home/prempv_docker/aws_work \
	-w "/home/prempv_docker" \
	--name devbase \
	devbase \
	/bin/zsh