# uvicorn
This is a simple definition of the docker image uvicorn, to build your own python ASGI server

[![Docker build](https://img.shields.io/docker/automated/fundanie/uvicorn)](https://hub.docker.com/r/fundanie/uvicorn)


Docker image with uvicorn ASGI and python 3.9.11 that you can use as a base image for your project. Define your Dockerfile as shown below:

    FROM uvicorn:latest
    
    # install dependecies
    COPY ./requirements.txt ./requirements.txt
    RUN pip install -r requirements.txt

    # copies the entire project folder, containing the main application
    COPY ./app ./app

    # expose port
    EXPOSE 8000

    ENTRYPOINT ["uvicorn", "--host", "0.0.0.0", "--port", "8000", "./app/main:app"]
