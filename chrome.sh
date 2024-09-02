#!/bin/bash

PORT=6901
	screen -S docker-chrome -X quit
	screen -S docker-firefox -X quit
	# 获取本机公网IP地址
	IP_ADDRESS=$(curl -s https://ipinfo.io/ip)
        while lsof -i:$PORT &>/dev/null; do
		  printf "\r等待$PORT端口被释放，请稍后... %s   " "${spinner:i++%${#spinner}:1}"
          sleep 1  # 等待 1 秒后再次检查
        done
	# 使用 netstat 检查端口是否被占用
		apt  install docker.io  -y
		screen -dmS docker-chrome  docker run --rm -it --shm-size=512m -p $PORT:$PORT  -e VNC_PW=ReferreeNew2209A kasmweb/chrome:1.14.0 

		# Function to check if the port is open with a spinner
		check_port() {
			local spinner='/-\|'  # Spinner characters
			local i=0
			while ! nc -z localhost $PORT; do
				# Display the spinner
				printf "\r等待服务启动，请稍后... %s   " "${spinner:i++%${#spinner}:1}"
				sleep 1
			done
			echo -e "\n"
			echo "--------------------------------------------------------------"
			echo "服务已经启用，请在你的电脑浏览器中访问 https://$IP_ADDRESS:$PORT"
			echo "访问用户名：kasm_user ，密码：password "
			echo "--------------------------------------------------------------"
		}
	check_port
