folders='Desktop Documents Downloads Pictures Videos'
for folder in $folders
do
    mkdir $folder
    echo "Ustvarjena je bila mapa $folder"
done


for i in {1..5}
do
    mkdir "folder$i"
    echo "Ustvarjena je bila mapa folder$i"
done


wget -q -O uporabniki.txt "https://raw.githubusercontent.com/alisazahirovic/oikt6/main/uporabniki.txt"
input=uporabniki.txt
while IFS= read -r username
do
    if grep $username /etc/passwd > /dev/null # exit status of previous command
    then
        echo "Uporabnik $username ze obstaja"
    else    
        useradd -G sudo -m $username
        echo "Narejen je bil uporabnik $username"
    fi
done < "$input"


if apt-get update
then
    apt-get upgrade -y
fi


apt-get install -y ufw git nginx net-tools


if apt-get install -y ca-certificates curl gnupg lsb-release
then
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "Konec skripte"