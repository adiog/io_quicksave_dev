server {
  server_name ${IO_QUICKSAVE_API};

  listen 0.0.0.0:80;
  listen [::]:80;

  access_log  ${IO_QUICKSAVE_LOG_DIR}/${IO_QUICKSAVE_API}_access.log;
  error_log   ${IO_QUICKSAVE_LOG_DIR}/${IO_QUICKSAVE_API}_error.log;

  client_max_body_size 200M;

  location / {
    client_max_body_size 200M;
    proxy_pass http://${IO_QUICKSAVE_API_HOST}:${IO_QUICKSAVE_API_PORT};
    add_header 'Access-Control-Allow-Origin' 'http://${IO_QUICKSAVE}';
    add_header 'Access-Control-Allow-Credentials' 'true';
    add_header 'Access-Control-Max-Age' '86400';
    add_header 'Access-Control-Allow-Methods' 'PUT,GET,POST,DELETE';
    add_header 'Access-Control-Allow-Headers' 'X-PINGOTHER, Content-Type, authorization';
  }
}
