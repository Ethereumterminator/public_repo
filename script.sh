#!/bin/bash
echo "OPENVPN PORT FORWARDING INSTALLER"
sleep 2
echo "Fiver Contact -> https://www.fiverr.com/nooblk98"
sleep 3
echo "e-mail -> liyanagelsofficial@gmail.com"
sleep 1
echo "Forwarding ports - 5050 , 5051 , 5052 , 5053 , 5054 , 5055 , 81"
sleep 1
echo "Installing"
# Run the Docker container in the background
docker run -d --cap-add=NET_ADMIN -p 1194:1194/udp -p 80:8080/tcp -p 81:81/tcp -p 5050:5050/tcp -p 5051:5051/tcp -p 5052:5052/tcp -p 5053:5053/tcp -p 5054:5054/tcp -p 5055:5055/tcp -e HOST_ADDR=$(curl -s https://api.ipify.org) --name dockovpn alekslitvinenk/openvpn


echo "For downloading the OVPN file, please visit: http://ip:80 then press Y"
sleep 1
echo "Thank you for your attention."

read -p "Type 'Y' to continue: " response

if [ "$response" = "Y" ] || [ "$response" = "y" ]; then
    echo "Continuing..."
    # Run the iptables command inside the Docker container
    docker exec -it dockovpn iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 81 -j DNAT --to-destination 10.8.0.6:81

    docker exec -it dockovpn iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 5050 -j DNAT --to-destination 10.8.0.6:5050

    docker exec -it dockovpn iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 5051 -j DNAT --to-destination 10.8.0.6:5051

    docker exec -it dockovpn iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 5052 -j DNAT --to-destination 10.8.0.6:5052

    docker exec -it dockovpn iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 5053 -j DNAT --to-destination 10.8.0.6:5053

    docker exec -it dockovpn iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 5054 -j DNAT --to-destination 10.8.0.6:5054

    docker exec -it dockovpn iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 5055 -j DNAT --to-destination 10.8.0.6:5055


    sleep 1
    echo "Install finished thank you !"
    else
    echo "Exiting..."
fi
