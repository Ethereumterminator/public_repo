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

# Prompt the user to enter forwarding ports separated by spaces
read -p "Enter forwarding ports (e.g., 81 5050 5051): " ports

# Construct a string for port mappings
port_mappings=""
for port in $ports; do
    port_mappings+="-p $port:$port/tcp "
done

docker run -d --cap-add=NET_ADMIN -p 1194:1194/udp -p 80:8080/tcp $port_mappings -e HOST_ADDR=$(curl -s https://api.ipify.org) --name dockovpn alekslitvinenk/openvpn

echo "For downloading the OVPN file, please visit: http://ip:80 then press Y"
sleep 1
echo "Thank you for your attention."

read -p "Type 'Y' to continue: " response

if [ "$response" = "Y" ] || [ "$response" = "y" ]; then
    echo "Continuing..."

    # Loop through the array and run the docker exec command for each port
    for port in $ports; do
        docker exec -it dockovpn iptables -t nat -A PREROUTING -i eth0 -p tcp --dport "$port" -j DNAT --to-destination 10.8.0.6:"$port"
    done

    sleep 1
    echo "Install finished, thank you!"
else
    echo "Exiting..."
fi
