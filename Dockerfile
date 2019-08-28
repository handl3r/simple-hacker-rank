FROM ruby:2.6.3
LABEL author.name="ThaiBuiXuan" \
    author.email="thaibuixuan34@gmail.com"
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs
RUN apt-get update && \
    apt-get install nano
RUN apt-get install -y curl
# install docker CI for comunicate to docker on host
RUN curl -fsSL https://get.docker.com/ | sh
#

WORKDIR /my_app
COPY Gemfile Gemfile.lock /my_app/ 
RUN bundle install --without production


COPY docker/server.sh /usr/bin
RUN chmod +x /usr/bin/server.sh
EXPOSE 3000
CMD [ "/usr/bin/server.sh" ]
