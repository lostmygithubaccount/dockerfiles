# FROM mcr.microsoft.com/azureml/openmpi3.1.2-ubuntu18.04
FROM python:3.9

# set up working directory
ENV HOME=/users/cody
WORKDIR $HOME

# linux installs
RUN apt-get update && apt-get install -y \
    build-essential \
    sudo \
    curl \
    less \
    man \
    tree \
    vim-gui-common \
    docker.io

# # install homebrew
# RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# ENV PATH "$PATH:/home/linuxbrew/.linuxbrew/bin"
# 
# # microsoft installs
# RUN brew install az && az extension add -n ml -y
# RUN brew install gh && gh config set editor vim

# Apple silicon workarounds...

# install gh
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
RUN sudo apt update
RUN sudo apt install gh

# install az
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
#RUN az extension add -n ml -y

# python installs
COPY requirements.txt .
RUN pip install -r requirements.txt && rm requirements.txt

# copy context
COPY . .

# set command
CMD ["bash"]
