#!/bin/bash
echo "OPENVPN PORT FORWARDING INSTALLER"
sleep 2
echo "Fiver Contact -> https://www.fiverr.com/nooblk98"
sleep 3
echo "e-mail -> liyanagelsofficial@gmail.com"
sleep 1
echo "Installing"
# Run the Docker container in the background
apt update -y

apt upgrade -y

apt install docker.io -y

ufw disable -y

docker run -d --cap-add=NET_ADMIN -p 1194:1194/udp -p 80:8080/tcp -p 81:81/tcp -p 5050:5050/tcp -p 5051:5051/tcp -p 5052:5052/tcp -p 5053:5053/tcp -p 5054:5054/tcp -p 5055:5055/tcp -e HOST_ADDR=$(curl -s https://api.ipify.org) --name dockovpn alekslitvinenk/openvpn


echo "For downloading the OVPN file, please visit: http://ip:80 then press Y"
sleep 1
echo "Thank you for your attention."

read -p "Type 'Y' to continue: " response

if [ "$response" = "Y" ] || [ "$response" = "y" ]; then
    echo "Continuing..."

    # Prompt the user to enter a list of forwarding ports separated by spaces
    read -p "Enter forwarding ports (e.g., 81 5050 5051): " ports

    # Split the user input into an array
    IFS=" " read -ra port_array <<< "$ports"

    # Loop through the array and run the docker exec command for each port
    for port in "${port_array[@]}"; do
        docker exec -it dockovpn iptables -t nat -A PREROUTING -i eth0 -p tcp --dport "$port" -j DNAT --to-destination 10.8.0.6:"$port"
    done

    sleep 1
    echo "Install finished, thank you!"
else
    echo "Exiting..."
fi
