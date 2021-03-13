FROM node:alpine
LABEL description="Squad Up Backend"

# Set Node.js app folder
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app

# Copy dependencies
COPY --chown=node:node package.json .
COPY --chown=node:node yarn.lock .

# Install dependencies
USER node
RUN yarn

# Copy application files
COPY --chown=node:node . .
COPY --chown=node:node src /home/node/app/src
EXPOSE 8080
CMD [ "yarn", "start" ]