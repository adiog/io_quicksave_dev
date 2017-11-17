server {
  server_name quicksave.io;

  listen 0.0.0.0:80;
  listen [::]:80;

  root /home/adiog/workspace/quicksave/io_quicksave_www;

  location / {
    autoindex on;
  }
}

server {
  server_name www.quicksave.io;

  listen 0.0.0.0:80;
  listen [::]:80;

  return 301 http://quicksave.io\$request_uri;
}
