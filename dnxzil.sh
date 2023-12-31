{\rtf1\ansi\ansicpg1251\deff0\nouicompat{\fonttbl{\f0\fswiss\fcharset0 Helvetica;}{\f1\fswiss\fcharset204 Helvetica;}}
{\*\generator Riched20 10.0.19041}\viewkind4\uc1 
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\f0\fs24\lang1033 #!/bin/bash\par
\par
# Set up variables\par
DNX_MINER="/hive/miners/onezerominer/1.2.5/onezerominer"\par
ZIL_MINER="/hive/miners/rigel/1.9.1/rigel"\par
DNX_POOL="dynex-eu.luckyminers.io:3430"\par
DNX1_POOL="dynex-us-east.luckyminers.io:3430"\par
ZIL_POOL="stratum+tcp://eu.crazypool.org:5005"\par
DNX_WALLET="Xwo7pSzeXNTEMB2u2KPbt59wBPQmgQt1ZG9HYhMq17NKK64cejYs6ntTDgnM4X3qjsZrgfgojbnGEZRVepMAQYce28bdyLHQE"\par
ZIL_WALLET="zil1m6pw8m2q9a9l8dqa76n9s0n7ygjnw0uhkz3lr4"\par
WORKER_NAME="bigshifty"\par
\par
# Start Zilliqa mining\par
echo "Start Zilliqa mining + DNX mining"\par
nohup $ZIL_MINER  -a zil --zil-cache-dag off -o $ZIL_POOL -u $ZIL_WALLET -d 0, 1, 2, 3, 4, 5, 6, 7 --zil-countdown -p x -w $WORKER_NAME > rigel.log 2>&1 &\par 
nohup $DNX_MINER  --algo dynex --wallet=$DNX_WALLET --pool=$DNX_POOL -d 0, 1, 2, 3, 4, 5, 6, 7 --pass xvx $WORKER_NAME --mallob-endpoint\f1\lang1049  \f0\lang1033 dnx.eu.ekapool.com\par 
#miner start\par
    nvtool -i 0 --setcoreoffset 200 --setmem 5001 --setclocks 1470 
    nvtool -i 1 --setcoreoffset 200 --setmem 5001 --setclocks 1470
    nvtool -i 2 --setcoreoffset 200 --setmem 5001 --setclocks 1470
    nvtool -i 3 --setcoreoffset 200 --setmem 5001 --setclocks 1470
    nvtool -i 4 --setcoreoffset 200 --setmem 5001 --setclocks 1470
    nvtool -i 5 --setcoreoffset 200 --setmem 5001 --setclocks 1470
    nvtool -i 6 --setcoreoffset 150 --setmem 4001 --setclocks 1470
    nvtool -i 7 --setcoreoffset 150 --setmem 4001 --setclocks 1470

\par
# Wait for Zilliqa mining to start\par
echo "Wait for Zilliqa mining to start"\par
while true; do\par
  if pgrep -f $ZIL_MINER > /dev/null; then\par
    echo "Zilliqa mining has started"\par
    break\par
  else\par
    echo "ZIL miner not found"\par
  fi\par
  sleep 1\par
done\par
\par
# Monitor rigel.log for Zilliqa session started/finished messages\par
tail -f rigel.log | while read line; do\par
  if [[ $line == *"Zilliqa session started"* ]]; then\par
    echo "Zilliqa mining started, stopping dnx"\par
   # Set the memory clock up speed down gpu clock speed
    nvtool -i 0 --setcoreoffset 0 --setclocks 1200 --setmemoffset 0 
    nvtool -i 1 --setcoreoffset 0 --setclocks 1200 --setmemoffset 0 
    nvtool -i 2 --setcoreoffset 0 --setclocks 1200 --setmemoffset 0 
    nvtool -i 3 --setcoreoffset 0 --setclocks 1200 --setmemoffset 0 
    nvtool -i 4 --setcoreoffset 0 --setclocks 1200 --setmemoffset 0 
    nvtool -i 5 --setcoreoffset 0 --setclocks 1200 --setmemoffset 0
    nvtool -i 6 --setcoreoffset 0 --setclocks 1200 --setmemoffset 0
    nvtool -i 7 --setcoreoffset 0 --setclocks 1200 --setmemoffset 0

\par
miner stop\par
#    pkill -f "$DNX_MINER"\par
  elif [[ $line == *"Zilliqa session finished"* ]]; then\par
    echo "Zilliqa mining finished, starting dnx"\par
     # Set the memory clock speed back up gpu clock speed

    nvtool -i 0 --setcoreoffset 200 --setmem 5001 --setclocks 1470 
    nvtool -i 1 --setcoreoffset 200 --setmem 5001 --setclocks 1470
    nvtool -i 2 --setcoreoffset 200 --setmem 5001 --setclocks 1470
    nvtool -i 3 --setcoreoffset 200 --setmem 5001 --setclocks 1470
    nvtool -i 4 --setcoreoffset 200 --setmem 5001 --setclocks 1470
    nvtool -i 5 --setcoreoffset 200 --setmem 5001 --setclocks 1470
    nvtool -i 6 --setcoreoffset 150 --setmem 4001 --setclocks 1470
    nvtool -i 7 --setcoreoffset 150 --setmem 4001 --setclocks 1470
\par
miner start\par
#    nohup $DNX_MINER --algo dynex --wallet=$DNX_WALLET --pool=$DNX_POOL --pass $WORKER_NAME --mallob-endpoint dnx.eu.ekapool.com\par
  fi\par

\pard\sa200\sl276\slmult1 done\par
}
 