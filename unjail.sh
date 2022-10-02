#!/bin/bash
# Binary
BINARY=haqqd
# Your wallet address here
WALLET=your wallet
# Your node RPC address
RPC="http://127.0.0.1:26657"
# Trusted node RPC address, not yours!!!
RPC2="https://rpc-1.haqq.nodes.guru:443/status?"
# Path save log
LOG_FILE="/root/log.log"
#
touch $LOG_FILE
BLOCK1=$(curl -s "$RPC2/status" | jq '.result.sync_info.latest_block_height' | xargs )
STATUS=$(curl -s "$RPC/status")
CATCHING_UP=$(echo $STATUS | jq '.result.sync_info.catching_up')
LATEST_BLOCK=$(echo $STATUS | jq '.result.sync_info.latest_block_height' | xargs )
ADDRESS=$(echo $STATUS | jq '.result.validator_info.address' | xargs )
source $LOG_FILE


echo 'LAST_BLOCK="'"$LATEST_BLOCK"'"' > $LOG_FILE
echo 'LAST_POWER="'"$VOTING_POWER"'"' >> $LOG_FILE
#
# Node stopped or node stuck in one block
curl -s "$RPC/status"> /dev/null
if [[ $? -ne 0 ]]; then
	echo | sudo systemctl restart $BINARY
		sleep 15s
elif [[ $LAST_BLOCK -ge $LATEST_BLOCK ]]; then
	echo | sudo systemctl restart $BINARY
		sleep 15s
fi
# Voting power ZERO
VOTING_POWER=$(echo $STATUS | jq '.result.validator_info.voting_power' | xargs )
if [[ $VOTING_POWER -lt 1 ]]; then
	echo | $BINARY tx slashing unjail --from $WALLET -y
		sleep 15s
fi
