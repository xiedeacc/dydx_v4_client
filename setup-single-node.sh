#!/bin/bash
set -e

# Single Node dYdX V4 Setup Script
echo "Setting up single dYdX V4 node..."

# Configuration
CHAIN_ID="dydxprotocol-single"
MONIKER="validator-single"
HOME_DIR="$HOME/single-node-deployment/.dydxprotocol"
CONFIG_DIR="$HOME_DIR/config"
BINARY_PATH="/root/src/trade/v4-chain/protocol/build/dydxprotocold"

# Validator details (using alice from local testnet)
MNEMONIC="merge panther lobster crazy road hollow amused security before critic about cliff exhibit cause coyote talent happy where lion river tobacco option coconut small"
NODE_KEY="8EGQBxfGMcRfH0C45UTedEG5Xi3XAcukuInLUqFPpskjp1Ny0c5XvwlKevAwtVvkwoeYYQSe0geQG/cF3GAcUA=="

# Test accounts
TEST_ACCOUNTS=(
	"dydx199tqg4wdlnu4qjlxchpd7seg454937hjrknju4" # alice
	"dydx10fx7sy6ywd5senxae9dwytf8jxek3t2gcen2vs" # bob
	"dydx1fjg6zp6vv8t9wvy4lps03r5l4g7tkjw9wvmh70" # carl
	"dydx1wau5mja7j7zdavtfq9lu7ejef05hm6ffenlcsn" # dave
)

FAUCET_ACCOUNTS=(
	"dydx1nzuttarf5k2j0nug5yzhr6p74t9avehn9hlh8m" # main faucet
)

# Token denominations
USDC_DENOM="ibc/8E27BA2D5493AF5636760E354E46004562C46AB7EC0CC4C1CA14E9E20E2545B5"
NATIVE_TOKEN="adv4tnt"
TESTNET_VALIDATOR_NATIVE_TOKEN_BALANCE="10000000000000000000000000000"
TESTNET_VALIDATOR_SELF_DELEGATE_AMOUNT="1000000000000000000000"

# Clean up any existing setup
echo "Cleaning up existing setup..."
rm -rf "$HOME_DIR"

