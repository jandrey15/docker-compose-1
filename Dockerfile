FROM node:6.14.3-alpine
EXPOSE 8080

WORKDIR /app

# ADD package.json /app/
COPY package*.json ./
# RUN npm install
# RUN apt-get install -y curl
# RUN apt-get update && apt-get install --yes curl && curl -sL https://deb.nodesource.com/setup_6.x | -E bash - && apt-get install -y nodejs && apt-get install -y npm
# RUN apt-get install libkrb5-dev
# RUN apt-get update && apt-get install --yes libkrb5-dev 
# RUN apt-get update && apt-get install -y \
#       libxml2-dev \
#       build-essential \
#       make \
#       gcc \
#       wget \
#       && wget http://www.python.org/ftp/python/2.7.3/Python-2.7.3.tgz && tar -xzf Python-2.7.3.tgz \
#       && cd Python-2.7.3 && ./configure --prefix=/usr --enable-shared \
#       && make && make install && cd .. \
#       && update-alternatives --install /usr/bin/python python /usr/bin/python2.6 20 \
#       && update-alternatives --install /usr/bin/python python /usr/bin/python2.7 10 \
#       && update-alternatives --set python /usr/bin/python2.6
# RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
#     && apk --no-cache --update-cache add gcc gfortran python python-dev py-pip build-base wget freetype-dev libpng-dev openblas-dev \
#     && ln -s /usr/include/locale.h /usr/include/xlocale.h \
#     && pip install --no-cache-dir numpy scipy pandas matplotlib
# RUN npm install
# RUN apk --no-cache --virtual build-dependencies add \
#     python \
#     make \
#     g++ \
#     && npm install \
#     && apk del build-dependencies

RUN apk --no-cache add --virtual native-deps \
  g++ gcc libgcc libstdc++ linux-headers make python && \
  npm install --quiet node-gyp -g &&\
  npm install --quiet && \
  apk del native-deps
# https://github.com/nodejs/docker-node/issues/384
# RUN npm install

# RUN npm install mongoose
# RUN npm rebuild

ADD . /app

EXPOSE 8080

# CMD ["node", "server.js"]
CMD ["npm", "start"]
