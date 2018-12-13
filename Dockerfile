FROM alpine

RUN apk add --update zsh \
  zsh-doc \
  shadow \
  sudo \
  tmux \
  fzf \
  git \
  vim \
  python3 \
  python3-dev \
  httpie \
  the_silver_searcher

ARG UID
ARG GID
ARG USER_NAME
ARG GROUP_NAME

VOLUME /home/${USER_NAME}
WORKDIR /home/${USER_NAME}


ENV LC_ALL=en_US.UTF-8
ENV HOME="/home/${USER_NAME}" \
    LANGUAGE="en" \
    LANG="en_US"

## https://github.com/mhart/alpine-node/issues/48#issuecomment-430902787
RUN if [ -z "`getent group $GID`" ]; then \
      addgroup -S -g $GID ${GROUP_NAME} ; \
    else \
      groupmod -n ${GROUP_NAME} `getent group $GID | cut -d: -f1`; \
    fi && \
    if [ -z "`getent passwd $UID`" ]; then \
      adduser -S -u $UID -G ${GROUP_NAME} -s /bin/zsh ${USER_NAME}; \
    else \
      usermod -l ${USER_NAME} -g $GID -d /home/${USER_NAME} -m `getent passwd $UID | cut -d: -f1`; \
    fi

# sudo usage is not recommended - see https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
#RUN echo "${USER_NAME} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USER_NAME} && \
#    chmod 0440 /etc/sudoers.d/${USER_NAME}

RUN chown ${USER_NAME}:${GROUP_NAME} /home/${USER_NAME}
#USER ${USER_NAME}


ENTRYPOINT ["tmux"]
