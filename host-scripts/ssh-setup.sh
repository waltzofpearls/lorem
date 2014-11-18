#! /bin/bash

SERVERS=(
    "topbass@schenker.mjolnir" # 192.168.1.110
    "topbass@dns01.mjolnir"    # 192.168.1.150
    "topbass@front01.mjolnir"  # 192.168.1.160
    "topbass@app01.mjolnir"    # 192.168.1.170
    "topbass@app02.mjolnir"    # 192.168.1.171
    "topbass@app03.mjolnir"    # 192.168.1.172
    "topbass@cache01.mjolnir"  # 192.168.1.180
    "topbass@mq01.mjolnir"     # 192.168.1.190
    "topbass@db01.mjolnir"     # 192.168.1.200
    "topbass@db02.mjolnir"     # 192.168.1.201
    "topbass@db03.mjolnir"     # 192.168.1.202
    "topbass@util01.mjolnir"   # 192.168.1.210
)
SERVERS_LEN=${#SERVERS[@]}
SERVER=""

for (( i = 0; i < $SERVERS_LEN; i++ )); do
    SERVER=${SERVERS[$i]}
    # ssh -i "$KEY_PATH" -t "$SERVER" /usr/bin/sudo /sbin/shutdown -h 0
    # ssh -t "$SERVER" /usr/bin/sudo /sbin/shutdown -h 0
    scp ~/.ssh/id_dsa.mjolnir.pub "${SERVER}:/home/topbass"
    ssh "$SERVER" /bin/bash << EOF
        if [ ! -d /home/topbass/.ssh ]; then
            mkdir -p /home/topbass/.ssh
        fi
        cat /home/topbass/id_dsa.mjolnir.pub >> /home/topbass/.ssh/authorized_keys
        rm -f /home/topbass/id_dsa.mjolnir.pub
EOF
done
