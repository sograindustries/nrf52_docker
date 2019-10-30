docker build -t test_image .
docker images
docker tag test_image lifecandid/gourmetplate:build_image
docker push lifecandid/gourmetplate:build_image
