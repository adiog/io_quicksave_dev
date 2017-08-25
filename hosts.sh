if ! grep -q quicksave.io /etc/hosts;
then
    sudo echo 127.0.0.1 quicksave.io api.quicksave.io oauth.quicksave.io cdn.quicksave.io mq.quicsave.io mem.quicksave.io swagger.quicksave.io api.locust.quicksave.io oauth.locust.quicksave.io >> /etc/hosts
else
    echo /etc/hosts already set
fi
