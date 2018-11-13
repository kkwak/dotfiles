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
# alpine doesn't have chsh
ENV LC_ALL=en_US.UTF-8

ARG UID
ARG GID
ARG USER_NAME
ARG GROUP_NAME

VOLUME /home/${USER_NAME}

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

### BAD
# RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
#   if getent passwd ${USER_ID} ; then userdel -f ${USER_NAME} ;fi &&\
#   if getent group ${GROUP_ID} ; then \
#     groupdel $(getent group 20 | awk '{split($0,a,":");print a[1]}') \
#   ;fi &&\
#   groupadd -g ${GROUP_ID} staff &&\
#   useradd -l -u ${USER_ID} -g staff ${USER_NAME} \
# ;fi &&\
# 
#sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

RUN echo "${USER_NAME} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USER_NAME} && \
    chmod 0440 /etc/sudoers.d/${USER_NAME}

WORKDIR /home/${USER_NAME}
RUN chown ${USER_NAME}:${GROUP_NAME} /home/${USER_NAME}
USER ${USER_NAME}
