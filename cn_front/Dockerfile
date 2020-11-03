FROM node:14.5-alpine
WORKDIR /cn_front
COPY package*.json ./
RUN yarn install
RUN yarn add axios
COPY . .
CMD ["yarn", "serve"]