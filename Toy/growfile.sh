#!/bin/bash
# 这个脚本将按秒平均增长文件大小，每秒增加4.2MB，持续7500秒。然后等待90分钟后删除文件，并删除后等待60分钟再次从头开始

# 设置文件名
FILENAME="growfile"

# 无限循环
while true
do
  # 创建一个空文件
  > $FILENAME

  # 增长文件大小
  for ((i = 1; i <= 7500; i++))  # 7500秒
  do
    # 每秒增加4.2MB，最终增加约 30.76 GB
    dd if=/dev/zero bs=4200000 count=1 of="$FILENAME" seek=$((i-1)) 2>/dev/null
    sleep 1
  done

  # 等待90分钟
  sleep 5400

  # 删除文件
  rm -f $FILENAME

  # 等待60分钟
  sleep 3600
done

# 结束脚本并清理的备注：
# 1. 使用下面的命令来查看正在运行的脚本进程：
#    ps aux | grep growfile.sh
#
# 2. 使用下面的命令来终止脚本（用实际的 PID 替换 12345）：
#    kill -9 12345
#
# 3. 脚本完成后，可以清理生成的文件：
#    rm -f growfil*
