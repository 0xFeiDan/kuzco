#!binbash

# 根据自己的 GPU 能力，更改此数值
workers=85

# 检查 kuzco 进程数量
count=$(top -b -n 1  grep --count 'kuzco')

if [[ $count -gt 70 ]]; then  #大于10个实例
    echo kuzco-runtime 正常运行.
else
    echo kuzco 小于范围,重新启动实例
    killall kuzco
    killall kuzco-runtime	
    if ! pgrep -x kuzco-runtime  devnull; then
        # 执行操作
        echo kuzco 不存在
        for ((i=0;iworkers;i++)); do (nohup kuzco worker start  devnull 2&1 & sleep 3); done
    fi
fi