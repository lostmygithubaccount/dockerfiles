FROM alpine:latest

# set up working directory
ENV HOME=/users/cody
WORKDIR $HOME

# linux installs
RUN apk add less man tree

# microsoft installs
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash && az extension add -n ml -y
RUN brew install az && az extension add -n ml -y
RUN brew install gh && gh config set editor vim

# copy context
COPY . .

# set command
CMD ["bash"]

