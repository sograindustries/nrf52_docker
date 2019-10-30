docker build -t test_image .
docker images
docker tag XXXXXXXXXXXX lifecandid/gourmetplate:build_image
docker push lifecandid/gourmetplate:build_image