# Install prerequisites if needed
echo "Installing prerequisites..."
which jq > /dev/null || (echo "Installing jq..." && apt-get update && apt-get install -y jq)
which dasel > /dev/null || (echo "Installing dasel..." && curl -sSL https://github.com/TomWright/dasel/releases/latest/download/dasel_linux_amd64 -o /usr/local/bin/dasel && chmod +x /usr/local/bin/dasel)

# Initialize the chain
echo "Initializing chain..."
$BINARY_PATH init "$MONIKER" --chain-id="$CHAIN_ID" --home "$HOME_DIR"

# Set up validator key from mnemonic
echo "Setting up validator key..."
echo "$MNEMONIC" | $BINARY_PATH keys add "$MONIKER" --recover --keyring-backend=test --home "$HOME_DIR"

# Generate deterministic priv_validator_key from mnemonic
echo "Generating validator keys..."
$BINARY_PATH tendermint gen-priv-key --home "$HOME_DIR" --mnemonic "$MNEMONIC"

# Set deterministic node key
echo "Setting node key..."
jq ".priv_key.value = \"$NODE_KEY\"" "$CONFIG_DIR/node_key.json" > "$CONFIG_DIR/node_key.json.tmp"
mv "$CONFIG_DIR/node_key.json.tmp" "$CONFIG_DIR/node_key.json"

# Configure the node
echo "Configuring node..."
# Disable pex and set consensus timeout
dasel put -t bool -f "$CONFIG_DIR/config.toml" '.p2p.pex' -v 'false'
dasel put -t string -f "$CONFIG_DIR/config.toml" '.consensus.timeout_commit' -v '3s'

# Configure app settings (disable oracle/slinky for single node)
dasel put -t bool -f "$CONFIG_DIR/app.toml" 'oracle.enabled' -v false
dasel put -t string -f "$CONFIG_DIR/app.toml" 'oracle.oracle_address' -v 'localhost:8080'
dasel put -t bool -f "$CONFIG_DIR/app.toml" 'oracle.metrics_enabled' -v false
dasel put -t string -f "$CONFIG_DIR/app.toml" 'oracle.prometheus_server_address' -v 'localhost:8001'

# Add genesis accounts
echo "Adding genesis accounts..."
for acct in "${TEST_ACCOUNTS[@]}"; do
	$BINARY_PATH add-genesis-account "$acct" "100000000000000000$USDC_DENOM,$TESTNET_VALIDATOR_NATIVE_TOKEN_BALANCE$NATIVE_TOKEN" --home "$HOME_DIR"
done

for acct in "${FAUCET_ACCOUNTS[@]}"; do
	$BINARY_PATH add-genesis-account "$acct" "900000000000000000$USDC_DENOM,$TESTNET_VALIDATOR_NATIVE_TOKEN_BALANCE$NATIVE_TOKEN" --home "$HOME_DIR"
done

# Generate genesis transaction for validator
echo "Generating genesis transaction..."
$BINARY_PATH gentx "$MONIKER" "$TESTNET_VALIDATOR_SELF_DELEGATE_AMOUNT$NATIVE_TOKEN" \
	--moniker="$MONIKER" \
	--keyring-backend=test \
	--chain-id="$CHAIN_ID" \
	--home "$HOME_DIR"

# Collect genesis transactions
echo "Collecting genesis transactions..."
$BINARY_PATH collect-gentxs --home "$HOME_DIR"

# Configure genesis parameters (fix bond denomination)
echo "Configuring genesis parameters..."
dasel put -t string -f "$CONFIG_DIR/genesis.json" '.app_state.staking.params.bond_denom' -v "$NATIVE_TOKEN"

# Configure rewards module to use existing BTC-USD market (market_id=0)
echo "Configuring rewards module..."
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.rewards' -v "{}"
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.rewards.params' -v "{}"
dasel put -t string -f "$CONFIG_DIR/genesis.json" '.app_state.rewards.params.treasury_account' -v 'rewards_treasury'
dasel put -t string -f "$CONFIG_DIR/genesis.json" '.app_state.rewards.params.denom' -v "$NATIVE_TOKEN"
dasel put -t int -f "$CONFIG_DIR/genesis.json" '.app_state.rewards.params.denom_exponent' -v '-18'
dasel put -t int -f "$CONFIG_DIR/genesis.json" '.app_state.rewards.params.market_id' -v '0'
dasel put -t int -f "$CONFIG_DIR/genesis.json" '.app_state.rewards.params.fee_multiplier_ppm' -v '990000'

# Configure market map (required for prices module)
echo "Configuring market map..."
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map' -v "{}"
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets' -v "{}"

# Marketmap: USDT/USD (MUST BE FIRST - other markets reference this for normalization)
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.USDT/USD' -v "{}"
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.USDT/USD.ticker' -v "{}"
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.USDT/USD.ticker.currency_pair' -v "{}"
dasel put -t string -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.USDT/USD.ticker.currency_pair.Base' -v 'USDT'
dasel put -t string -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.USDT/USD.ticker.currency_pair.Quote' -v 'USD'
dasel put -t int -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.USDT/USD.ticker.decimals' -v '9'
dasel put -t int -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.USDT/USD.ticker.min_provider_count' -v '3'
dasel put -t bool -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.USDT/USD.ticker.enabled' -v 'true'
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.USDT/USD.provider_configs.[]' -v '{"name": "binance_ws", "off_chain_ticker": "USDCUSDT", "invert": true}'
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.USDT/USD.provider_configs.[]' -v '{"name": "bybit_ws", "off_chain_ticker": "USDCUSDT", "invert": true}'
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.USDT/USD.provider_configs.[]' -v '{"name": "coinbase_ws", "off_chain_ticker": "USDT-USD"}'

# Marketmap: BTC/USD
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.BTC/USD' -v "{}"
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.BTC/USD.ticker' -v "{}"
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.BTC/USD.ticker.currency_pair' -v "{}"
dasel put -t string -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.BTC/USD.ticker.currency_pair.Base' -v 'BTC'
dasel put -t string -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.BTC/USD.ticker.currency_pair.Quote' -v 'USD'
dasel put -t int -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.BTC/USD.ticker.decimals' -v '5'
dasel put -t int -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.BTC/USD.ticker.min_provider_count' -v '3'
dasel put -t bool -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.BTC/USD.ticker.enabled' -v 'true'
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.BTC/USD.provider_configs.[]' -v '{"name": "binance_ws", "off_chain_ticker": "BTCUSDT", "normalize_by_pair": {"Base": "USDT", "Quote": "USD"}}'
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.BTC/USD.provider_configs.[]' -v '{"name": "bybit_ws", "off_chain_ticker": "BTCUSDT", "normalize_by_pair": {"Base": "USDT", "Quote": "USD"}}'
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.marketmap.market_map.markets.BTC/USD.provider_configs.[]' -v '{"name": "coinbase_ws", "off_chain_ticker": "BTC-USD"}'

# Configure prices module with BTC/USD market
echo "Configuring prices module..."
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.prices.market_params' -v "[]"
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.prices.market_prices' -v "[]"

# Market: BTC-USD
dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.prices.market_params.[]' -v "{}"
dasel put -t string -f "$CONFIG_DIR/genesis.json" '.app_state.prices.market_params.[0].pair' -v 'BTC-USD'
dasel put -t int -f "$CONFIG_DIR/genesis.json" '.app_state.prices.market_params.[0].id' -v '0'
dasel put -t int -f "$CONFIG_DIR/genesis.json" '.app_state.prices.market_params.[0].exponent' -v '-5'
dasel put -t int -f "$CONFIG_DIR/genesis.json" '.app_state.prices.market_params.[0].min_price_change_ppm' -v '1000'
dasel put -t string -f "$CONFIG_DIR/genesis.json" '.app_state.prices.market_params.[0].exchange_config_json' -v '{"exchanges": [{"exchangeName": "TestExchange", "ticker": "BTC-USD"}]}'
dasel put -t int -f "$CONFIG_DIR/genesis.json" '.app_state.prices.market_params.[0].min_exchanges' -v '1'

dasel put -t json -f "$CONFIG_DIR/genesis.json" '.app_state.prices.market_prices.[]' -v "{}"
dasel put -t int -f "$CONFIG_DIR/genesis.json" '.app_state.prices.market_prices.[0].id' -v '0'
dasel put -t int -f "$CONFIG_DIR/genesis.json" '.app_state.prices.market_prices.[0].exponent' -v '-5'
dasel put -t int -f "$CONFIG_DIR/genesis.json" '.app_state.prices.market_prices.[0].price' -v '2868819524'

echo "✅ Single node validator setup complete!"
echo ""
echo "Configuration details:"
echo "  Chain ID: $CHAIN_ID"
echo "  Moniker: $MONIKER"
echo "  Home directory: $HOME_DIR"
echo "  Binary: $BINARY_PATH"
echo ""
echo "To start the validator, run:"
echo "  $BINARY_PATH start --home $HOME_DIR \\"
echo "    --bridge-daemon-enabled=false \\"
echo "    --liquidation-daemon-enabled=false \\"
echo "    --price-daemon-enabled=false \\"
echo "    --oracle.enabled=false"
echo ""
echo "Note: Daemons are disabled for single-node development setup"
echo ""
echo "RPC endpoint will be available at: http://localhost:26657"
echo "gRPC endpoint will be available at: localhost:9090"
echo "REST API endpoint will be available at: http://localhost:1317"
