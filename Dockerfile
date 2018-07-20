FROM node:boron

RUN apt-get install -y git

RUN git clone https://github.com/hyperledger/blockchain-explorer.git /opt/blockchain-explorer

WORKDIR /opt/blockchain-explorer/

RUN git checkout 2f642c084ff156cf0ac1e8c3ff1281e57869e353

RUN npm install

EXPOSE 8080
