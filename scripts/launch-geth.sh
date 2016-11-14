BASEDIR=$(dirname "$0")
geth --networkid 42 --datadir ~/.ethereum/net42 init $BASEDIR/genesis42.js
geth --networkid 42 --datadir ~/.ethereum/net42 --rpc --rpcport 8545 --rpcaddr 0.0.0.0 --rpccorsdomain "*" --rpcapi "eth,web3,net,miner,debug" --unlock "0,1,2,3,4" --password $BASEDIR/password.txt console

OUT=$?
# It probably failed to start because there were not enough accounts. Create them.
if [ $OUT -eq 0 ];then
	echo ""
else
	for i in 0 1 2 3 4
	do
		geth --datadir ~/.ethereum/net42 --password $BASEDIR/password.txt account new 
	done
fi
