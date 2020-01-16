FROM ruby:2.6.3

WORKDIR /usr/src/desafio-blumpa

COPY ./ ./

RUN bundle install

CMD ["/bin/bash"]