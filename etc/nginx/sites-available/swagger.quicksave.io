server {
  server_name ${IO_QUICKSAVE_SWAGGER};

  listen 0.0.0.0:80;
  listen [::]:80;

  location / {
    proxy_pass http://${IO_QUICKSAVE_SWAGGER_HOST}:${IO_QUICKSAVE_SWAGGER_PORT};
  }
}