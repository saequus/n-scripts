# Variables
initial_user="user"
initial_server="server"
initial_domain="domain.com"

#sudo apt update
sudo apt-get update -y && sudo apt-get upgrade -y

# Docker install

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io


# Install ufw firewall
sudo apt install ufw

#################### UFW configuration ####################
#deny all incoming connections and then open only ones reqired
sudo ufw default deny incoming
sudo ufw default allow outgoing

#To allow listining on port 22,80,443
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https

#For specific IP Addresses
#sudo ufw allow from 203.0.113.4
#or
#sudo ufw allow from 203.0.113.4 to any port 22

#Enable UFW
sudo ufw enable 
#################### End of UFW configuration ####################

#################### Nginx configuration ####################
sudo apt install nginx
#allow Nginx HTTP and Nginx HTTPS
sudo ufw allow 'Nginx Full'
sudo systemctl start nginx
#Restart nginx without dropping connections.
sudo systemctl reload nginx

# On boot 
#sudo systemctl enable nginx


Creating new server block
cat > /etc/nginx/sites-available/$initial_server << EOL
server {
        listen 80;
        server_name $initial_domain www.$initial_domain;
        location / {
                proxy_pass localhost:7000;
        }
}
EOL



# Enabling the file by creating link from it to the site-enabled dir
sudo ln -s /etc/nginx/sites-available/$initial_server /etc/nginx/sites-enabled/



# Install git 
sudo apt-get install git

# Install NodeJS
sudo apt install nodejs
sudo apt install npm
sudo apt install yarn


