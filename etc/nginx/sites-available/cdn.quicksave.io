server {
  server_name cdn.quicksave.io;

  listen 80;

  location / {
    proxy_pass http://127.0.0.1:12000;
    add_header 'Access-Control-Allow-Origin' 'http://quicksave.io';
    add_header 'Access-Control-Allow-Credentials' 'true';
    add_header 'Access-Control-Max-Age' '86400';
    add_header 'Access-Control-Allow-Methods' 'PUT,GET,POST,DELETE';
    add_header 'Access-Control-Allow-Headers' 'X-PINGOTHER, Content-Type, authorization';
  }
}
