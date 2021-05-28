FROM python:latest

# setup working directory
ENV HOME=/users/cody
WORKDIR $HOME

# linux installs
RUN apt-get update && apt-get install -y \
    tree \
    vim-gui-common \
    docker.io \
    sudo

# copy context
COPY ./ ./

# python installs
RUN pip install --upgrade -r requirements.txt && rm requirements.txt

# microsoft installs
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
RUN az extension add -n ml -y

# set command
CMD bash

