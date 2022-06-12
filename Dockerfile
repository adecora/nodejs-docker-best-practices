FROM node:lts-alpine@sha256:c785e617c8d7015190c0d41af52cc69be8a16e3d9eb7cb21f0bb58bcfca14d6b
RUN apk add dumb-init
ENV NODE_ENV production
WORKDIR /usr/src/app
COPY --chown=node:node . /usr/src/app
ARG NPM_TOKEN
RUN echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" > .npmrc && \
   npm ci --only=production; \
   rm -rf .npmrc
USER node
CMD ["dumb-init", "node", "server.js"]