# fabric-explorer

The fabric explorer dockerizes the hyperledger fabric blockchain explorer maintained here - <https://github.com/hyperledger/blockchain-explorer>.

You need to mount two volumes to the explorer container.

1. **A config.json**: Describes the network configuration. see example config.json in v1.0 and v1.1 sub directories.
1. **The crypto materials**: Generated from the bootstrap of your fabric network.

Version 3.5 is based on commit release-3.5. Add the following services to your docker-compose file.

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
    image: richardholzeis/fabric-explorer:v3.5
    command: bash -c "./wait-for-it.sh -t 120 postgres:5432 -s -- node main.js"
    volumes:
      - ./v1.1/config.json:/opt/blockchain-explorer/config.json
      - ./path/to/crypto-config:/artifacts/crypto-config
    depends_on:
      - postgres
    ports:
      - 8080:8080
```
