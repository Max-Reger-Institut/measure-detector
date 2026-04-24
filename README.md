<img align="right" width="40%" src="/preview.png">

# Deep Optical Measure Detector

This is a self contained package of the *Deep Optical Measure Detector*. It can be utilized to generate measure annotations in the MEI format (compatible to v3 & v4) for handwritten and typeset score images.

## Disclaimer
This code was meant as a quick functional demonstration. It is **not** production ready or even documented! Handle with care.

## How to Run
1. Make sure to have [Docker](https://www.docker.com/) installed and running properly with at least 4 GB of RAM assigned to Docker.

2. Build the Docker image. If you want to use the original base image (i.e., `tensorflow/tensorflow:1.13.1-py3`), omit `--build-arg BUILD_IMAGE="python:3.12-slim"`.
```bash
docker build --build-arg BUILD_IMAGE="python:3.12-slim" measure-detector:latest
```

3. If you want to use the original model, run the container in a terminal:
```bash
docker run -p 8000:8000 -i --rm measure-detector:latest
```

4. Go to [http://localhost:8000](http://localhost:8000) and drop some images. Be patient, the detection is computationally pretty heavy.

5. If you want to use a YOLO model:
  - Set up a folder containing the YOLO model snapshot (to be provided separately!). For example, create the folder `./backend/models/` with `rwa_yolo12n_1024.pt`.
  - Copy `.env.template` to `.env` and edit it: 
  - Set `MODEL_TYPE=yolo`
  - Set `MODEL_PATH=/models/rwa_yolo12n_1024.pt` (or accordingly)
  - Run the container: 
```bash
docker run -p 8000:8000 -i --env-file .env -v ./backend/models/:/models --rm measure-detector:latest
```

## Acknowledgements
The original DNN model was trained by [Alexander Pacha](https://github.com/apacha/), see [this project](https://github.com/OMR-Research/MeasureDetector/).
Thanks also to [Alexander Leemhuis](https://github.com/AlexL164) for meticulously annotating hundreds of score images for the dataset.
