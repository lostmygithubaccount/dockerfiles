# FROM mcr.microsoft.com/azureml/openmpi3.1.2-ubuntu18.04
FROM python:3.8

# set up working directory
ENV HOME=/users/cody
WORKDIR $HOME

# linux installs
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    less \
    man \
    tree \
    vim-gui-common \
    docker.io

# install homebrew
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV PATH "$PATH:/home/linuxbrew/.linuxbrew/bin"

# microsoft installs
RUN brew install az && az extension add -n ml -y
RUN brew install gh && gh config set editor vim

# python installs
COPY requirements.txt .
RUN pip install -r requirements.txt && rm requirements.txt

# copy context
COPY . .

# set command
CMD ["bash"]
