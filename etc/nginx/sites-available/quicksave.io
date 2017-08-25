server {
  server_name ${IO_QUICKSAVE};

  listen 0.0.0.0:80;
  listen [::]:80;

  root ${IO_QUICKSAVE_WWW_DIR};

  access_log ${IO_QUICKSAVE_LOG_DIR}/${IO_QUICKSAVE}_access.log;
  error_log  ${IO_QUICKSAVE_LOG_DIR}/${IO_QUICKSAVE}_error.log;
}

server {
  server_name   ${IO_QUICKSAVE_WWW};

  listen 0.0.0.0:80;
  listen [::]:80;

  return 301 http://${IO_QUICKSAVE}\$request_uri;
}
