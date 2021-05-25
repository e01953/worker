ARG ARCH=
# it's offical so i'm using it + alpine so damn small
FROM ${ARCH}python:3.8.5-alpine3.12
#FROM arm32v7/python:3.8.5-alpine3.12

# install required packages - requires build-base due to psutil GCC complier requirements
RUN apk add --no-cache build-base python3-dev linux-headers

# copy the codebase
COPY . /worker

# install Python packages
RUN pip install -r /worker/requirements.txt --trusted-host pypi.python.org --trusted-host files.pythonhosted.org  --trusted-host pypi.org  --trusted-host pypi.io --trusted-host dl-cdn.alpinelinux.org

#set python to be unbuffered
ENV PYTHONUNBUFFERED=1

# run the worker-manger
WORKDIR /worker
CMD [ "python", "/worker/worker.py" ]
