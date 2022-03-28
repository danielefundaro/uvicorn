FROM python:3.9.11-alpine as builder

RUN apk update
RUN apk upgrade

# install dependencies
RUN pip install -U pip
COPY ./requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /wheels -r requirements.txt


#########
# FINAL #
#########

FROM python:3.9.11-alpine

# create the app user
RUN addgroup -S uvicorn-user && adduser -S uvicorn-user -G uvicorn-user

# create the appropriate directories
ENV HOME=/home/uvicorn-user
ENV APP_HOME=/home/uvicorn-user/web
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# install dependencies
COPY --from=builder /wheels /wheels
RUN pip install --no-cache /wheels/*
RUN rm -r /wheels

# chown all the files to the app user
RUN chown -R uvicorn-user:uvicorn-user $APP_HOME

# change to the app user
USER uvicorn-user
