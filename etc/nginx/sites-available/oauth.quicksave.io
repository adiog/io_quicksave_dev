server {
  server_name ${IO_QUICKSAVE_OAUTH};

  listen 0.0.0.0:80;
  listen [::]:80;

  access_log  ${IO_QUICKSAVE_LOG_DIR}/${IO_QUICKSAVE_OAUTH}_access.log;
  error_log   ${IO_QUICKSAVE_LOG_DIR}/${IO_QUICKSAVE_OAUTH}_error.log;

  location / {
    proxy_pass http://${IO_QUICKSAVE_OAUTH_HOST}:${IO_QUICKSAVE_OAUTH_PORT};
    add_header 'Access-Control-Allow-Origin' 'http://${IO_QUICKSAVE}';
    add_header 'Access-Control-Allow-Credentials' 'true';
    add_header 'Access-Control-Max-Age' '86400';
    add_header 'Access-Control-Allow-Methods' 'PUT,GET,POST,DELETE';
    add_header 'Access-Control-Allow-Headers' 'X-PINGOTHER, Content-Type, authorization';
  }
}
