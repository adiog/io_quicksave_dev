server {
  server_name ${IO_QUICKSAVE_LOCUST_OAUTH};

  listen 80;
  listen [::]:80;

  location / {
    proxy_pass http://${IO_QUICKSAVE_LOCUST_HOST}:${IO_QUICKSAVE_LOCUST_OAUTH_PORT};
  }
}

server {
  server_name ${IO_QUICKSAVE_LOCUST_API};

  listen 80;
  listen [::]:80;

  location / {
    proxy_pass http://${IO_QUICKSAVE_LOCUST_HOST}:${IO_QUICKSAVE_LOCUST_API_PORT};
  }
}

server {
  server_name ${IO_QUICKSAVE_LOCUST_CDN};

  listen 80;
  listen [::]:80;

  location / {
    proxy_pass http://${IO_QUICKSAVE_LOCUST_HOST}:${IO_QUICKSAVE_LOCUST_CDN_PORT};
  }
}

server {
  server_name ${IO_QUICKSAVE_LOCUST};

  listen 80;
  listen [::]:80;

  location / {
    proxy_pass http://${IO_QUICKSAVE_LOCUST_HOST}:${IO_QUICKSAVE_LOCUST_PORT};
  }
}
