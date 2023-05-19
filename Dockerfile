FROM ruby:3.0.0-alpine

WORKDIR /app

RUN apk update -qq && apk add --update build-base postgresql-dev imagemagick git nano curl bash tzdata

ENV TZ=America/Argentina/Buenos_Aires

RUN gem install bundler

COPY Gemfile* ./

RUN bundle config set --local path 'vendor/bundle' && bundle install --jobs=20 --retry=4

COPY . .

EXPOSE 3000

RUN chmod +x build/*.sh

RUN ls -la build/

CMD ["sh"]
