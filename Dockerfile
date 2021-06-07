FROM debian:latest

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

# copy context
COPY . .

# set command
CMD ["bash"]

