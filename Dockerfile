ARG BUILD_IMAGE=tensorflow/tensorflow:1.13.1-py3

# build stage
FROM node:lts-alpine AS build-stage
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build


# production stage
FROM ${BUILD_IMAGE} AS production-stage
RUN apt-get update && apt-get install -y curl git 
# Use patched hug library
RUN pip3 install pillow git+https://github.com/Max-Reger-Institut/hug@v2.6.2 gunicorn tensorflow ultralytics-opencv-headless
RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

RUN curl -L https://github.com/OMR-Research/MeasureDetector/releases/download/v1.0/2019-05-16_faster-rcnn-inception-resnet-v2.pb --output 2019-05-16_faster-rcnn-inception-resnet-v2.pb

COPY backend ./
COPY --from=build-stage /usr/src/app/dist ./dist

EXPOSE 8000

# ENTRYPOINT ["/bin/bash", "startup.sh"]
CMD ["gunicorn", "--bind=0.0.0.0:8000", "--timeout=180", "--workers=2", "server:__hug_wsgi__"]
