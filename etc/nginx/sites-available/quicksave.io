server {
  server_name quicksave.io;

  listen 0.0.0.0:80;
  listen [::]:80;

  location / {
    proxy_pass http://127.0.0.1:8080;
  }
}

server {
  server_name www.quicksave.io;

  listen 0.0.0.0:80;
  listen [::]:80;

  return 301 http://quicksave.io\$request_uri;
}
