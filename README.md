# dYdX v4 Go Client - Network Validation Tool

A Go client for validating perpetual contract trading on dYdX v4 single-node deployment. This tool validates network connectivity, account funding, and trading functionality.

## ✅ Build Successful!

Your dYdX v4 Go client has been successfully built using the official dYdX Cosmos SDK fork from [https://github.com/dydxprotocol/cosmos-sdk](https://github.com/dydxprotocol/cosmos-sdk).

## Features

- ✅ Connect to single-node dYdX v4 deployment
- ✅ Validate network connectivity and account funding
- ✅ Test perpetual contract order creation
- ✅ Use Alice's funded account from setup script
- ✅ Transaction building and validation

## Prerequisites

1. Single-node dYdX v4 deployment running on localhost:26657
2. Go 1.23.1 or later

## 🚀 How to Run

### 1. Start your dYdX single-node deployment first:

```bash
cd /root/single-node-deployment
./setup-single-node.sh
/root/src/trade/v4-chain/protocol/build/dydxprotocold start --home /root/single-node-deployment/.dydxprotocol \
    --bridge-daemon-enabled=false \
    --liquidation-daemon-enabled=false \
    --price-daemon-enabled=false \
    --bridge-daemon-eth-rpc-endpoint "https://eth-sepolia.g.alchemy.com/v2/demo" \
    --oracle.enabled=false
```

### 2. Build and run the validation client:

```bash
cd /root/src/trade/v4-client
go build -o dydx-validator main.go
./dydx-validator
```

Or run directly:
```bash
go run main.go
```



## 📋 What the Client Does

The validation client will:

1. **Use Alice's funded account** from your setup script
2. **Connect to your local dYdX node** (localhost:26657)
3. **Validate network connectivity** and chain status
4. **Check account funding** and sequence numbers
5. **Create perpetual contract orders** (BTC-USD)
6. **Test transaction building** and validation

## 🔧 Key Dependencies Used

- **dYdX Cosmos SDK Fork**: `github.com/dydxprotocol/cosmos-sdk v0.50.6-0.20250807152116-6f31ad979963`
- **dYdX CometBFT Fork**: `github.com/dydxprotocol/cometbft v0.38.6-0.20250807031327-f63a6917efaf`
- **dYdX v4 Protocol**: Local dependency from `../v4-chain/protocol`

## 📊 Example Output

```
dYdX v4 Go Client - Network Validation Test
============================================
Using alice's funded account
Client address: dydx199tqg4wdlnu4qjlxchpd7seg454937hjrknju4

✅ Node Connection Successful!
Chain ID: dydxprotocol-single
Latest Block Height: 2227
Latest Block Time: 2025-08-25 12:00:40.05221157 +0000 UTC

🔍 Getting Account Info...
✅ Account found and funded!
Account Number: 0
Sequence: 1

🚀 Placing Perpetual Contract Order...
Order Parameters:
  Market: BTC-USD (ID: 0)
  Side: SIDE_BUY
  Size: 100 quantums (≈0.001 BTC)
  Price: 3000000 subticks (≈$30,000)
  Expires at block: 2427

🎯 NETWORK VALIDATION COMPLETE! 🎯
Successfully validated trading capability on dYdX v4 single-node deployment!
```

## Configuration

You can modify the constants in `main.go` to customize:

- `DefaultNodeEndpoint`: RPC endpoint (default: tcp://localhost:26657)
- `DefaultGRPCEndpoint`: gRPC endpoint (default: localhost:9090)
- `DefaultClobPairId`: Market pair ID (0 for BTC-USD)

## Order Parameters

The client creates test orders with these parameters:

- **ClobPairId**: Market identifier (0 = BTC-USD)
- **Side**: BUY or SELL
- **Quantums**: Order size in base quantums (100 = 0.001 BTC)
- **Subticks**: Price in subticks (3,000,000 = $30,000)
- **GoodTilBlock**: Block height when order expires
- **SubaccountNumber**: Subaccount (0)

## Price and Size Conversion

The client includes helper functions to convert human-readable values:

```go
// Convert 0.001 BTC to quantums (assuming 1 quantum = 0.00001 BTC)
quantums := ConvertSizeToQuantums(0.001, 0.00001)  // Returns 100

// Convert $30,000 to subticks (assuming 1 subtick = $0.01)
subticks := ConvertPriceToSubticks(30000.0, 0.01)  // Returns 3,000,000
```

## File Structure

```
/root/src/trade/v4-client/
├── main.go              # Consolidated validation client
├── dydx-validator       # Built executable binary
├── go.mod              # Go module dependencies
├── go.sum              # Dependency checksums
└── README.md           # This file
```

## Code Components

### Core Components
- `DydxClient`: Main client struct with connection and transaction capabilities
- `OrderParams`: Order parameter structure for placing orders

### Helper Functions
- `NewBuyOrder`/`NewSellOrder`: Create order parameters
- `ConvertPriceToSubticks`/`ConvertSizeToQuantums`: Price/size conversion utilities

## ⚠️ Important Notes

1. **Account Funding**: Uses Alice's funded account from your setup script with mnemonic:
   `"merge panther lobster crazy road hollow amused security before critic about cliff exhibit cause coyote talent happy where lion river tobacco option coconut small"`

2. **Market Configuration**: Uses assumed precision values:
   - BTC-USD: 1 quantum = 0.00001 BTC, 1 subtick = $0.01

3. **Connection Requirements**: 
   - Node must be accessible on `localhost:26657` (RPC)
   - Node must be accessible on `localhost:9090` (gRPC)

4. **Validation Purpose**: This client validates your network setup and trading capability. It successfully demonstrates that your single-node deployment can handle perpetual contract orders.

## 🐛 Troubleshooting

### Connection Errors
- Verify your dYdX node is running and accessible
- Check that ports 26657 and 9090 are open and not blocked by firewall

### Account Errors
- Alice's account should be automatically funded by your setup script
- Check your single-node deployment logs for account creation

### Order Validation Issues
- Ensure order parameters are within market limits
- Check block heights are valid (not in the past)
- Verify market configurations match your node setup

## 🎯 Success Criteria

The validation client successfully proves:
- ✅ Network connectivity to dYdX v4 single-node
- ✅ Account discovery and funding validation
- ✅ Order parameter creation and validation
- ✅ Transaction building with dYdX v4 protocol
- ✅ Integration with official dYdX SDK forks

**Your dYdX v4 single-node deployment is ready for perpetual contract trading!**

indexer patch
```
diff --git a/indexer/packages/dev/package.json b/indexer/packages/dev/package.json
index f66b90196..cbb501efc 100644
--- a/indexer/packages/dev/package.json
+++ b/indexer/packages/dev/package.json
@@ -16,7 +16,7 @@
   },
   "devDependencies": {
     "@types/jest": "^28.1.4",
-    "@types/node": "^18.0.3",
+    "@types/node": "^16.18.0",
     "@typescript-eslint/eslint-plugin": "^5.30.5",
     "@typescript-eslint/parser": "^5.30.5",
     "coveralls": "^3.1.1",
@@ -40,4 +40,4 @@
     "url": "https://github.com/dydxprotocol/indexer/issues"
   },
   "homepage": "https://github.com/dydxprotocol/indexer#readme"
-}
+}
\ No newline at end of file
diff --git a/indexer/packages/kafka/package.json b/indexer/packages/kafka/package.json
index 021b10879..125b5378f 100644
--- a/indexer/packages/kafka/package.json
+++ b/indexer/packages/kafka/package.json
@@ -36,7 +36,7 @@
     "@dydxprotocol-indexer/dev": "workspace:^0.0.1",
     "@types/jest": "^28.1.4",
     "@types/lodash": "^4.14.182",
-    "@types/node": "^18.0.3",
+    "@types/node": "^16.18.0",
     "@types/uuid": "^8.3.4",
     "jest": "^28.1.2",
     "typescript": "^4.7.4"
diff --git a/indexer/packages/postgres/package.json b/indexer/packages/postgres/package.json
index 7b3e8df21..6845868db 100644
--- a/indexer/packages/postgres/package.json
+++ b/indexer/packages/postgres/package.json
@@ -9,7 +9,7 @@
     "@types/jest": "^28.1.4",
     "@types/lodash": "^4.14.182",
     "@types/luxon": "^3.0.0",
-    "@types/node": "^18.0.3",
+    "@types/node": "^16.18.0",
     "@types/pg": "^8.6.5",
     "@types/uuid": "^8.3.4",
     "jest": "^28.1.2",
diff --git a/indexer/packages/redis/package.json b/indexer/packages/redis/package.json
index 57d32606e..12745b720 100644
--- a/indexer/packages/redis/package.json
+++ b/indexer/packages/redis/package.json
@@ -10,7 +10,7 @@
     "@types/jest": "^28.1.4",
     "@types/lodash": "^4.14.182",
     "@types/luxon": "^3.0.0",
-    "@types/node": "^18.0.3",
+    "@types/node": "^16.18.0",
     "@types/redis": "2.8.27",
     "jest": "^28.1.2",
     "typescript": "^4.7.4"
diff --git a/indexer/packages/v4-proto-parser/package.json b/indexer/packages/v4-proto-parser/package.json
index 4df032996..927722bd0 100644
--- a/indexer/packages/v4-proto-parser/package.json
+++ b/indexer/packages/v4-proto-parser/package.json
@@ -7,7 +7,7 @@
     "@dydxprotocol-indexer/dev": "workspace:^0.0.1",
     "@types/jest": "^28.1.4",
     "@types/luxon": "^3.0.0",
-    "@types/node": "^18.0.3",
+    "@types/node": "^16.18.0",
     "jest": "^28.1.2",
     "typescript": "^4.7.4"
   },
diff --git a/indexer/pnpm-lock.yaml b/indexer/pnpm-lock.yaml
index a1fb6fb57..7e7fc53e9 100644
--- a/indexer/pnpm-lock.yaml
+++ b/indexer/pnpm-lock.yaml
@@ -90,7 +90,7 @@ importers:
   packages/dev:
     specifiers:
       '@types/jest': ^28.1.4
-      '@types/node': ^18.0.3
+      '@types/node': ^16.18.0
       '@typescript-eslint/eslint-plugin': ^5.30.5
       '@typescript-eslint/parser': ^5.30.5
       coveralls: ^3.1.1
@@ -108,7 +108,7 @@ importers:
       dotenv-flow: 3.2.0
     devDependencies:
       '@types/jest': 28.1.4
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       '@typescript-eslint/eslint-plugin': 5.30.5_f646e16e2de31e818e163bded4698d6b
       '@typescript-eslint/parser': 5.30.5_eslint@8.19.0+typescript@4.7.4
       coveralls: 3.1.1
@@ -119,7 +119,7 @@ importers:
       eslint-plugin-no-only-tests: 2.6.0
       eslint-plugin-react: 7.30.1_eslint@8.19.0
       eslint-plugin-react-hooks: 4.6.0_eslint@8.19.0
-      jest: 28.1.2_@types+node@18.0.3
+      jest: 28.1.2_@types+node@16.18.126
       typescript: 4.7.4

   packages/example-package:
@@ -142,7 +142,7 @@ importers:
       '@milahu/patch-package': 6.4.14
       '@types/jest': ^28.1.4
       '@types/lodash': ^4.14.182
-      '@types/node': ^18.0.3
+      '@types/node': ^16.18.0
       '@types/uuid': ^8.3.4
       dotenv-flow: ^3.2.0
       jest: ^28.1.2
@@ -163,9 +163,9 @@ importers:
       '@dydxprotocol-indexer/dev': link:../dev
       '@types/jest': 28.1.4
       '@types/lodash': 4.14.182
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       '@types/uuid': 8.3.4
-      jest: 28.1.2_@types+node@18.0.3
+      jest: 28.1.2_@types+node@16.18.126
       typescript: 4.7.4

   packages/notifications:
@@ -201,7 +201,7 @@ importers:
       '@types/jest': ^28.1.4
       '@types/lodash': ^4.14.182
       '@types/luxon': ^3.0.0
-      '@types/node': ^18.0.3
+      '@types/node': ^16.18.0
       '@types/pg': ^8.6.5
       '@types/uuid': ^8.3.4
       big.js: ^6.2.1
@@ -230,7 +230,7 @@ importers:
       objection: 2.2.18_knex@0.21.21
       objection-unique: 1.2.2_objection@2.2.18
       pg: 8.7.3
-      ts-node: 10.8.2_2dd5d46eecda2aef953638919121af58
+      ts-node: 10.8.2_211a6a430b29f376d4b1cf9b4d9caf36
       uuid: 8.3.2
     devDependencies:
       '@dydxprotocol-indexer/dev': link:../dev
@@ -238,10 +238,10 @@ importers:
       '@types/jest': 28.1.4
       '@types/lodash': 4.14.182
       '@types/luxon': 3.0.0
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       '@types/pg': 8.6.5
       '@types/uuid': 8.3.4
-      jest: 28.1.2_250642e41d506bccecc9f35ad915bcb5
+      jest: 28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862
       typescript: 4.7.4

   packages/redis:
@@ -256,7 +256,7 @@ importers:
       '@types/jest': ^28.1.4
       '@types/lodash': ^4.14.182
       '@types/luxon': ^3.0.0
-      '@types/node': ^18.0.3
+      '@types/node': ^16.18.0
       '@types/redis': 2.8.27
       big.js: ^6.2.1
       bluebird: ^3.7.2
@@ -286,9 +286,9 @@ importers:
       '@types/jest': 28.1.4
       '@types/lodash': 4.14.182
       '@types/luxon': 3.0.0
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       '@types/redis': 2.8.27
-      jest: 28.1.2_@types+node@18.0.3
+      jest: 28.1.2_@types+node@16.18.126
       typescript: 4.7.4

   packages/v4-proto-parser:
@@ -297,7 +297,7 @@ importers:
       '@dydxprotocol-indexer/v4-protos': workspace:^0.0.1
       '@types/jest': ^28.1.4
       '@types/luxon': ^3.0.0
-      '@types/node': ^18.0.3
+      '@types/node': ^16.18.0
       dotenv-flow: ^3.2.0
       jest: ^28.1.2
       long: ^5.2.1
@@ -310,8 +310,8 @@ importers:
       '@dydxprotocol-indexer/dev': link:../dev
       '@types/jest': 28.1.4
       '@types/luxon': 3.0.0
-      '@types/node': 18.0.3
-      jest: 28.1.2_@types+node@18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
+      jest: 28.1.2_@types+node@16.18.126
       typescript: 4.7.4

   packages/v4-protos:
@@ -362,7 +362,7 @@ importers:
       '@types/aws-lambda': ^8.10.108
       '@types/jest': ^28.1.4
       '@types/lodash': ^4.14.182
-      '@types/node': ^18.0.3
+      '@types/node': ^16.18.0
       '@types/redis': 2.8.27
       dotenv-flow: ^3.2.0
       esbuild: ^0.15.11
@@ -388,11 +388,11 @@ importers:
       '@types/aws-lambda': 8.10.108
       '@types/jest': 28.1.4
       '@types/lodash': 4.14.182
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       '@types/redis': 2.8.27
       esbuild: 0.15.11
-      jest: 28.1.2_250642e41d506bccecc9f35ad915bcb5
-      ts-node: 10.8.2_2ee97d30e4a239eb38d57e3751ee8d16
+      jest: 28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862
+      ts-node: 10.8.2_c1fa8f46d69d2806146bcf2350c141a0
       tsconfig-paths: 4.0.0
       typescript: 4.9.5

@@ -409,7 +409,7 @@ importers:
       '@types/aws-lambda': ^8.10.108
       '@types/jest': ^28.1.4
       '@types/lodash': ^4.14.182
-      '@types/node': ^18.0.3
+      '@types/node': ^16.18.0
       '@types/redis': 2.8.27
       big.js: ^6.0.2
       dotenv-flow: ^3.2.0
@@ -441,11 +441,11 @@ importers:
       '@types/aws-lambda': 8.10.108
       '@types/jest': 28.1.4
       '@types/lodash': 4.14.182
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       '@types/redis': 2.8.27
       esbuild: 0.15.11
-      jest: 28.1.2_250642e41d506bccecc9f35ad915bcb5
-      ts-node: 10.8.2_2dd5d46eecda2aef953638919121af58
+      jest: 28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862
+      ts-node: 10.8.2_211a6a430b29f376d4b1cf9b4d9caf36
       tsconfig-paths: 4.0.0
       typescript: 4.7.4

@@ -475,7 +475,7 @@ importers:
       '@types/jest': ^28.1.4
       '@types/lodash': ^4.14.182
       '@types/luxon': ^3.0.0
-      '@types/node': ^18.0.3
+      '@types/node': ^16.18.0
       '@types/redis': 2.8.27
       '@types/response-time': ^2.3.5
       '@types/supertest': ^2.0.12
@@ -549,14 +549,14 @@ importers:
       '@types/jest': 28.1.4
       '@types/lodash': 4.14.182
       '@types/luxon': 3.0.0
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       '@types/redis': 2.8.27
       '@types/response-time': 2.3.5
       '@types/supertest': 2.0.12
       '@types/swagger-ui-express': 4.1.3
       concurrently: 7.6.0
-      jest: 28.1.2_250642e41d506bccecc9f35ad915bcb5
-      ts-node: 10.8.2_2dd5d46eecda2aef953638919121af58
+      jest: 28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862
+      ts-node: 10.8.2_211a6a430b29f376d4b1cf9b4d9caf36
       tsconfig-paths: 4.0.0
       typescript: 4.7.4

@@ -575,7 +575,7 @@ importers:
       '@types/jest': ^28.1.4
       '@types/lodash': ^4.14.182
       '@types/luxon': ^3.0.0
-      '@types/node': ^18.0.3
+      '@types/node': ^16.18.0
       '@types/pg': ^8.6.5
       big.js: ^6.0.2
       dd-trace: ^3.32.1
@@ -614,10 +614,10 @@ importers:
       '@types/jest': 28.1.4
       '@types/lodash': 4.14.182
       '@types/luxon': 3.0.0
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       '@types/pg': 8.6.5
-      jest: 28.1.2_250642e41d506bccecc9f35ad915bcb5
-      ts-node: 10.8.2_2dd5d46eecda2aef953638919121af58
+      jest: 28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862
+      ts-node: 10.8.2_211a6a430b29f376d4b1cf9b4d9caf36
       tsconfig-paths: 4.0.0
       typescript: 4.7.4

@@ -625,7 +625,7 @@ importers:
     specifiers:
       '@dydxprotocol-indexer/dev': workspace:^0.0.1
       '@types/jest': ^28.1.4
-      '@types/node': ^18.0.3
+      '@types/node': ^16.18.0
       dotenv-flow: ^3.2.0
       jest: ^28.1.2
       ts-node: ^10.8.2
@@ -636,9 +636,9 @@ importers:
     devDependencies:
       '@dydxprotocol-indexer/dev': link:../../packages/dev
       '@types/jest': 28.1.4
-      '@types/node': 18.0.3
-      jest: 28.1.2_250642e41d506bccecc9f35ad915bcb5
-      ts-node: 10.8.2_2dd5d46eecda2aef953638919121af58
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
+      jest: 28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862
+      ts-node: 10.8.2_211a6a430b29f376d4b1cf9b4d9caf36
       tsconfig-paths: 4.0.0
       typescript: 4.7.4

@@ -657,7 +657,7 @@ importers:
       '@types/jest': ^28.1.4
       '@types/lodash': ^4.14.182
       '@types/luxon': ^3.0.0
-      '@types/node': ^18.0.3
+      '@types/node': ^16.18.0
       '@types/redis': 2.8.27
       '@types/seedrandom': ^3.0.8
       '@types/uuid': ^8.3.4
@@ -700,12 +700,12 @@ importers:
       '@types/jest': 28.1.4
       '@types/lodash': 4.14.182
       '@types/luxon': 3.0.0
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       '@types/redis': 2.8.27
       '@types/seedrandom': 3.0.8
       '@types/uuid': 8.3.4
-      jest: 28.1.2_250642e41d506bccecc9f35ad915bcb5
-      ts-node: 10.8.2_2dd5d46eecda2aef953638919121af58
+      jest: 28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862
+      ts-node: 10.8.2_211a6a430b29f376d4b1cf9b4d9caf36
       tsconfig-paths: 4.0.0
       typescript: 4.7.4

@@ -719,7 +719,7 @@ importers:
       '@dydxprotocol-indexer/v4-protos': workspace:^0.0.1
       '@milahu/patch-package': 6.4.14
       '@types/jest': ^28.1.4
-      '@types/node': ^18.0.3
+      '@types/node': ^16.18.0
       '@types/yargs': ^16.0.0
       big.js: ^6.0.2
       dotenv-flow: ^3.2.0
@@ -747,10 +747,10 @@ importers:
     devDependencies:
       '@dydxprotocol-indexer/dev': link:../../packages/dev
       '@types/jest': 28.1.4
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       '@types/yargs': 16.0.5
-      jest: 28.1.2_250642e41d506bccecc9f35ad915bcb5
-      ts-node: 10.8.2_2dd5d46eecda2aef953638919121af58
+      jest: 28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862
+      ts-node: 10.8.2_211a6a430b29f376d4b1cf9b4d9caf36
       tsconfig-paths: 4.0.0
       typescript: 4.7.4

@@ -769,7 +769,7 @@ importers:
       '@types/express-request-id': ^1.4.3
       '@types/jest': ^28.1.4
       '@types/lodash': ^4.14.182
-      '@types/node': ^18.19.31
+      '@types/node': ^16.18.0
       '@types/response-time': ^2.3.5
       '@types/ws': ^8.5.10
       axios: ^1.2.1
@@ -819,11 +819,11 @@ importers:
       '@types/express-request-id': 1.4.3
       '@types/jest': 28.1.4
       '@types/lodash': 4.14.182
-      '@types/node': 18.19.31
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       '@types/response-time': 2.3.5
       '@types/ws': 8.5.10
-      jest: 28.1.2_e1489a60da1bfeaddb37cf23d6a3b371
-      ts-node: 10.8.2_4ea55324100c26d4019c6e6bcc89fac6
+      jest: 28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862
+      ts-node: 10.8.2_211a6a430b29f376d4b1cf9b4d9caf36
       tsconfig-paths: 4.0.0
       typescript: 4.7.4

@@ -840,7 +840,7 @@ importers:
       '@types/big.js': ^6.1.5
       '@types/jest': ^28.1.4
       '@types/luxon': 3.0.0
-      '@types/node': ^18.0.3
+      '@types/node': ^16.18.0
       '@types/redis': 2.8.27
       big.js: ^6.2.1
       dd-trace: ^3.32.1
@@ -873,10 +873,10 @@ importers:
       '@types/big.js': 6.1.5
       '@types/jest': 28.1.4
       '@types/luxon': 3.0.0
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       '@types/redis': 2.8.27
-      jest: 28.1.2_250642e41d506bccecc9f35ad915bcb5
-      ts-node: 10.8.2_2dd5d46eecda2aef953638919121af58
+      jest: 28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862
+      ts-node: 10.8.2_211a6a430b29f376d4b1cf9b4d9caf36
       tsconfig-paths: 4.0.0
       typescript: 4.7.4

@@ -5107,33 +5107,6 @@ packages:
   /@bcoe/v8-coverage/0.2.3:
     resolution: {integrity: sha512-0hYQ8SB4Db5zvZB4axdMHGwEaQjkZzFjQiN9LVYvIFB2nSUHW9tYpxWriPrWDASIxiaXax83REcLxuSdnGPZtw==}

-  /@bufbuild/buf-darwin-arm64/1.19.0-1:
-    resolution: {integrity: sha512-HsWPii21wm3QSyuxrNq9+Yf8iAgpnC4rNCy4x3d6P1fd/LmgE1NPzQW0ghEZvl9dgAQKkL/4S5bKhlm7kbUdmQ==}
-    engines: {node: '>=12'}
-    cpu: [arm64]
-    os: [darwin]
-    requiresBuild: true
-    dev: false
-    optional: true
-
-  /@bufbuild/buf-darwin-x64/1.19.0-1:
-    resolution: {integrity: sha512-2+Ig7ylYpVh4kms/OeJJVY+X0KX4awPA6hYr7L7aZOIcHwZEM8lWtSTO/se5pQc7dc8FXNiC4YUqHC8yfxxX6Q==}
-    engines: {node: '>=12'}
-    cpu: [x64]
-    os: [darwin]
-    requiresBuild: true
-    dev: false
-    optional: true
-
-  /@bufbuild/buf-linux-aarch64/1.19.0-1:
-    resolution: {integrity: sha512-g/Vxg3WiBr3nhsxsRr2Q81xXJD+0ktHIO3ZJggTG2Sbbl3dh8kyg1iKM6MjJiMP7su5RKCylLigzoEJzVTShyA==}
-    engines: {node: '>=12'}
-    cpu: [arm64]
-    os: [linux]
-    requiresBuild: true
-    dev: false
-    optional: true
-
   /@bufbuild/buf-linux-x64/1.19.0-1:
     resolution: {integrity: sha512-anYuGx8k/2kp8GPX3eHNUf3IY/01Zpnyw0HaLPXK1Btqyy6XkapVywrDqg7YUzMd1ySFEp1wD9UqRNdEFNCQ4A==}
     engines: {node: '>=12'}
@@ -5143,36 +5116,18 @@ packages:
     dev: false
     optional: true

-  /@bufbuild/buf-win32-arm64/1.19.0-1:
-    resolution: {integrity: sha512-xXgF1qYnCfRKbGx1FqvPbpZ6ajh4ddxpXhSxI3VCeb3MsMBuIbiLqX4fQAL3ls/Zwz8tVIITuSwOhYmSEGcpBA==}
-    engines: {node: '>=12'}
-    cpu: [arm64]
-    os: [win32]
-    requiresBuild: true
-    dev: false
-    optional: true
-
-  /@bufbuild/buf-win32-x64/1.19.0-1:
-    resolution: {integrity: sha512-futmqgpMQCR1lcAzZJEGjPr7ECw1gYTPIV8crm5SY+iCJ7sOeStOBNt7q5hV4LKmmeWmvm03XIMZPjhQzjH5NQ==}
-    engines: {node: '>=12'}
-    cpu: [x64]
-    os: [win32]
-    requiresBuild: true
-    dev: false
-    optional: true
-
   /@bufbuild/buf/1.19.0-1:
     resolution: {integrity: sha512-TIsLTTQUntr/Xq/IMSULv3dlC3/ZsVwQtWgxmJ++IzSuOW79TFQfq59vFeTWrPa6+QXFMz5t6jkMyD4ghzO5nw==}
     engines: {node: '>=12'}
     hasBin: true
     requiresBuild: true
     optionalDependencies:
-      '@bufbuild/buf-darwin-arm64': 1.19.0-1
-      '@bufbuild/buf-darwin-x64': 1.19.0-1
-      '@bufbuild/buf-linux-aarch64': 1.19.0-1
+      '@bufbuild/buf-darwin-arm64': registry.npmmirror.com/@bufbuild/buf-darwin-arm64/1.19.0-1
+      '@bufbuild/buf-darwin-x64': registry.npmmirror.com/@bufbuild/buf-darwin-x64/1.19.0-1
+      '@bufbuild/buf-linux-aarch64': registry.npmmirror.com/@bufbuild/buf-linux-aarch64/1.19.0-1
       '@bufbuild/buf-linux-x64': 1.19.0-1
-      '@bufbuild/buf-win32-arm64': 1.19.0-1
-      '@bufbuild/buf-win32-x64': 1.19.0-1
+      '@bufbuild/buf-win32-arm64': registry.npmmirror.com/@bufbuild/buf-win32-arm64/1.19.0-1
+      '@bufbuild/buf-win32-x64': registry.npmmirror.com/@bufbuild/buf-win32-x64/1.19.0-1
     dev: false

   /@bugsnag/browser/7.18.0:
@@ -5454,24 +5409,6 @@ packages:
     resolution: {integrity: sha512-smLocSfrt3s53H/XSVP3/1kP42oqvrkjUPtyaFd1F79ux24oE31BKt+q0c6lsa6hOYrFzsIwyc5GXAI5JmfOew==}
     dev: false

-  /@esbuild/android-arm/0.15.11:
-    resolution: {integrity: sha512-PzMcQLazLBkwDEkrNPi9AbjFt6+3I7HKbiYF2XtWQ7wItrHvEOeO3T8Am434zAozWtVP7lrTue1bEfc2nYWeCA==}
-    engines: {node: '>=12'}
-    cpu: [arm]
-    os: [android]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /@esbuild/linux-loong64/0.15.11:
-    resolution: {integrity: sha512-geWp637tUhNmhL3Xgy4Bj703yXB9dqiLJe05lCUfjSFDrQf9C/8pArusyPUbUbPwlC/EAUjBw32sxuIl/11dZw==}
-    engines: {node: '>=12'}
-    cpu: [loong64]
-    os: [linux]
-    requiresBuild: true
-    dev: true
-    optional: true
-
   /@eslint/eslintrc/1.3.0:
     resolution: {integrity: sha512-UWW0TMTmk2d7hLcWD1/e2g5HDM/HQ3csaLSqXCfqwh4uNDuNqlaKWXmEsL4Cs41Z0KnILNvwbHAah3C2yt06kw==}
     engines: {node: ^12.22.0 || ^14.17.0 || >=16.0.0}
@@ -5483,7 +5420,7 @@ packages:
       ignore: 5.2.0
       import-fresh: 3.3.0
       js-yaml: 4.1.0
-      minimatch: 3.1.2
+      minimatch: registry.npmmirror.com/minimatch/3.1.2
       strip-json-comments: 3.1.1
     transitivePeerDependencies:
       - supports-color
@@ -5600,21 +5537,6 @@ packages:
       tslib: 2.5.0
     dev: false

-  /@google-cloud/firestore/7.9.0:
-    resolution: {integrity: sha512-c4ALHT3G08rV7Zwv8Z2KG63gZh66iKdhCBeDfCpIkLrjX6EAjTD/szMdj14M+FnQuClZLFfW5bAgoOjfNmLtJg==}
-    engines: {node: '>=14.0.0'}
-    requiresBuild: true
-    dependencies:
-      fast-deep-equal: 3.1.3
-      functional-red-black-tree: 1.0.1
-      google-gax: 4.4.1
-      protobufjs: 7.3.2
-    transitivePeerDependencies:
-      - encoding
-      - supports-color
-    dev: false
-    optional: true
-
   /@google-cloud/paginator/5.0.2:
     resolution: {integrity: sha512-DJS3s0OVH4zFDB1PzjxAsHqJT6sKVbRwwML0ZBP9PbU7Yebtu/7SWMRzvO2J3nUi9pRNITCfu4LJeooM2w4pjg==}
     engines: {node: '>=14.0.0'}
@@ -5636,32 +5558,6 @@ packages:
     dev: false
     optional: true

-  /@google-cloud/storage/7.12.1:
-    resolution: {integrity: sha512-Z3ZzOnF3YKLuvpkvF+TjQ6lztxcAyTILp+FjKonmVpEwPa9vFvxpZjubLR4sB6bf19i/8HL2AXRjA0YFgHFRmQ==}
-    engines: {node: '>=14'}
-    requiresBuild: true
-    dependencies:
-      '@google-cloud/paginator': 5.0.2
-      '@google-cloud/projectify': 4.0.0
-      '@google-cloud/promisify': 4.0.0
-      abort-controller: 3.0.0
-      async-retry: 1.3.3
-      duplexify: 4.1.3
-      fast-xml-parser: 4.5.0
-      gaxios: 6.7.1
-      google-auth-library: 9.14.1
-      html-entities: 2.5.2
-      mime: 3.0.0
-      p-limit: 3.1.0
-      retry-request: 7.0.2
-      teeny-request: 9.0.0
-      uuid: 8.3.2
-    transitivePeerDependencies:
-      - encoding
-      - supports-color
-    dev: false
-    optional: true
-
   /@grpc/grpc-js/1.11.1:
     resolution: {integrity: sha512-gyt/WayZrVPH2w/UTLansS7F9Nwld472JxxaETamrM8HNlsa+jSLNyKAZmhxI2Me4c3mQHFiS1wWHDY1g1Kthw==}
     engines: {node: '>=12.10.0'}
@@ -5689,7 +5585,7 @@ packages:
     dependencies:
       '@humanwhocodes/object-schema': 1.2.1
       debug: 4.3.4
-      minimatch: 3.1.2
+      minimatch: registry.npmmirror.com/minimatch/3.1.2
     transitivePeerDependencies:
       - supports-color
     dev: true
@@ -5717,7 +5613,7 @@ packages:
     engines: {node: ^12.13.0 || ^14.15.0 || ^16.10.0 || >=17.0.0}
     dependencies:
       '@jest/types': 28.1.1
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       chalk: 4.1.2
       jest-message-util: 28.1.1
       jest-util: 28.1.1
@@ -5737,14 +5633,14 @@ packages:
       '@jest/test-result': 28.1.1
       '@jest/transform': 28.1.2
       '@jest/types': 28.1.1
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       ansi-escapes: 4.3.2
       chalk: 4.1.2
       ci-info: 3.3.2
       exit: 0.1.2
       graceful-fs: 4.2.10
       jest-changed-files: 28.0.2
-      jest-config: 28.1.2_@types+node@18.0.3
+      jest-config: 28.1.2_@types+node@22.5.4
       jest-haste-map: 28.1.1
       jest-message-util: 28.1.1
       jest-regex-util: 28.0.2
@@ -5780,14 +5676,14 @@ packages:
       '@jest/test-result': 28.1.1
       '@jest/transform': 28.1.2
       '@jest/types': 28.1.1
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       ansi-escapes: 4.3.2
       chalk: 4.1.2
       ci-info: 3.3.2
       exit: 0.1.2
       graceful-fs: 4.2.10
       jest-changed-files: 28.0.2
-      jest-config: 28.1.2_250642e41d506bccecc9f35ad915bcb5
+      jest-config: 28.1.2_64ffb24aadbc9b76404532eae276b1cd
       jest-haste-map: 28.1.1
       jest-message-util: 28.1.1
       jest-regex-util: 28.0.2
@@ -5814,7 +5710,7 @@ packages:
     dependencies:
       '@jest/fake-timers': 28.1.2
       '@jest/types': 28.1.1
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       jest-mock: 28.1.1

   /@jest/expect-utils/28.1.1:
@@ -5838,7 +5734,7 @@ packages:
     dependencies:
       '@jest/types': 28.1.1
       '@sinonjs/fake-timers': 9.1.2
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       jest-message-util: 28.1.1
       jest-mock: 28.1.1
       jest-util: 28.1.1
@@ -5868,7 +5764,7 @@ packages:
       '@jest/transform': 28.1.2
       '@jest/types': 28.1.1
       '@jridgewell/trace-mapping': 0.3.14
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       chalk: 4.1.2
       collect-v8-coverage: 1.0.1
       exit: 0.1.2
@@ -5980,7 +5876,7 @@ packages:
       '@jest/schemas': 28.0.2
       '@types/istanbul-lib-coverage': 2.0.4
       '@types/istanbul-reports': 3.0.1
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       '@types/yargs': 17.0.10
       chalk: 4.1.2

@@ -6915,7 +6811,7 @@ packages:
     resolution: {integrity: sha512-ALYone6pm6QmwZoAgeyNksccT9Q4AWZQ6PvfwR37GT6r6FWUPguq6sUmNGSMV2Wr761oQoBxwGGa6DR5o1DC9g==}
     dependencies:
       '@types/connect': 3.4.35
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4

   /@types/caseless/0.12.5:
     resolution: {integrity: sha512-hWtVTC2q7hc7xZ/RLbxapMvDMgUnDvKvMOpKal4DrMyfGBUfB1oKaZlIRr6mJL+If3bAP6sV/QneGzF6tJjZDg==}
@@ -6925,7 +6821,7 @@ packages:
   /@types/connect/3.4.35:
     resolution: {integrity: sha512-cdeYyv4KWoEgpBISTxWvqYsVy444DOqehiF3fM3ne10AmJ62RSyNkUnxMJXHQWRQQX2eR94m5y1IZyDwBjV9FQ==}
     dependencies:
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4

   /@types/cookiejar/2.1.2:
     resolution: {integrity: sha512-t73xJJrvdTjXrn4jLS9VSGRbz0nUY3cl2DMGDU48lKl+HR9dbbjW2A9r3g40VA++mQpy6uuHg33gy7du2BKpog==}
@@ -6952,7 +6848,7 @@ packages:
   /@types/express-serve-static-core/4.17.30:
     resolution: {integrity: sha512-gstzbTWro2/nFed1WXtf+TtrpwxH7Ggs4RLYTLbeVgIkUQOI3WG/JKjgeOU1zXDvezllupjrf8OPIdvTbIaVOQ==}
     dependencies:
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       '@types/qs': 6.9.7
       '@types/range-parser': 1.2.4

@@ -6992,7 +6888,7 @@ packages:
   /@types/graceful-fs/4.1.5:
     resolution: {integrity: sha512-anKkLmZZ+xm4p8JWBf4hElkM4XR+EZeA2M9BAkkTldmcyDY4mbdIJnRghDJH3Ov5ooY7/UAoENtmdMSkaAd7Cw==}
     dependencies:
-      '@types/node': 22.5.4
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4

   /@types/istanbul-lib-coverage/2.0.4:
     resolution: {integrity: sha512-z/QT1XN4K4KYuslS23k62yDIDLwLFkzxOuMplDtObz0+y7VqJCaO2o+SPwHCvLFZh7xazvvoor2tA/hPz9ee7g==}
@@ -7055,13 +6951,6 @@ packages:
       '@types/express': 4.17.13
     dev: false

-  /@types/node/10.12.18:
-    resolution: {integrity: sha512-fh+pAqt4xRzPfqA6eh3Z2y6fyZavRIumvjhaCL753+TVkGKGhpPeyrJG2JftD0T9q4GF00KjefsQ+PQNDdWQaQ==}
-    dev: false
-
-  /@types/node/18.0.3:
-    resolution: {integrity: sha512-HzNRZtp4eepNitP+BD6k2L6DROIDG4Q0fm4x+dwfsr6LGmROENnok75VGw40628xf+iR24WeMFcHuuBDUAzzsQ==}
-
   /@types/node/18.19.31:
     resolution: {integrity: sha512-ArgCD39YpyyrtFKIqMDvjz79jto5fcI/SVUs2HwB+f0dAzq68yqOdyaSivLiLugSziTpNXLQrVb7RZFmdZzbhA==}
     dependencies:
@@ -7080,7 +6969,7 @@ packages:
   /@types/pg/8.6.5:
     resolution: {integrity: sha512-tOkGtAqRVkHa/PVZicq67zuujI4Oorfglsr2IbKofDwBSysnaqSx7W1mDqFqdkGE6Fbgh+PZAl0r/BWON/mozw==}
     dependencies:
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       pg-protocol: 1.5.0
       pg-types: 2.2.0
     dev: true
@@ -7097,7 +6986,7 @@ packages:
   /@types/redis/2.8.27:
     resolution: {integrity: sha512-RRHarqPp3mgqHz+qzLVuQCJAIVaB3JBaczoj24QVVYu08wiCmB8vbOeNeK9lIH+pyT7+R/bbEPghAZZuhbZm0g==}
     dependencies:
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
     dev: true

   /@types/request/2.48.12:
@@ -7114,7 +7003,7 @@ packages:
     resolution: {integrity: sha512-4ANzp+I3K7sztFFAGPALWBvSl4ayaDSKzI2Bok+WNz+en2eB2Pvk6VCjR47PBXBWOkEg2r4uWpZOlXA5DNINOQ==}
     dependencies:
       '@types/express': 4.17.13
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
     dev: true

   /@types/seedrandom/3.0.8:
@@ -7132,7 +7021,7 @@ packages:
     resolution: {integrity: sha512-z5xyF6uh8CbjAu9760KDKsH2FcDxZ2tFCsA4HIMWE6IkiYMXfVoa+4f9KX+FN0ZLsaMw1WNG2ETLA6N+/YA+cg==}
     dependencies:
       '@types/mime': 3.0.1
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4

   /@types/stack-utils/2.0.1:
     resolution: {integrity: sha512-Hl219/BT5fLAaz6NDkSuhzasy49dwQS/DSdu4MdggFB8zcXv7vflBI3xp7FEmkmdDkBUI2bPUNeMttp2knYdxw==}
@@ -7141,7 +7030,7 @@ packages:
     resolution: {integrity: sha512-mu/N4uvfDN2zVQQ5AYJI/g4qxn2bHB6521t1UuH09ShNWjebTqN0ZFuYK9uYjcgmI0dTQEs+Owi1EO6U0OkOZQ==}
     dependencies:
       '@types/cookiejar': 2.1.2
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
     dev: true

   /@types/supertest/2.0.12:
@@ -7981,7 +7870,7 @@ packages:
     resolution: {integrity: sha512-HpV5OMLLGTjSVblmrtYRfFFKuQB+GArM0+XP8HGWfJ5vxYBqo+DesvJwOdC2WJ3bCkZShGf0QIfoIpeomVzVdA==}
     engines: {node: '>=6.0.0'}
     dependencies:
-      '@types/node': 10.12.18
+      '@types/node': registry.npmmirror.com/@types/node/10.12.18
       bs58check: 2.1.2
       create-hash: 1.2.0
       create-hmac: 1.1.7
@@ -9150,214 +9039,34 @@ packages:
       es6-symbol: 3.1.3
     dev: true

-  /esbuild-android-64/0.15.11:
-    resolution: {integrity: sha512-rrwoXEiuI1kaw4k475NJpexs8GfJqQUKcD08VR8sKHmuW9RUuTR2VxcupVvHdiGh9ihxL9m3lpqB1kju92Ialw==}
-    engines: {node: '>=12'}
-    cpu: [x64]
-    os: [android]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-android-arm64/0.15.11:
-    resolution: {integrity: sha512-/hDubOg7BHOhUUsT8KUIU7GfZm5bihqssvqK5PfO4apag7YuObZRZSzViyEKcFn2tPeHx7RKbSBXvAopSHDZJQ==}
-    engines: {node: '>=12'}
-    cpu: [arm64]
-    os: [android]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-darwin-64/0.15.11:
-    resolution: {integrity: sha512-1DqHD0ms3AhiwkKnjRUzmiW7JnaJJr5FKrPiR7xuyMwnjDqvNWDdMq4rKSD9OC0piFNK6n0LghsglNMe2MwJtA==}
-    engines: {node: '>=12'}
-    cpu: [x64]
-    os: [darwin]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-darwin-arm64/0.15.11:
-    resolution: {integrity: sha512-OMzhxSbS0lwwrW40HHjRCeVIJTURdXFA8c3GU30MlHKuPCcvWNUIKVucVBtNpJySXmbkQMDJdJNrXzNDyvoqvQ==}
-    engines: {node: '>=12'}
-    cpu: [arm64]
-    os: [darwin]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-freebsd-64/0.15.11:
-    resolution: {integrity: sha512-8dKP26r0/Qyez8nTCwpq60QbuYKOeBygdgOAWGCRalunyeqWRoSZj9TQjPDnTTI9joxd3QYw3UhVZTKxO9QdRg==}
-    engines: {node: '>=12'}
-    cpu: [x64]
-    os: [freebsd]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-freebsd-arm64/0.15.11:
-    resolution: {integrity: sha512-aSGiODiukLGGnSg/O9+cGO2QxEacrdCtCawehkWYTt5VX1ni2b9KoxpHCT9h9Y6wGqNHmXFnB47RRJ8BIqZgmQ==}
-    engines: {node: '>=12'}
-    cpu: [arm64]
-    os: [freebsd]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-linux-32/0.15.11:
-    resolution: {integrity: sha512-lsrAfdyJBGx+6aHIQmgqUonEzKYeBnyfJPkT6N2dOf1RoXYYV1BkWB6G02tjsrz1d5wZzaTc3cF+TKmuTo/ZwA==}
-    engines: {node: '>=12'}
-    cpu: [ia32]
-    os: [linux]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-linux-64/0.15.11:
-    resolution: {integrity: sha512-Y2Rh+PcyVhQqXKBTacPCltINN3uIw2xC+dsvLANJ1SpK5NJUtxv8+rqWpjmBgaNWKQT1/uGpMmA9olALy9PLVA==}
-    engines: {node: '>=12'}
-    cpu: [x64]
-    os: [linux]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-linux-arm/0.15.11:
-    resolution: {integrity: sha512-TJllTVk5aSyqPFvvcHTvf6Wu1ZKhWpJ/qNmZO8LL/XeB+LXCclm7HQHNEIz6MT7IX8PmlC1BZYrOiw2sXSB95A==}
-    engines: {node: '>=12'}
-    cpu: [arm]
-    os: [linux]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-linux-arm64/0.15.11:
-    resolution: {integrity: sha512-uhcXiTwTmD4OpxJu3xC5TzAAw6Wzf9O1XGWL448EE9bqGjgV1j+oK3lIHAfsHnuIn8K4nDW8yjX0Sv5S++oRuw==}
-    engines: {node: '>=12'}
-    cpu: [arm64]
-    os: [linux]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-linux-mips64le/0.15.11:
-    resolution: {integrity: sha512-WD61y/R1M4BLe4gxXRypoQ0Ci+Vjf714QYzcPNkiYv5I8K8WDz2ZR8Bm6cqKxd6rD+e/rZgPDbhQ9PCf7TMHmA==}
-    engines: {node: '>=12'}
-    cpu: [mips64el]
-    os: [linux]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-linux-ppc64le/0.15.11:
-    resolution: {integrity: sha512-JVleZS9oPVLTlBhPTWgOwxFWU/wMUdlBwTbGA4GF8c38sLbS13cupj+C8bLq929jU7EMWry4SaL+tKGIaTlqKg==}
-    engines: {node: '>=12'}
-    cpu: [ppc64]
-    os: [linux]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-linux-riscv64/0.15.11:
-    resolution: {integrity: sha512-9aLIalZ2HFHIOZpmVU11sEAS9F8TnHw49daEjcgMpBXHFF57VuT9f9/9LKJhw781Gda0P9jDkuCWJ0tFbErvJw==}
-    engines: {node: '>=12'}
-    cpu: [riscv64]
-    os: [linux]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-linux-s390x/0.15.11:
-    resolution: {integrity: sha512-sZHtiXXOKsLI3XGBGoYO4qKBzJlb8xNsWmvFiwFMHFzA4AXgDP1KDp7Dawe9C2pavTRBDvl+Ok4n/DHQ59oaTg==}
-    engines: {node: '>=12'}
-    cpu: [s390x]
-    os: [linux]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-netbsd-64/0.15.11:
-    resolution: {integrity: sha512-hUC9yN06K9sg7ju4Vgu9ChAPdsEgtcrcLfyNT5IKwKyfpLvKUwCMZSdF+gRD3WpyZelgTQfJ+pDx5XFbXTlB0A==}
-    engines: {node: '>=12'}
-    cpu: [x64]
-    os: [netbsd]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-openbsd-64/0.15.11:
-    resolution: {integrity: sha512-0bBo9SQR4t66Wd91LGMAqmWorzO0TTzVjYiifwoFtel8luFeXuPThQnEm5ztN4g0fnvcp7AnUPPzS/Depf17wQ==}
-    engines: {node: '>=12'}
-    cpu: [x64]
-    os: [openbsd]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-sunos-64/0.15.11:
-    resolution: {integrity: sha512-EuBdTGlsMTjEl1sQnBX2jfygy7iR6CKfvOzi+gEOfhDqbHXsmY1dcpbVtcwHAg9/2yUZSfMJHMAgf1z8M4yyyw==}
-    engines: {node: '>=12'}
-    cpu: [x64]
-    os: [sunos]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-windows-32/0.15.11:
-    resolution: {integrity: sha512-O0/Wo1Wk6dc0rZSxkvGpmTNIycEznHmkObTFz2VHBhjPsO4ZpCgfGxNkCpz4AdAIeMczpTXt/8d5vdJNKEGC+Q==}
-    engines: {node: '>=12'}
-    cpu: [ia32]
-    os: [win32]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-windows-64/0.15.11:
-    resolution: {integrity: sha512-x977Q4HhNjnHx00b4XLAnTtj5vfbdEvkxaQwC1Zh5AN8g5EX+izgZ6e5QgqJgpzyRNJqh4hkgIJF1pyy1be0mQ==}
-    engines: {node: '>=12'}
-    cpu: [x64]
-    os: [win32]
-    requiresBuild: true
-    dev: true
-    optional: true
-
-  /esbuild-windows-arm64/0.15.11:
-    resolution: {integrity: sha512-VwUHFACuBahrvntdcMKZteUZ9HaYrBRODoKe4tIWxguQRvvYoYb7iu5LrcRS/FQx8KPZNaa72zuqwVtHeXsITw==}
-    engines: {node: '>=12'}
-    cpu: [arm64]
-    os: [win32]
-    requiresBuild: true
-    dev: true
-    optional: true
-
   /esbuild/0.15.11:
     resolution: {integrity: sha512-OgHGuhlfZ//mToxjte1D5iiiQgWfJ2GByVMwEC/IuoXsBGkuyK1+KrjYu0laSpnN/L1UmLUCv0s25vObdc1bVg==}
     engines: {node: '>=12'}
     hasBin: true
     requiresBuild: true
     optionalDependencies:
-      '@esbuild/android-arm': 0.15.11
-      '@esbuild/linux-loong64': 0.15.11
-      esbuild-android-64: 0.15.11
-      esbuild-android-arm64: 0.15.11
-      esbuild-darwin-64: 0.15.11
-      esbuild-darwin-arm64: 0.15.11
-      esbuild-freebsd-64: 0.15.11
-      esbuild-freebsd-arm64: 0.15.11
-      esbuild-linux-32: 0.15.11
-      esbuild-linux-64: 0.15.11
-      esbuild-linux-arm: 0.15.11
-      esbuild-linux-arm64: 0.15.11
-      esbuild-linux-mips64le: 0.15.11
-      esbuild-linux-ppc64le: 0.15.11
-      esbuild-linux-riscv64: 0.15.11
-      esbuild-linux-s390x: 0.15.11
-      esbuild-netbsd-64: 0.15.11
-      esbuild-openbsd-64: 0.15.11
-      esbuild-sunos-64: 0.15.11
-      esbuild-windows-32: 0.15.11
-      esbuild-windows-64: 0.15.11
-      esbuild-windows-arm64: 0.15.11
+      '@esbuild/android-arm': registry.npmmirror.com/@esbuild/android-arm/0.15.11
+      '@esbuild/linux-loong64': registry.npmmirror.com/@esbuild/linux-loong64/0.15.11
+      esbuild-android-64: registry.npmmirror.com/esbuild-android-64/0.15.11
+      esbuild-android-arm64: registry.npmmirror.com/esbuild-android-arm64/0.15.11
+      esbuild-darwin-64: registry.npmmirror.com/esbuild-darwin-64/0.15.11
+      esbuild-darwin-arm64: registry.npmmirror.com/esbuild-darwin-arm64/0.15.11
+      esbuild-freebsd-64: registry.npmmirror.com/esbuild-freebsd-64/0.15.11
+      esbuild-freebsd-arm64: registry.npmmirror.com/esbuild-freebsd-arm64/0.15.11
+      esbuild-linux-32: registry.npmmirror.com/esbuild-linux-32/0.15.11
+      esbuild-linux-64: registry.npmmirror.com/esbuild-linux-64/0.15.11
+      esbuild-linux-arm: registry.npmmirror.com/esbuild-linux-arm/0.15.11
+      esbuild-linux-arm64: registry.npmmirror.com/esbuild-linux-arm64/0.15.11
+      esbuild-linux-mips64le: registry.npmmirror.com/esbuild-linux-mips64le/0.15.11
+      esbuild-linux-ppc64le: registry.npmmirror.com/esbuild-linux-ppc64le/0.15.11
+      esbuild-linux-riscv64: registry.npmmirror.com/esbuild-linux-riscv64/0.15.11
+      esbuild-linux-s390x: registry.npmmirror.com/esbuild-linux-s390x/0.15.11
+      esbuild-netbsd-64: registry.npmmirror.com/esbuild-netbsd-64/0.15.11
+      esbuild-openbsd-64: registry.npmmirror.com/esbuild-openbsd-64/0.15.11
+      esbuild-sunos-64: registry.npmmirror.com/esbuild-sunos-64/0.15.11
+      esbuild-windows-32: registry.npmmirror.com/esbuild-windows-32/0.15.11
+      esbuild-windows-64: registry.npmmirror.com/esbuild-windows-64/0.15.11
+      esbuild-windows-arm64: registry.npmmirror.com/esbuild-windows-arm64/0.15.11
     dev: true

   /escalade/3.1.1:
@@ -10100,8 +9809,8 @@ packages:
       node-forge: 1.3.1
       uuid: 10.0.0
     optionalDependencies:
-      '@google-cloud/firestore': 7.9.0
-      '@google-cloud/storage': 7.12.1
+      '@google-cloud/firestore': registry.npmmirror.com/@google-cloud/firestore/7.9.0
+      '@google-cloud/storage': registry.npmmirror.com/@google-cloud/storage/7.12.1
     transitivePeerDependencies:
       - encoding
       - supports-color
@@ -10264,13 +9973,6 @@ packages:
   /fs.realpath/1.0.0:
     resolution: {integrity: sha512-OO0pH2lK6a0hZnAdau5ItzHPI6pUlvI7jMVnxUQRtw4owF2wk8lOSabtGDCTP4Ggrg2MbGnWO9X8K1t4+fGMDw==}

-  /fsevents/2.3.2:
-    resolution: {integrity: sha512-xiqMQR4xAeHTuB9uWm+fFRcIOgKBMiOBP+eXiyT7jsgVCq1bkVygt00oASowB7EdtpOHaaPgKt812P9ab+DDKA==}
-    engines: {node: ^8.16.0 || ^10.6.0 || >=11.0.0}
-    os: [darwin]
-    requiresBuild: true
-    optional: true
-
   /function-bind/1.1.1:
     resolution: {integrity: sha512-yIovAzMX49sF8Yl58fSCWJ5svSLuaibPxXQJFLmBObTuCr0Mf1KiPopGM9NiFjiYBCbfaa2Fh6breQ6ANVTI0A==}

@@ -10597,7 +10299,7 @@ packages:
       source-map: 0.6.1
       wordwrap: 1.0.0
     optionalDependencies:
-      uglify-js: 3.17.4
+      uglify-js: registry.npmmirror.com/uglify-js/3.17.4
     dev: false

   /har-schema/2.0.0:
@@ -11418,7 +11120,7 @@ packages:
       '@jest/expect': 28.1.2
       '@jest/test-result': 28.1.1
       '@jest/types': 28.1.1
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       chalk: 4.1.2
       co: 4.6.0
       dedent: 0.7.0
@@ -11464,7 +11166,7 @@ packages:
       - ts-node
     dev: true

-  /jest-cli/28.1.2_250642e41d506bccecc9f35ad915bcb5:
+  /jest-cli/28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862:
     resolution: {integrity: sha512-l6eoi5Do/IJUXAFL9qRmDiFpBeEJAnjJb1dcd9i/VWfVWbp3mJhuH50dNtX67Ali4Ecvt4eBkWb4hXhPHkAZTw==}
     engines: {node: ^12.13.0 || ^14.15.0 || ^16.10.0 || >=17.0.0}
     hasBin: true
@@ -11481,7 +11183,7 @@ packages:
       exit: 0.1.2
       graceful-fs: 4.2.10
       import-local: 3.1.0
-      jest-config: 28.1.2_250642e41d506bccecc9f35ad915bcb5
+      jest-config: 28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862
       jest-util: 28.1.1
       jest-validate: 28.1.1
       prompts: 2.4.2
@@ -11491,7 +11193,7 @@ packages:
       - supports-color
       - ts-node

-  /jest-cli/28.1.2_@types+node@18.0.3:
+  /jest-cli/28.1.2_@types+node@16.18.126:
     resolution: {integrity: sha512-l6eoi5Do/IJUXAFL9qRmDiFpBeEJAnjJb1dcd9i/VWfVWbp3mJhuH50dNtX67Ali4Ecvt4eBkWb4hXhPHkAZTw==}
     engines: {node: ^12.13.0 || ^14.15.0 || ^16.10.0 || >=17.0.0}
     hasBin: true
@@ -11508,7 +11210,7 @@ packages:
       exit: 0.1.2
       graceful-fs: 4.2.10
       import-local: 3.1.0
-      jest-config: 28.1.2_@types+node@18.0.3
+      jest-config: 28.1.2_@types+node@16.18.126
       jest-util: 28.1.1
       jest-validate: 28.1.1
       prompts: 2.4.2
@@ -11519,7 +11221,7 @@ packages:
       - ts-node
     dev: true

-  /jest-cli/28.1.2_e1489a60da1bfeaddb37cf23d6a3b371:
+  /jest-cli/28.1.2_ts-node@10.8.2:
     resolution: {integrity: sha512-l6eoi5Do/IJUXAFL9qRmDiFpBeEJAnjJb1dcd9i/VWfVWbp3mJhuH50dNtX67Ali4Ecvt4eBkWb4hXhPHkAZTw==}
     engines: {node: ^12.13.0 || ^14.15.0 || ^16.10.0 || >=17.0.0}
     hasBin: true
@@ -11536,7 +11238,7 @@ packages:
       exit: 0.1.2
       graceful-fs: 4.2.10
       import-local: 3.1.0
-      jest-config: 28.1.2_e1489a60da1bfeaddb37cf23d6a3b371
+      jest-config: 28.1.2_ts-node@10.8.2
       jest-util: 28.1.1
       jest-validate: 28.1.1
       prompts: 2.4.2
@@ -11547,35 +11249,45 @@ packages:
       - ts-node
     dev: true

-  /jest-cli/28.1.2_ts-node@10.8.2:
-    resolution: {integrity: sha512-l6eoi5Do/IJUXAFL9qRmDiFpBeEJAnjJb1dcd9i/VWfVWbp3mJhuH50dNtX67Ali4Ecvt4eBkWb4hXhPHkAZTw==}
+  /jest-config/28.1.2:
+    resolution: {integrity: sha512-g6EfeRqddVbjPVBVY4JWpUY4IvQoFRIZcv4V36QkqzE0IGhEC/VkugFeBMAeUE7PRgC8KJF0yvJNDeQRbamEVA==}
     engines: {node: ^12.13.0 || ^14.15.0 || ^16.10.0 || >=17.0.0}
-    hasBin: true
     peerDependencies:
-      node-notifier: ^8.0.1 || ^9.0.0 || ^10.0.0
+      '@types/node': '*'
+      ts-node: '>=9.0.0'
     peerDependenciesMeta:
-      node-notifier:
+      '@types/node':
+        optional: true
+      ts-node:
         optional: true
     dependencies:
-      '@jest/core': 28.1.2_ts-node@10.8.2
-      '@jest/test-result': 28.1.1
+      '@babel/core': 7.18.6
+      '@jest/test-sequencer': 28.1.1
       '@jest/types': 28.1.1
+      babel-jest: 28.1.2_@babel+core@7.18.6
       chalk: 4.1.2
-      exit: 0.1.2
+      ci-info: 3.3.2
+      deepmerge: 4.2.2
+      glob: 7.2.3
       graceful-fs: 4.2.10
-      import-local: 3.1.0
-      jest-config: 28.1.2_ts-node@10.8.2
+      jest-circus: 28.1.2
+      jest-environment-node: 28.1.2
+      jest-get-type: 28.0.2
+      jest-regex-util: 28.0.2
+      jest-resolve: 28.1.1
+      jest-runner: 28.1.2
       jest-util: 28.1.1
       jest-validate: 28.1.1
-      prompts: 2.4.2
-      yargs: 17.5.1
+      micromatch: 4.0.5
+      parse-json: 5.2.0
+      pretty-format: 28.1.1
+      slash: 3.0.0
+      strip-json-comments: 3.1.1
     transitivePeerDependencies:
-      - '@types/node'
       - supports-color
-      - ts-node
     dev: true

-  /jest-config/28.1.2:
+  /jest-config/28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862:
     resolution: {integrity: sha512-g6EfeRqddVbjPVBVY4JWpUY4IvQoFRIZcv4V36QkqzE0IGhEC/VkugFeBMAeUE7PRgC8KJF0yvJNDeQRbamEVA==}
     engines: {node: ^12.13.0 || ^14.15.0 || ^16.10.0 || >=17.0.0}
     peerDependencies:
@@ -11590,6 +11302,7 @@ packages:
       '@babel/core': 7.18.6
       '@jest/test-sequencer': 28.1.1
       '@jest/types': 28.1.1
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       babel-jest: 28.1.2_@babel+core@7.18.6
       chalk: 4.1.2
       ci-info: 3.3.2
@@ -11609,11 +11322,11 @@ packages:
       pretty-format: 28.1.1
       slash: 3.0.0
       strip-json-comments: 3.1.1
+      ts-node: 10.8.2_211a6a430b29f376d4b1cf9b4d9caf36
     transitivePeerDependencies:
       - supports-color
-    dev: true

-  /jest-config/28.1.2_250642e41d506bccecc9f35ad915bcb5:
+  /jest-config/28.1.2_64ffb24aadbc9b76404532eae276b1cd:
     resolution: {integrity: sha512-g6EfeRqddVbjPVBVY4JWpUY4IvQoFRIZcv4V36QkqzE0IGhEC/VkugFeBMAeUE7PRgC8KJF0yvJNDeQRbamEVA==}
     engines: {node: ^12.13.0 || ^14.15.0 || ^16.10.0 || >=17.0.0}
     peerDependencies:
@@ -11628,7 +11341,7 @@ packages:
       '@babel/core': 7.18.6
       '@jest/test-sequencer': 28.1.1
       '@jest/types': 28.1.1
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       babel-jest: 28.1.2_@babel+core@7.18.6
       chalk: 4.1.2
       ci-info: 3.3.2
@@ -11648,11 +11361,11 @@ packages:
       pretty-format: 28.1.1
       slash: 3.0.0
       strip-json-comments: 3.1.1
-      ts-node: 10.8.2_2dd5d46eecda2aef953638919121af58
+      ts-node: 10.8.2_211a6a430b29f376d4b1cf9b4d9caf36
     transitivePeerDependencies:
       - supports-color

-  /jest-config/28.1.2_@types+node@18.0.3:
+  /jest-config/28.1.2_@types+node@16.18.126:
     resolution: {integrity: sha512-g6EfeRqddVbjPVBVY4JWpUY4IvQoFRIZcv4V36QkqzE0IGhEC/VkugFeBMAeUE7PRgC8KJF0yvJNDeQRbamEVA==}
     engines: {node: ^12.13.0 || ^14.15.0 || ^16.10.0 || >=17.0.0}
     peerDependencies:
@@ -11667,7 +11380,7 @@ packages:
       '@babel/core': 7.18.6
       '@jest/test-sequencer': 28.1.1
       '@jest/types': 28.1.1
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       babel-jest: 28.1.2_@babel+core@7.18.6
       chalk: 4.1.2
       ci-info: 3.3.2
@@ -11691,7 +11404,7 @@ packages:
       - supports-color
     dev: true

-  /jest-config/28.1.2_e1489a60da1bfeaddb37cf23d6a3b371:
+  /jest-config/28.1.2_@types+node@22.5.4:
     resolution: {integrity: sha512-g6EfeRqddVbjPVBVY4JWpUY4IvQoFRIZcv4V36QkqzE0IGhEC/VkugFeBMAeUE7PRgC8KJF0yvJNDeQRbamEVA==}
     engines: {node: ^12.13.0 || ^14.15.0 || ^16.10.0 || >=17.0.0}
     peerDependencies:
@@ -11706,7 +11419,7 @@ packages:
       '@babel/core': 7.18.6
       '@jest/test-sequencer': 28.1.1
       '@jest/types': 28.1.1
-      '@types/node': 18.19.31
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       babel-jest: 28.1.2_@babel+core@7.18.6
       chalk: 4.1.2
       ci-info: 3.3.2
@@ -11726,7 +11439,6 @@ packages:
       pretty-format: 28.1.1
       slash: 3.0.0
       strip-json-comments: 3.1.1
-      ts-node: 10.8.2_4ea55324100c26d4019c6e6bcc89fac6
     transitivePeerDependencies:
       - supports-color
     dev: true
@@ -11802,7 +11514,7 @@ packages:
       '@jest/environment': 28.1.2
       '@jest/fake-timers': 28.1.2
       '@jest/types': 28.1.1
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       jest-mock: 28.1.1
       jest-util: 28.1.1

@@ -11816,7 +11528,7 @@ packages:
     dependencies:
       '@jest/types': 28.1.1
       '@types/graceful-fs': 4.1.5
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       anymatch: 3.1.2
       fb-watchman: 2.0.1
       graceful-fs: 4.2.10
@@ -11826,7 +11538,7 @@ packages:
       micromatch: 4.0.5
       walker: 1.0.8
     optionalDependencies:
-      fsevents: 2.3.2
+      fsevents: registry.npmmirror.com/fsevents/2.3.2

   /jest-haste-map/28.1.3:
     resolution: {integrity: sha512-3S+RQWDXccXDKSWnkHa/dPwt+2qwA8CJzR61w3FoYCvoo3Pn8tvGcysmMF0Bj0EX5RYvAI2EIvC57OmotfdtKA==}
@@ -11844,7 +11556,7 @@ packages:
       micromatch: 4.0.5
       walker: 1.0.8
     optionalDependencies:
-      fsevents: 2.3.2
+      fsevents: registry.npmmirror.com/fsevents/2.3.2
     dev: true

   /jest-leak-detector/28.1.1:
@@ -11883,7 +11595,7 @@ packages:
       jest: ^24.0.0 || ^25.0.0 || ^26.0.0 || ^27.0.0 || ^28.0.0 || ^29.0.0
       typescript: ^3.0.0 || ^4.0.0 || ^5.0.0
     dependencies:
-      jest: 28.1.2_250642e41d506bccecc9f35ad915bcb5
+      jest: 28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862
       ts-essentials: 7.0.3_typescript@4.7.4
       typescript: 4.7.4
     dev: false
@@ -11893,7 +11605,7 @@ packages:
     engines: {node: ^12.13.0 || ^14.15.0 || ^16.10.0 || >=17.0.0}
     dependencies:
       '@jest/types': 28.1.1
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4

   /jest-pnp-resolver/1.2.2_jest-resolve@28.1.1:
     resolution: {integrity: sha512-olV41bKSMm8BdnuMsewT4jqlZ8+3TCARAXjZGT9jcoSnrfUnRCqnMoF9XEeoWjbzObpqF9dRhHQj0Xb9QdF6/w==}
@@ -11942,7 +11654,7 @@ packages:
       '@jest/test-result': 28.1.1
       '@jest/transform': 28.1.2
       '@jest/types': 28.1.1
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       chalk: 4.1.2
       emittery: 0.10.2
       graceful-fs: 4.2.10
@@ -12025,7 +11737,7 @@ packages:
     engines: {node: ^12.13.0 || ^14.15.0 || ^16.10.0 || >=17.0.0}
     dependencies:
       '@jest/types': 28.1.1
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       chalk: 4.1.2
       ci-info: 3.3.2
       graceful-fs: 4.2.10
@@ -12060,7 +11772,7 @@ packages:
     dependencies:
       '@jest/test-result': 28.1.1
       '@jest/types': 28.1.1
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       ansi-escapes: 4.3.2
       chalk: 4.1.2
       emittery: 0.10.2
@@ -12071,7 +11783,7 @@ packages:
     resolution: {integrity: sha512-Au7slXB08C6h+xbJPp7VIb6U0XX5Kc9uel/WFc6/rcTzGiaVCBRngBExSYuXSLFPULPSYU3cJ3ybS988lNFQhQ==}
     engines: {node: ^12.13.0 || ^14.15.0 || ^16.10.0 || >=17.0.0}
     dependencies:
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       merge-stream: 2.0.0
       supports-color: 8.1.1

@@ -12104,7 +11816,7 @@ packages:
       - ts-node
     dev: true

-  /jest/28.1.2_250642e41d506bccecc9f35ad915bcb5:
+  /jest/28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862:
     resolution: {integrity: sha512-Tuf05DwLeCh2cfWCQbcz9UxldoDyiR1E9Igaei5khjonKncYdc6LDfynKCEWozK0oLE3GD+xKAo2u8x/0s6GOg==}
     engines: {node: ^12.13.0 || ^14.15.0 || ^16.10.0 || >=17.0.0}
     hasBin: true
@@ -12117,13 +11829,13 @@ packages:
       '@jest/core': 28.1.2_ts-node@10.8.2
       '@jest/types': 28.1.1
       import-local: 3.1.0
-      jest-cli: 28.1.2_250642e41d506bccecc9f35ad915bcb5
+      jest-cli: 28.1.2_0c67f65b9315dd5e6f8dc2c52ac76862
     transitivePeerDependencies:
       - '@types/node'
       - supports-color
       - ts-node

-  /jest/28.1.2_@types+node@18.0.3:
+  /jest/28.1.2_@types+node@16.18.126:
     resolution: {integrity: sha512-Tuf05DwLeCh2cfWCQbcz9UxldoDyiR1E9Igaei5khjonKncYdc6LDfynKCEWozK0oLE3GD+xKAo2u8x/0s6GOg==}
     engines: {node: ^12.13.0 || ^14.15.0 || ^16.10.0 || >=17.0.0}
     hasBin: true
@@ -12136,27 +11848,7 @@ packages:
       '@jest/core': 28.1.2
       '@jest/types': 28.1.1
       import-local: 3.1.0
-      jest-cli: 28.1.2_@types+node@18.0.3
-    transitivePeerDependencies:
-      - '@types/node'
-      - supports-color
-      - ts-node
-    dev: true
-
-  /jest/28.1.2_e1489a60da1bfeaddb37cf23d6a3b371:
-    resolution: {integrity: sha512-Tuf05DwLeCh2cfWCQbcz9UxldoDyiR1E9Igaei5khjonKncYdc6LDfynKCEWozK0oLE3GD+xKAo2u8x/0s6GOg==}
-    engines: {node: ^12.13.0 || ^14.15.0 || ^16.10.0 || >=17.0.0}
-    hasBin: true
-    peerDependencies:
-      node-notifier: ^8.0.1 || ^9.0.0 || ^10.0.0
-    peerDependenciesMeta:
-      node-notifier:
-        optional: true
-    dependencies:
-      '@jest/core': 28.1.2_ts-node@10.8.2
-      '@jest/types': 28.1.1
-      import-local: 3.1.0
-      jest-cli: 28.1.2_e1489a60da1bfeaddb37cf23d6a3b371
+      jest-cli: 28.1.2_@types+node@16.18.126
     transitivePeerDependencies:
       - '@types/node'
       - supports-color
@@ -12280,7 +11972,7 @@ packages:
     dependencies:
       universalify: 2.0.0
     optionalDependencies:
-      graceful-fs: 4.2.10
+      graceful-fs: registry.npmmirror.com/graceful-fs/4.2.10
     dev: false

   /jsonwebtoken/9.0.2:
@@ -13087,19 +12779,6 @@ packages:
   /node-releases/2.0.5:
     resolution: {integrity: sha512-U9h1NLROZTq9uE1SNffn6WuPDg8icmi3ns4rEl/oTfIle4iLjTliCzgTsbaIFMq/Xn078/lfY/BL0GWZ+psK4Q==}

-  /nodejieba/2.5.2:
-    resolution: {integrity: sha512-ByskJvaBrQ2eV+5M0OeD80S5NKoGaHc9zi3Z/PTKl/95eac2YF8RmWduq9AknLpkQLrLAIcqurrtC6BzjpKwwg==}
-    engines: {node: '>= 10.20.0'}
-    requiresBuild: true
-    dependencies:
-      '@mapbox/node-pre-gyp': 1.0.11
-      node-addon-api: 3.2.1
-    transitivePeerDependencies:
-      - encoding
-      - supports-color
-    dev: false
-    optional: true
-
   /nopt/5.0.0:
     resolution: {integrity: sha512-Tbj67rffqceeLpcRXrT7vKAN8CwfPeIBgM7E6iBkmKLV7bEMwpGgYLGv0jACUsECaa/vuxP0IjEont6umdMgtQ==}
     engines: {node: '>=6'}
@@ -13667,7 +13346,7 @@ packages:
       commander: 1.1.1
       object-assign: 4.1.1
     optionalDependencies:
-      nodejieba: 2.5.2
+      nodejieba: registry.npmmirror.com/nodejieba/2.5.2
     transitivePeerDependencies:
       - encoding
       - supports-color
@@ -13782,7 +13461,7 @@ packages:
       '@protobufjs/pool': 1.1.0
       '@protobufjs/utf8': 1.1.0
       '@types/long': 4.0.2
-      '@types/node': 22.5.4
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       long: 4.0.0
     dev: false

@@ -13801,7 +13480,7 @@ packages:
       '@protobufjs/path': 1.1.2
       '@protobufjs/pool': 1.1.0
       '@protobufjs/utf8': 1.1.0
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/22.5.4
       long: 5.2.1
     dev: false

@@ -14917,7 +14596,7 @@ packages:
     dependencies:
       '@istanbuljs/schema': 0.1.3
       glob: 7.2.3
-      minimatch: 3.1.2
+      minimatch: registry.npmmirror.com/minimatch/3.1.2

   /text-hex/1.0.0:
     resolution: {integrity: sha512-uuVGNWzgJ4yhRaNSiubPY7OjISw4sw4E5Uv0wbjp+OzcbmVU/rsT8ujgcXJhn9ypzsgr5vlzpPqP+MBBKcGvbg==}
@@ -15057,7 +14736,7 @@ packages:
       typescript: 4.7.4
     dev: false

-  /ts-node/10.8.2_2dd5d46eecda2aef953638919121af58:
+  /ts-node/10.8.2_211a6a430b29f376d4b1cf9b4d9caf36:
     resolution: {integrity: sha512-LYdGnoGddf1D6v8REPtIH+5iq/gTDuZqv2/UJUU7tKjuEU8xVZorBM+buCGNjj+pGEud+sOoM4CX3/YzINpENA==}
     hasBin: true
     peerDependencies:
@@ -15076,7 +14755,7 @@ packages:
       '@tsconfig/node12': 1.0.11
       '@tsconfig/node14': 1.0.3
       '@tsconfig/node16': 1.0.3
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       acorn: 8.7.1
       acorn-walk: 8.2.0
       arg: 4.1.3
@@ -15087,7 +14766,7 @@ packages:
       v8-compile-cache-lib: 3.0.1
       yn: 3.1.1

-  /ts-node/10.8.2_2ee97d30e4a239eb38d57e3751ee8d16:
+  /ts-node/10.8.2_c1fa8f46d69d2806146bcf2350c141a0:
     resolution: {integrity: sha512-LYdGnoGddf1D6v8REPtIH+5iq/gTDuZqv2/UJUU7tKjuEU8xVZorBM+buCGNjj+pGEud+sOoM4CX3/YzINpENA==}
     hasBin: true
     peerDependencies:
@@ -15106,7 +14785,7 @@ packages:
       '@tsconfig/node12': 1.0.11
       '@tsconfig/node14': 1.0.3
       '@tsconfig/node16': 1.0.3
-      '@types/node': 18.0.3
+      '@types/node': registry.npmmirror.com/@types/node/16.18.126
       acorn: 8.7.1
       acorn-walk: 8.2.0
       arg: 4.1.3
@@ -15118,37 +14797,6 @@ packages:
       yn: 3.1.1
     dev: true

-  /ts-node/10.8.2_4ea55324100c26d4019c6e6bcc89fac6:
-    resolution: {integrity: sha512-LYdGnoGddf1D6v8REPtIH+5iq/gTDuZqv2/UJUU7tKjuEU8xVZorBM+buCGNjj+pGEud+sOoM4CX3/YzINpENA==}
-    hasBin: true
-    peerDependencies:
-      '@swc/core': '>=1.2.50'
-      '@swc/wasm': '>=1.2.50'
-      '@types/node': '*'
-      typescript: '>=2.7'
-    peerDependenciesMeta:
-      '@swc/core':
-        optional: true
-      '@swc/wasm':
-        optional: true
-    dependencies:
-      '@cspotcode/source-map-support': 0.8.1
-      '@tsconfig/node10': 1.0.9
-      '@tsconfig/node12': 1.0.11
-      '@tsconfig/node14': 1.0.3
-      '@tsconfig/node16': 1.0.3
-      '@types/node': 18.19.31
-      acorn: 8.7.1
-      acorn-walk: 8.2.0
-      arg: 4.1.3
-      create-require: 1.1.1
-      diff: 4.0.2
-      make-error: 1.3.6
-      typescript: 4.7.4
-      v8-compile-cache-lib: 3.0.1
-      yn: 3.1.1
-    dev: true
-
   /ts-node/10.8.2_typescript@4.7.4:
     resolution: {integrity: sha512-LYdGnoGddf1D6v8REPtIH+5iq/gTDuZqv2/UJUU7tKjuEU8xVZorBM+buCGNjj+pGEud+sOoM4CX3/YzINpENA==}
     hasBin: true
@@ -15295,14 +14943,6 @@ packages:
     resolution: {integrity: sha512-8Y75pvTYkLJW2hWQHXxoqRgV7qb9B+9vFEtidML+7koHUFapnVJAZ6cKs+Qjz5Aw3aZWHMC6u0wJE3At+nSGwA==}
     dev: false

-  /uglify-js/3.17.4:
-    resolution: {integrity: sha512-T9q82TJI9e/C1TAxYvfb16xO120tMVFZrGA3f9/P4424DNu6ypK103y0GPFVa17yotwSyZW5iYXgjYHkGrJW/g==}
-    engines: {node: '>=0.8.0'}
-    hasBin: true
-    requiresBuild: true
-    dev: false
-    optional: true
-
   /unbox-primitive/1.0.2:
     resolution: {integrity: sha512-61pPlCD9h51VoreyJ0BReideM3MDKMKnh6+V9L08331ipq6Q8OFXZYiqP6n/tbHx4s5I9uRhcye6BrbkizkBDw==}
     dependencies:
@@ -15859,3 +15499,417 @@ packages:
     resolution: {integrity: sha512-rVksvsnNCdJ/ohGc6xgPwyN8eheCxsiLM8mxuE/t/mOVqJewPuO1miLpTHQiRgTKCLexL4MeAFVagts7HmNZ2Q==}
     engines: {node: '>=10'}
     dev: false
+
+  registry.npmmirror.com/@bufbuild/buf-darwin-arm64/1.19.0-1:
+    resolution: {integrity: sha512-HsWPii21wm3QSyuxrNq9+Yf8iAgpnC4rNCy4x3d6P1fd/LmgE1NPzQW0ghEZvl9dgAQKkL/4S5bKhlm7kbUdmQ==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/@bufbuild/buf-darwin-arm64/-/buf-darwin-arm64-1.19.0-1.tgz}
+    name: '@bufbuild/buf-darwin-arm64'
+    version: 1.19.0-1
+    engines: {node: '>=12'}
+    cpu: [arm64]
+    os: [darwin]
+    requiresBuild: true
+    dev: false
+    optional: true
+
+  registry.npmmirror.com/@bufbuild/buf-darwin-x64/1.19.0-1:
+    resolution: {integrity: sha512-2+Ig7ylYpVh4kms/OeJJVY+X0KX4awPA6hYr7L7aZOIcHwZEM8lWtSTO/se5pQc7dc8FXNiC4YUqHC8yfxxX6Q==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/@bufbuild/buf-darwin-x64/-/buf-darwin-x64-1.19.0-1.tgz}
+    name: '@bufbuild/buf-darwin-x64'
+    version: 1.19.0-1
+    engines: {node: '>=12'}
+    cpu: [x64]
+    os: [darwin]
+    requiresBuild: true
+    dev: false
+    optional: true
+
+  registry.npmmirror.com/@bufbuild/buf-linux-aarch64/1.19.0-1:
+    resolution: {integrity: sha512-g/Vxg3WiBr3nhsxsRr2Q81xXJD+0ktHIO3ZJggTG2Sbbl3dh8kyg1iKM6MjJiMP7su5RKCylLigzoEJzVTShyA==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/@bufbuild/buf-linux-aarch64/-/buf-linux-aarch64-1.19.0-1.tgz}
+    name: '@bufbuild/buf-linux-aarch64'
+    version: 1.19.0-1
+    engines: {node: '>=12'}
+    cpu: [arm64]
+    os: [linux]
+    requiresBuild: true
+    dev: false
+    optional: true
+
+  registry.npmmirror.com/@bufbuild/buf-win32-arm64/1.19.0-1:
+    resolution: {integrity: sha512-xXgF1qYnCfRKbGx1FqvPbpZ6ajh4ddxpXhSxI3VCeb3MsMBuIbiLqX4fQAL3ls/Zwz8tVIITuSwOhYmSEGcpBA==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/@bufbuild/buf-win32-arm64/-/buf-win32-arm64-1.19.0-1.tgz}
+    name: '@bufbuild/buf-win32-arm64'
+    version: 1.19.0-1
+    engines: {node: '>=12'}
+    cpu: [arm64]
+    os: [win32]
+    requiresBuild: true
+    dev: false
+    optional: true
+
+  registry.npmmirror.com/@bufbuild/buf-win32-x64/1.19.0-1:
+    resolution: {integrity: sha512-futmqgpMQCR1lcAzZJEGjPr7ECw1gYTPIV8crm5SY+iCJ7sOeStOBNt7q5hV4LKmmeWmvm03XIMZPjhQzjH5NQ==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/@bufbuild/buf-win32-x64/-/buf-win32-x64-1.19.0-1.tgz}
+    name: '@bufbuild/buf-win32-x64'
+    version: 1.19.0-1
+    engines: {node: '>=12'}
+    cpu: [x64]
+    os: [win32]
+    requiresBuild: true
+    dev: false
+    optional: true
+
+  registry.npmmirror.com/@esbuild/android-arm/0.15.11:
+    resolution: {integrity: sha512-PzMcQLazLBkwDEkrNPi9AbjFt6+3I7HKbiYF2XtWQ7wItrHvEOeO3T8Am434zAozWtVP7lrTue1bEfc2nYWeCA==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/@esbuild/android-arm/-/android-arm-0.15.11.tgz}
+    name: '@esbuild/android-arm'
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [arm]
+    os: [android]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/@esbuild/linux-loong64/0.15.11:
+    resolution: {integrity: sha512-geWp637tUhNmhL3Xgy4Bj703yXB9dqiLJe05lCUfjSFDrQf9C/8pArusyPUbUbPwlC/EAUjBw32sxuIl/11dZw==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/@esbuild/linux-loong64/-/linux-loong64-0.15.11.tgz}
+    name: '@esbuild/linux-loong64'
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [loong64]
+    os: [linux]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/@google-cloud/firestore/7.9.0:
+    resolution: {integrity: sha512-c4ALHT3G08rV7Zwv8Z2KG63gZh66iKdhCBeDfCpIkLrjX6EAjTD/szMdj14M+FnQuClZLFfW5bAgoOjfNmLtJg==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/@google-cloud/firestore/-/firestore-7.9.0.tgz}
+    name: '@google-cloud/firestore'
+    version: 7.9.0
+    engines: {node: '>=14.0.0'}
+    requiresBuild: true
+    dependencies:
+      fast-deep-equal: 3.1.3
+      functional-red-black-tree: 1.0.1
+      google-gax: 4.4.1
+      protobufjs: 7.3.2
+    transitivePeerDependencies:
+      - encoding
+      - supports-color
+    dev: false
+    optional: true
+
+  registry.npmmirror.com/@google-cloud/storage/7.12.1:
+    resolution: {integrity: sha512-Z3ZzOnF3YKLuvpkvF+TjQ6lztxcAyTILp+FjKonmVpEwPa9vFvxpZjubLR4sB6bf19i/8HL2AXRjA0YFgHFRmQ==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/@google-cloud/storage/-/storage-7.12.1.tgz}
+    name: '@google-cloud/storage'
+    version: 7.12.1
+    engines: {node: '>=14'}
+    requiresBuild: true
+    dependencies:
+      '@google-cloud/paginator': 5.0.2
+      '@google-cloud/projectify': 4.0.0
+      '@google-cloud/promisify': 4.0.0
+      abort-controller: 3.0.0
+      async-retry: 1.3.3
+      duplexify: 4.1.3
+      fast-xml-parser: 4.5.0
+      gaxios: 6.7.1
+      google-auth-library: 9.14.1
+      html-entities: 2.5.2
+      mime: 3.0.0
+      p-limit: 3.1.0
+      retry-request: 7.0.2
+      teeny-request: 9.0.0
+      uuid: 8.3.2
+    transitivePeerDependencies:
+      - encoding
+      - supports-color
+    dev: false
+    optional: true
+
+  registry.npmmirror.com/@types/node/10.12.18:
+    resolution: {integrity: sha512-fh+pAqt4xRzPfqA6eh3Z2y6fyZavRIumvjhaCL753+TVkGKGhpPeyrJG2JftD0T9q4GF00KjefsQ+PQNDdWQaQ==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/@types/node/-/node-10.12.18.tgz}
+    name: '@types/node'
+    version: 10.12.18
+    dev: false
+
+  registry.npmmirror.com/@types/node/16.18.126:
+    resolution: {integrity: sha512-OTcgaiwfGFBKacvfwuHzzn1KLxH/er8mluiy8/uM3sGXHaRe73RrSIj01jow9t4kJEW633Ov+cOexXeiApTyAw==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/@types/node/-/node-16.18.126.tgz}
+    name: '@types/node'
+    version: 16.18.126
+
+  registry.npmmirror.com/@types/node/22.5.4:
+    resolution: {integrity: sha512-FDuKUJQm/ju9fT/SeX/6+gBzoPzlVCzfzmGkwKvRHQVxi4BntVbyIwf6a4Xn62mrvndLiml6z/UBXIdEVjQLXg==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/@types/node/-/node-22.5.4.tgz}
+    name: '@types/node'
+    version: 22.5.4
+    dependencies:
+      undici-types: registry.npmmirror.com/undici-types/6.19.8
+
+  registry.npmmirror.com/esbuild-android-64/0.15.11:
+    resolution: {integrity: sha512-rrwoXEiuI1kaw4k475NJpexs8GfJqQUKcD08VR8sKHmuW9RUuTR2VxcupVvHdiGh9ihxL9m3lpqB1kju92Ialw==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-android-64/-/esbuild-android-64-0.15.11.tgz}
+    name: esbuild-android-64
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [x64]
+    os: [android]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-android-arm64/0.15.11:
+    resolution: {integrity: sha512-/hDubOg7BHOhUUsT8KUIU7GfZm5bihqssvqK5PfO4apag7YuObZRZSzViyEKcFn2tPeHx7RKbSBXvAopSHDZJQ==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-android-arm64/-/esbuild-android-arm64-0.15.11.tgz}
+    name: esbuild-android-arm64
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [arm64]
+    os: [android]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-darwin-64/0.15.11:
+    resolution: {integrity: sha512-1DqHD0ms3AhiwkKnjRUzmiW7JnaJJr5FKrPiR7xuyMwnjDqvNWDdMq4rKSD9OC0piFNK6n0LghsglNMe2MwJtA==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-darwin-64/-/esbuild-darwin-64-0.15.11.tgz}
+    name: esbuild-darwin-64
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [x64]
+    os: [darwin]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-darwin-arm64/0.15.11:
+    resolution: {integrity: sha512-OMzhxSbS0lwwrW40HHjRCeVIJTURdXFA8c3GU30MlHKuPCcvWNUIKVucVBtNpJySXmbkQMDJdJNrXzNDyvoqvQ==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-darwin-arm64/-/esbuild-darwin-arm64-0.15.11.tgz}
+    name: esbuild-darwin-arm64
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [arm64]
+    os: [darwin]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-freebsd-64/0.15.11:
+    resolution: {integrity: sha512-8dKP26r0/Qyez8nTCwpq60QbuYKOeBygdgOAWGCRalunyeqWRoSZj9TQjPDnTTI9joxd3QYw3UhVZTKxO9QdRg==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-freebsd-64/-/esbuild-freebsd-64-0.15.11.tgz}
+    name: esbuild-freebsd-64
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [x64]
+    os: [freebsd]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-freebsd-arm64/0.15.11:
+    resolution: {integrity: sha512-aSGiODiukLGGnSg/O9+cGO2QxEacrdCtCawehkWYTt5VX1ni2b9KoxpHCT9h9Y6wGqNHmXFnB47RRJ8BIqZgmQ==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-freebsd-arm64/-/esbuild-freebsd-arm64-0.15.11.tgz}
+    name: esbuild-freebsd-arm64
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [arm64]
+    os: [freebsd]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-linux-32/0.15.11:
+    resolution: {integrity: sha512-lsrAfdyJBGx+6aHIQmgqUonEzKYeBnyfJPkT6N2dOf1RoXYYV1BkWB6G02tjsrz1d5wZzaTc3cF+TKmuTo/ZwA==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-linux-32/-/esbuild-linux-32-0.15.11.tgz}
+    name: esbuild-linux-32
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [ia32]
+    os: [linux]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-linux-64/0.15.11:
+    resolution: {integrity: sha512-Y2Rh+PcyVhQqXKBTacPCltINN3uIw2xC+dsvLANJ1SpK5NJUtxv8+rqWpjmBgaNWKQT1/uGpMmA9olALy9PLVA==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-linux-64/-/esbuild-linux-64-0.15.11.tgz}
+    name: esbuild-linux-64
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [x64]
+    os: [linux]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-linux-arm/0.15.11:
+    resolution: {integrity: sha512-TJllTVk5aSyqPFvvcHTvf6Wu1ZKhWpJ/qNmZO8LL/XeB+LXCclm7HQHNEIz6MT7IX8PmlC1BZYrOiw2sXSB95A==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-linux-arm/-/esbuild-linux-arm-0.15.11.tgz}
+    name: esbuild-linux-arm
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [arm]
+    os: [linux]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-linux-arm64/0.15.11:
+    resolution: {integrity: sha512-uhcXiTwTmD4OpxJu3xC5TzAAw6Wzf9O1XGWL448EE9bqGjgV1j+oK3lIHAfsHnuIn8K4nDW8yjX0Sv5S++oRuw==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-linux-arm64/-/esbuild-linux-arm64-0.15.11.tgz}
+    name: esbuild-linux-arm64
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [arm64]
+    os: [linux]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-linux-mips64le/0.15.11:
+    resolution: {integrity: sha512-WD61y/R1M4BLe4gxXRypoQ0Ci+Vjf714QYzcPNkiYv5I8K8WDz2ZR8Bm6cqKxd6rD+e/rZgPDbhQ9PCf7TMHmA==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-linux-mips64le/-/esbuild-linux-mips64le-0.15.11.tgz}
+    name: esbuild-linux-mips64le
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [mips64el]
+    os: [linux]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-linux-ppc64le/0.15.11:
+    resolution: {integrity: sha512-JVleZS9oPVLTlBhPTWgOwxFWU/wMUdlBwTbGA4GF8c38sLbS13cupj+C8bLq929jU7EMWry4SaL+tKGIaTlqKg==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-linux-ppc64le/-/esbuild-linux-ppc64le-0.15.11.tgz}
+    name: esbuild-linux-ppc64le
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [ppc64]
+    os: [linux]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-linux-riscv64/0.15.11:
+    resolution: {integrity: sha512-9aLIalZ2HFHIOZpmVU11sEAS9F8TnHw49daEjcgMpBXHFF57VuT9f9/9LKJhw781Gda0P9jDkuCWJ0tFbErvJw==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-linux-riscv64/-/esbuild-linux-riscv64-0.15.11.tgz}
+    name: esbuild-linux-riscv64
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [riscv64]
+    os: [linux]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-linux-s390x/0.15.11:
+    resolution: {integrity: sha512-sZHtiXXOKsLI3XGBGoYO4qKBzJlb8xNsWmvFiwFMHFzA4AXgDP1KDp7Dawe9C2pavTRBDvl+Ok4n/DHQ59oaTg==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-linux-s390x/-/esbuild-linux-s390x-0.15.11.tgz}
+    name: esbuild-linux-s390x
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [s390x]
+    os: [linux]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-netbsd-64/0.15.11:
+    resolution: {integrity: sha512-hUC9yN06K9sg7ju4Vgu9ChAPdsEgtcrcLfyNT5IKwKyfpLvKUwCMZSdF+gRD3WpyZelgTQfJ+pDx5XFbXTlB0A==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-netbsd-64/-/esbuild-netbsd-64-0.15.11.tgz}
+    name: esbuild-netbsd-64
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [x64]
+    os: [netbsd]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-openbsd-64/0.15.11:
+    resolution: {integrity: sha512-0bBo9SQR4t66Wd91LGMAqmWorzO0TTzVjYiifwoFtel8luFeXuPThQnEm5ztN4g0fnvcp7AnUPPzS/Depf17wQ==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-openbsd-64/-/esbuild-openbsd-64-0.15.11.tgz}
+    name: esbuild-openbsd-64
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [x64]
+    os: [openbsd]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-sunos-64/0.15.11:
+    resolution: {integrity: sha512-EuBdTGlsMTjEl1sQnBX2jfygy7iR6CKfvOzi+gEOfhDqbHXsmY1dcpbVtcwHAg9/2yUZSfMJHMAgf1z8M4yyyw==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-sunos-64/-/esbuild-sunos-64-0.15.11.tgz}
+    name: esbuild-sunos-64
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [x64]
+    os: [sunos]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-windows-32/0.15.11:
+    resolution: {integrity: sha512-O0/Wo1Wk6dc0rZSxkvGpmTNIycEznHmkObTFz2VHBhjPsO4ZpCgfGxNkCpz4AdAIeMczpTXt/8d5vdJNKEGC+Q==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-windows-32/-/esbuild-windows-32-0.15.11.tgz}
+    name: esbuild-windows-32
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [ia32]
+    os: [win32]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-windows-64/0.15.11:
+    resolution: {integrity: sha512-x977Q4HhNjnHx00b4XLAnTtj5vfbdEvkxaQwC1Zh5AN8g5EX+izgZ6e5QgqJgpzyRNJqh4hkgIJF1pyy1be0mQ==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-windows-64/-/esbuild-windows-64-0.15.11.tgz}
+    name: esbuild-windows-64
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [x64]
+    os: [win32]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/esbuild-windows-arm64/0.15.11:
+    resolution: {integrity: sha512-VwUHFACuBahrvntdcMKZteUZ9HaYrBRODoKe4tIWxguQRvvYoYb7iu5LrcRS/FQx8KPZNaa72zuqwVtHeXsITw==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/esbuild-windows-arm64/-/esbuild-windows-arm64-0.15.11.tgz}
+    name: esbuild-windows-arm64
+    version: 0.15.11
+    engines: {node: '>=12'}
+    cpu: [arm64]
+    os: [win32]
+    requiresBuild: true
+    dev: true
+    optional: true
+
+  registry.npmmirror.com/fsevents/2.3.2:
+    resolution: {integrity: sha512-xiqMQR4xAeHTuB9uWm+fFRcIOgKBMiOBP+eXiyT7jsgVCq1bkVygt00oASowB7EdtpOHaaPgKt812P9ab+DDKA==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/fsevents/-/fsevents-2.3.2.tgz}
+    name: fsevents
+    version: 2.3.2
+    engines: {node: ^8.16.0 || ^10.6.0 || >=11.0.0}
+    os: [darwin]
+    requiresBuild: true
+    optional: true
+
+  registry.npmmirror.com/graceful-fs/4.2.10:
+    resolution: {integrity: sha512-9ByhssR2fPVsNZj478qUUbKfmL0+t5BDVyjShtyZZLiK7ZDAArFFfopyOTj0M05wE2tJPisA4iTnnXl2YoPvOA==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/graceful-fs/-/graceful-fs-4.2.10.tgz}
+    name: graceful-fs
+    version: 4.2.10
+    requiresBuild: true
+    dev: false
+    optional: true
+
+  registry.npmmirror.com/minimatch/3.1.2:
+    resolution: {integrity: sha512-J7p63hRiAjw1NDEww1W7i37+ByIrOWO5XQQAzZ3VOcL0PNybwpfmV/N05zFAzwQ9USyEcX6t3UO+K5aqBQOIHw==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/minimatch/-/minimatch-3.1.2.tgz}
+    name: minimatch
+    version: 3.1.2
+    dependencies:
+      brace-expansion: 1.1.11
+
+  registry.npmmirror.com/nodejieba/2.5.2:
+    resolution: {integrity: sha512-ByskJvaBrQ2eV+5M0OeD80S5NKoGaHc9zi3Z/PTKl/95eac2YF8RmWduq9AknLpkQLrLAIcqurrtC6BzjpKwwg==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/nodejieba/-/nodejieba-2.5.2.tgz}
+    name: nodejieba
+    version: 2.5.2
+    engines: {node: '>= 10.20.0'}
+    requiresBuild: true
+    dependencies:
+      '@mapbox/node-pre-gyp': 1.0.11
+      node-addon-api: 3.2.1
+    transitivePeerDependencies:
+      - encoding
+      - supports-color
+    dev: false
+    optional: true
+
+  registry.npmmirror.com/uglify-js/3.17.4:
+    resolution: {integrity: sha512-T9q82TJI9e/C1TAxYvfb16xO120tMVFZrGA3f9/P4424DNu6ypK103y0GPFVa17yotwSyZW5iYXgjYHkGrJW/g==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/uglify-js/-/uglify-js-3.17.4.tgz}
+    name: uglify-js
+    version: 3.17.4
+    engines: {node: '>=0.8.0'}
+    hasBin: true
+    requiresBuild: true
+    dev: false
+    optional: true
+
+  registry.npmmirror.com/undici-types/6.19.8:
+    resolution: {integrity: sha512-ve2KP6f/JnbPBFyobGHuerC9g1FYGn/F8n1LWTwNxCEzd6IfqTwUQcNXgEtmmQ6DlRrC1hrSrBnCZPokRrDHjw==, registry: http://registry.npm.taobao.org/, tarball: https://registry.npmmirror.com/undici-types/-/undici-types-6.19.8.tgz}
+    name: undici-types
+    version: 6.19.8
diff --git a/indexer/services/auxo/package.json b/indexer/services/auxo/package.json
index e01ed6869..eeb06318e 100644
--- a/indexer/services/auxo/package.json
+++ b/indexer/services/auxo/package.json
@@ -33,7 +33,7 @@
     "@types/aws-lambda": "^8.10.108",
     "@types/jest": "^28.1.4",
     "@types/lodash": "^4.14.182",
-    "@types/node": "^18.0.3",
+    "@types/node": "^16.18.0",
     "@types/redis": "2.8.27",
     "esbuild": "^0.15.11",
     "jest": "^28.1.2",
diff --git a/indexer/services/bazooka/package.json b/indexer/services/bazooka/package.json
index d0ba6ce6d..5310ac2c3 100644
--- a/indexer/services/bazooka/package.json
+++ b/indexer/services/bazooka/package.json
@@ -37,7 +37,7 @@
     "@types/aws-lambda": "^8.10.108",
     "@types/jest": "^28.1.4",
     "@types/lodash": "^4.14.182",
-    "@types/node": "^18.0.3",
+    "@types/node": "^16.18.0",
     "@types/redis": "2.8.27",
     "esbuild": "^0.15.11",
     "jest": "^28.1.2",
diff --git a/indexer/services/comlink/package.json b/indexer/services/comlink/package.json
index 388297ddc..5e7db5cd5 100644
--- a/indexer/services/comlink/package.json
+++ b/indexer/services/comlink/package.json
@@ -66,7 +66,7 @@
     "@types/jest": "^28.1.4",
     "@types/lodash": "^4.14.182",
     "@types/luxon": "^3.0.0",
-    "@types/node": "^18.0.3",
+    "@types/node": "^16.18.0",
     "@types/redis": "2.8.27",
     "@types/response-time": "^2.3.5",
     "@types/supertest": "^2.0.12",
diff --git a/indexer/services/ender/package.json b/indexer/services/ender/package.json
index 198bb11c7..f4ac57696 100644
--- a/indexer/services/ender/package.json
+++ b/indexer/services/ender/package.json
@@ -42,7 +42,7 @@
     "@types/jest": "^28.1.4",
     "@types/lodash": "^4.14.182",
     "@types/luxon": "^3.0.0",
-    "@types/node": "^18.0.3",
+    "@types/node": "^16.18.0",
     "@types/pg": "^8.6.5",
     "jest": "^28.1.2",
     "ts-node": "^10.8.2",
diff --git a/indexer/services/example-service/package.json b/indexer/services/example-service/package.json
index 4f352c49e..830360e5c 100644
--- a/indexer/services/example-service/package.json
+++ b/indexer/services/example-service/package.json
@@ -22,7 +22,7 @@
   "devDependencies": {
     "@dydxprotocol-indexer/dev": "workspace:^0.0.1",
     "@types/jest": "^28.1.4",
-    "@types/node": "^18.0.3",
+    "@types/node": "^16.18.0",
     "jest": "^28.1.2",
     "ts-node": "^10.8.2",
     "tsconfig-paths": "^4.0.0",
diff --git a/indexer/services/roundtable/package.json b/indexer/services/roundtable/package.json
index bd4783fba..bfcdc22a3 100644
--- a/indexer/services/roundtable/package.json
+++ b/indexer/services/roundtable/package.json
@@ -43,7 +43,7 @@
     "@types/jest": "^28.1.4",
     "@types/lodash": "^4.14.182",
     "@types/luxon": "^3.0.0",
-    "@types/node": "^18.0.3",
+    "@types/node": "^16.18.0",
     "@types/redis": "2.8.27",
     "@types/seedrandom": "^3.0.8",
     "@types/uuid": "^8.3.4",
diff --git a/indexer/services/scripts/package.json b/indexer/services/scripts/package.json
index b491e2142..8ef4b3b76 100644
--- a/indexer/services/scripts/package.json
+++ b/indexer/services/scripts/package.json
@@ -36,7 +36,7 @@
   "devDependencies": {
     "@dydxprotocol-indexer/dev": "workspace:^0.0.1",
     "@types/jest": "^28.1.4",
-    "@types/node": "^18.0.3",
+    "@types/node": "^16.18.0",
     "jest": "^28.1.2",
     "ts-node": "^10.8.2",
     "tsconfig-paths": "^4.0.0",
diff --git a/indexer/services/socks/package.json b/indexer/services/socks/package.json
index 28791125e..baa689ee4 100644
--- a/indexer/services/socks/package.json
+++ b/indexer/services/socks/package.json
@@ -47,7 +47,7 @@
     "@types/express-request-id": "^1.4.3",
     "@types/jest": "^28.1.4",
     "@types/lodash": "^4.14.182",
-    "@types/node": "^18.19.31",
+    "@types/node": "^16.18.0",
     "@types/response-time": "^2.3.5",
     "@types/ws": "^8.5.10",
     "jest": "^28.1.2",
@@ -63,4 +63,4 @@
     "url": "https://github.com/dydxprotocol/indexer/issues"
   },
   "homepage": "https://github.com/dydxprotocol/indexer#readme"
-}
+}
\ No newline at end of file
diff --git a/indexer/services/socks/src/helpers/wss.ts b/indexer/services/socks/src/helpers/wss.ts
index 1f316af17..dbab254c9 100644
--- a/indexer/services/socks/src/helpers/wss.ts
+++ b/indexer/services/socks/src/helpers/wss.ts
@@ -54,8 +54,6 @@ export class Wss {

     const serverOptions: WebSocket.ServerOptions = {
       port: config.WS_PORT,
-      allowSynchronousEvents: true,
-      autoPong: true,
     };
     this.wss = new WebSocket.Server(serverOptions);
   }
diff --git a/indexer/services/vulcan/package.json b/indexer/services/vulcan/package.json
index 0d365ea8c..54dd38b1c 100644
--- a/indexer/services/vulcan/package.json
+++ b/indexer/services/vulcan/package.json
@@ -38,7 +38,7 @@
     "@types/big.js": "^6.1.5",
     "@types/jest": "^28.1.4",
     "@types/luxon": "3.0.0",
-    "@types/node": "^18.0.3",
+    "@types/node": "^16.18.0",
     "@types/redis": "2.8.27",
     "jest": "^28.1.2",
     "ts-node": "^10.8.2",
```


docker-compose-local-deployment.yml
```
version: '3'
services:
  kafka:
    image: blacktop/kafka:2.6
    ports:
      - 9092:9092
    environment:
      KAFKA_ADVERTISED_HOST_NAME: kafka
      KAFKA_CREATE_TOPICS: "to-ender:1:1,to-vulcan:1:1,to-websockets-orderbooks:1:1,to-websockets-subaccounts:1:1,to-websockets-trades:1:1,to-websockets-markets:1:1,to-websockets-candles:1:1,to-websockets-block-height:1:1"
      KAFKA_LISTENERS: INTERNAL://:9092,EXTERNAL_SAME_HOST://:29092
      KAFKA_ADVERTISED_LISTENERS: INTERNAL://kafka:9092,EXTERNAL_SAME_HOST://localhost:29092
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: INTERNAL:PLAINTEXT,EXTERNAL_SAME_HOST:PLAINTEXT
      KAFKA_INTER_BROKER_LISTENER_NAME: INTERNAL
      DD_AGENT_HOST: datadog-agent
    healthcheck:
      test: [ "CMD-SHELL", "kafka-topics.sh --bootstrap-server 127.0.0.1:9092 --topic to-websockets-candles --describe" ]
      interval: 5s
      timeout: 20s
      retries: 50
    labels:
      com.datadoghq.ad.logs: '[{"source": "indexer", "service": "kafka"}]'
  postgres:
    build:
      context: .
      dockerfile: Dockerfile.postgres.local
    ports:
      - 5435:5432
    environment:
      POSTGRES_PASSWORD: dydxserver123
      POSTGRES_USER: dydx_dev
      DATADOG_POSTGRES_PASSWORD: dydxserver123
    healthcheck:
      test: [ "CMD-SHELL", "pg_isready -U dydx_dev" ]
      interval: 5s
      timeout: 20s
      retries: 10
    labels:
      com.datadoghq.ad.logs: '[{"source": "indexer", "service": "postgres"}]'
      com.datadoghq.ad.check_names: '["postgres"]'
      com.datadoghq.ad.init_configs: '[{}]'
      com.datadoghq.ad.instances: '[{"host":"%%host%%", "port":5432,"username":"datadog","password":"dydxserver123"}]'
  redis:
    image: redis:5.0.6-alpine
    ports:
      - 6382:6379
    labels:
      com.datadoghq.ad.logs: '[{"source": "indexer", "service": "redis"}]'
      com.datadoghq.ad.check_names: '["redisdb"]'
      com.datadoghq.ad.init_configs: '[{}]'
      com.datadoghq.ad.instances: '[{"host": "%%host%%","port":"6379","password":"%%env_REDIS_PASSWORD%%"}]'
  datadog-agent:
    build: datadog
    links:
      - redis
      - vulcan
      - comlink
      - ender
    environment:
      - DD_API_KEY=${DD_API_KEY}
      - DD_LOGS_ENABLED=true
      - DD_TAGS="service:local-indexer dev:${USER}"
      - DD_APM_ENABLED=true
      - DD_APM_NON_LOCAL_TRAFFIC=true
      - DD_DOGSTATSD_NON_LOCAL_TRAFFIC=true
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /proc/:/host/proc/:ro
      - /sys/fs/cgroup:/host/sys/fs/cgroup:ro
      - /var/lib/docker/containers:/var/lib/docker/containers:ro
    profiles: [ "export-to-datadog" ]
  postgres-package:
    build:
      context: .
      dockerfile: Dockerfile.postgres-package.local
    links:
      - postgres
    depends_on:
      postgres:
        condition: service_healthy
  ender:
    build:
      context: .
      dockerfile: Dockerfile.service.local
      args:
        service: ender
    ports:
      - 3001:3001
    links:
      - postgres
    environment:
      # See https://docs.datadoghq.com/profiler/enabling/nodejs/ for DD_ specific environment variables.
      # Note that DD_SERVICE and DD_VERSION are read by default from package.json
      - DD_PROFILING_ENABLED=true
      - DD_ENV=localnet_${USER}
      - DD_AGENT_HOST=datadog-agent
      - REDIS_URL=redis://redis:6379
      - DB_HOSTNAME=postgres
      - DB_PORT=5432
      - DB_NAME=dydx_dev
      - DB_USERNAME=dydx_dev
      - DB_PASSWORD=dydxserver123
    labels:
      com.datadoghq.ad.logs: '[{"source": "indexer", "service": "ender"}]'
    depends_on:
      kafka:
        condition: service_healthy
      postgres-package:
        condition: service_completed_successfully
  comlink:
    build:
      context: .
      dockerfile: Dockerfile.service.local
      args:
        service: comlink
    environment:
      # See https://docs.datadoghq.com/profiler/enabling/nodejs/ for DD_ specific environment variables.
      # Note that DD_SERVICE and DD_VERSION are read by default from package.json
      - DD_PROFILING_ENABLED=true
      - DD_ENV=localnet_${USER}
      - DD_AGENT_HOST=datadog-agent
      - REDIS_URL=redis://redis:6379
      - RATE_LIMIT_REDIS_URL=redis://redis:6379
      - PORT=3002
      - RATE_LIMIT_ENABLED=false
      - INDEXER_LEVEL_GEOBLOCKING_ENABLED=false
      - COMPLIANCE_DATA_CLIENT=PLACEHOLDER
      - DB_HOSTNAME=postgres
      - DB_PORT=5432
      - DB_NAME=dydx_dev
      - DB_USERNAME=dydx_dev
      - DB_PASSWORD=dydxserver123
    labels:
      com.datadoghq.ad.logs: '[{"source": "indexer", "service": "comlink"}]'
    ports:
      - 3002:3002
    links:
      - postgres
    depends_on:
      postgres-package:
        condition: service_completed_successfully
  socks:
    build:
      context: .
      dockerfile: Dockerfile.service.local
      args:
        service: socks
    ports:
      - 3003:3003
    links:
      - postgres
    environment:
      - WS_PORT=3003
      # See https://docs.datadoghq.com/profiler/enabling/nodejs/ for DD_ specific environment variables.
      # Note that DD_SERVICE and DD_VERSION are read by default from package.json
      - DD_PROFILING_ENABLED=true
      - DD_ENV=localnet_${USER}
      - DD_AGENT_HOST=datadog-agent
      - COMLINK_URL=host.docker.internal:3002
    labels:
      com.datadoghq.ad.logs: '[{"source": "indexer", "service": "socks"}]'
    depends_on:
      kafka:
        condition: service_healthy
      postgres-package:
        condition: service_completed_successfully
  roundtable:
    build:
      context: .
      dockerfile: Dockerfile.service.local
      args:
        service: roundtable
    ports:
      - 3004:3004
    links:
      - postgres
    environment:
      # See https://docs.datadoghq.com/profiler/enabling/nodejs/ for DD_ specific environment variables.
      # Note that DD_SERVICE and DD_VERSION are read by default from package.json
      - DD_PROFILING_ENABLED=true
      - DD_ENV=localnet_${USER}
      - DD_AGENT_HOST=datadog-agent
      - KAFKA_BROKER_URLS=kafka:9092
      - AWS_REGION=us-east-1
      - AWS_ACCOUNT_ID=123456789012
      - S3_BUCKET_ARN=arn:aws:s3:::local-dev-bucket
      - ECS_TASK_ROLE_ARN=arn:aws:iam::123456789012:role/local-dev-role
      - KMS_KEY_ARN=arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012
      - RDS_INSTANCE_NAME=local-dev-rds
      - DB_HOSTNAME=postgres
      - DB_PORT=5432
      - DB_NAME=dydx_dev
      - DB_USERNAME=dydx_dev
      - DB_PASSWORD=dydxserver123
    labels:
      com.datadoghq.ad.logs: '[{"source": "indexer", "service": "roundtable"}]'
    depends_on:
      kafka:
        condition: service_healthy
      postgres-package:
        condition: service_completed_successfully
  vulcan:
    build:
      context: .
      dockerfile: Dockerfile.service.local
      args:
        service: vulcan
    environment:
      # See https://docs.datadoghq.com/profiler/enabling/nodejs/ for DD_ specific environment variables.
      # Note that DD_SERVICE and DD_VERSION are read by default from package.json
      - DD_PROFILING_ENABLED=true
      - DD_ENV=localnet_${USER}
      - DD_AGENT_HOST=datadog-agent
      - KAFKA_BROKER_URLS=kafka:9092
      - REDIS_URL=redis://redis:6379
      - DB_HOSTNAME=postgres
      - DB_READONLY_HOSTNAME=postgres
      - IS_USING_DB_READONLY=true
      - DB_PORT=5432
      - DB_NAME=dydx_dev
      - DB_USERNAME=dydx_dev
      - DB_PASSWORD=dydxserver123
    labels:
      com.datadoghq.ad.logs: '[{"source": "indexer", "service": "vulcan"}]'
    ports:
      - 3005:3005
    links:
      - postgres
      - redis
    depends_on:
      kafka:
        condition: service_healthy
      postgres-package:
        condition: service_completed_successfully

```

start command
```
cd /root/single-node-deployment
./setup-single-node.sh
/root/src/trade/v4-chain/protocol/build/dydxprotocold start --home /root/single-node-deployment/.dydxprotocol \
    --bridge-daemon-enabled=false \
    --liquidation-daemon-enabled=false \
    --price-daemon-enabled=false \
    --bridge-daemon-eth-rpc-endpoint "https://eth-sepolia.g.alchemy.com/v2/demo" \
    --oracle.enabled=false
```
