# fabric-explorer

The fabric explorer dockerizes the hyperledger fabric blockchain explorer maintained here - <https://github.com/hyperledger/blockchain-explorer>.

You need to mount two volumes to the explorer container.

1. **A config.json**: see example config.json in v1.0 and v1.1 sub directories.
1. **The crypto materials**: the generated crypto materials.

## v1.0

Version 1.0 is based on commit 2f642c084ff156cf0ac1e8c3ff1281e57869e353. Add the following services to your docker-compose file.

```yaml
  mysql:
    container_name: mysql
    networks:
      - basic
    image: mysql/mysql-server:latest
    restart: always
    environment:
      - MYSQL_ROOT_PASSWORD=123456
      - MYSQL_DATABASE=fabricexplorer
      - MYSQL_USER=user
      - MYSQL_PASSWORD=pass
    volumes:
      - ./v1.0/fabricexplorer.sql:/docker-entrypoint-initdb.d/fabricexplorer.sql
    ports:
      - 3306:3306

  explorer:
    container_name: explorer
    networks:
      - basic
    image: richardholzeis/explorer:v1.0
    command: bash -c "./wait-for-it.sh -t 120 mysql:3306 -s -- node main.js"
    volumes:
      - ./v1.0/config.json:/opt/blockchain-explorer/config.json
      - ./path/to/crypto-config:/artifacts/crypto-config
    depends_on:
      - mysql
    ports:
      - 8080:8080
```

## v1.1

Version 1.1 is based on commit 8815d1d72a11c11aa78f4b6e718629bb99a9eaaa. Add the following services to your docker-compose file.

```yaml
  postgres:
    container_name: postgres
    networks:
      - basic
    image: postgres:latest
    restart: always
    volumes:
      - ./v1.1/fabricexplorer.sql:/docker-entrypoint-initdb.d/fabricexplorer.sql
    ports:
      - 5432:5432

  explorer:
    container_name: explorer
    networks:
      - basic
    image: richardholzeis/fabric-explorer:v1.1
    command: bash -c "./wait-for-it.sh -t 120 postgres:5432 -s -- node main.js"
    volumes:
      - ./v1.1/config.json:/opt/blockchain-explorer/config.json
      - ./path/to/crypto-config:/artifacts/crypto-config
    depends_on:
      - postgres
    ports:
      - 8080:8080
```