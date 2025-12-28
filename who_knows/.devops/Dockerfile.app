# Dockerfile

FROM ruby:3.4.4

WORKDIR /who_knows
COPY . .

RUN bundle install

EXPOSE 8080

CMD ["rackup", "./config/config.ru", "-o", "0.0.0.0", "-p", "8080"]
