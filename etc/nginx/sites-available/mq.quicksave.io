server {
  server_name ${IO_QUICKSAVE_MQ};

  listen 0.0.0.0:80;
  listen [::]:80;

  access_log  ${IO_QUICKSAVE_LOG_DIR}/${IO_QUICKSAVE_MQ}_access.log;
  error_log   ${IO_QUICKSAVE_LOG_DIR}/${IO_QUICKSAVE_MQ}_error.log;

  location / {
    proxy_pass http://${IO_QUICKSAVE_MQ_HOST}:${IO_QUICKSAVE_MQ_PORT};
  }
}
