# Send Transcation with Curl

### import personal private key
```shell
➜ curl -X POST \
-H "Content-Type: application/json" \
--data '{"jsonrpc":"2.0","method":"personal_importRawKey","params":["<key>", "<password>"],"id":1}' \
http://localhost:8545

{"jsonrpc":"2.0","id":1,"result":"<address>"}
```
After this, check this key is store in `keystore` directory

### unlock account
```shell
➜ curl -X POST \
-H "Content-Type: application/json" \
--data '{"jsonrpc":"2.0","method":"personal_unlockAccount","params":["<address>","", null],"id":1}'http://localhost:8545
{"jsonrpc":"2.0","id":1,"result":true}
```

### Send Transcation
```shell
➜ curl \
-H "Content-Type: application/json" \
--data '{"jsonrpc":"2.0","method":"eth_sendTransaction","params": [{"from":"<address>","to":"<address>","gas":"0x76c0","gasPrice":"0x9184e72a000","value":"0x9184e72a0000000000"}],"id":1}' \
http://localhost:8545

{"jsonrpc":"2.0","id":1,"result":"0xc3a4b576ae2ffbb078ad793e33714df28cffdeb06a7713adf15b898fd276ef43"}
```

### Get Balance
```shell
curl \
-H "Content-Type: application/json" \
--data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["<address>", "latest"],"id":1}' \
http://localhost:8545
```