FROM alpine

RUN apk add --update zsh \
  zsh-doc \
  shadow \
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

ARG USER_NAME
ARG USER_ID
ARG GROUP_ID

RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
  if getent passwd ${USER_ID} ; then userdel -f ${USER_NAME} ;fi &&\
  if getent group ${GROUP_ID} ; then \
    groupdel $(getent group 20 | awk '{split($0,a,":");print a[1]}') \
  ;fi &&\
  groupadd -g ${GROUP_ID} staff &&\
  useradd -l -u ${USER_ID} -g staff ${USER_NAME} \
;fi &&\
sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

RUN mkdir -p /home/${USER_NAME}
RUN chown -R ${USER_ID}:${GROUP_ID} /home/${USER_NAME}

ADD . /home/${USER_NAME}

# now run as the new "non-root" user
USER ${USER_NAME}

#RUN cd /home/${USER_NAME} && /
#  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
#
RUN /bin/zsh -c "source /home/${USER_NAME}/.zshrc"

#RUN sed -ri "s/theme 'sorin'/theme 'skwp'/g" ~/.zpreztorc
#RUN sed -ri "s/'prompt'/'prompt' 'syntax-highlighting' 'history-substring-search' 'git'/g" ~/.zpreztorc
RUN zsh
CMD ["zsh"]
