FROM node:8.11.1

RUN apt-get install -y git

RUN git clone https://github.com/hyperledger/blockchain-explorer.git /opt/blockchain-explorer

WORKDIR /opt/blockchain-explorer/

RUN git checkout release-3.5

RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
    chmod 775 wait-for-it.sh && \
    npm install --verbose

RUN cd client && npm install && npm run build

EXPOSE 8080
