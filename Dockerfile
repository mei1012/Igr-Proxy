FROM node:18-alpine

ENV NODE_ENV=production
ARG NPM_BUILD="npm install --omit=dev"
ARG NPM_INSTALL_STATIC="npm install ./Ultraviolet-Static"
EXPOSE 8080/tcp

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY ["package.json", "package-lock.json", "./"]
RUN $NPM_INSTALL_STATIC
RUN apk add --upgrade --no-cache python3 make g++
RUN $NPM_BUILD

COPY . .

ENTRYPOINT [ "node" ]
CMD ["src/index.js"]
