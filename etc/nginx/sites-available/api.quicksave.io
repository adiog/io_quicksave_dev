server {
  server_name api.quicksave.io;

  listen 0.0.0.0:80;
  listen [::]:80;

  client_max_body_size 200M;

  location / {
    client_max_body_size 200M;
    proxy_pass http://127.0.0.1:11000;
    add_header 'Access-Control-Allow-Origin' 'http://quicksave.io';
    add_header 'Access-Control-Allow-Credentials' 'true';
    add_header 'Access-Control-Max-Age' '86400';
    add_header 'Access-Control-Allow-Methods' 'PUT,GET,POST,DELETE';
    add_header 'Access-Control-Allow-Headers' 'X-PINGOTHER, Content-Type, authorization';
  }
}
