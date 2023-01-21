#build image
docker build -t shinygames .

#run docker
docker run --name shinygames --rm -d -p 3838:3838 shinygames