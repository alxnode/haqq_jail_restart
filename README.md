# haqq_jail_restart
This tool helps you to restart your node and unjail. It is checking if your node wend down, restart it and execute unjail. Use only at **testnets** in order not to loose uptime!

**First step. ** Update your RPC and wallet at unjail.sh
**Second step.** At your node server create any folder. Place unjail.sh there and create LOG_Path file
**Third step**.  Give chmod +x unjail.sh 
**Fourth step. ** Create crontab task to run it every minute : */1 * * * * root /root/unajil.sh - your path
