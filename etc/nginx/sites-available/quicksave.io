server {
  server_name ${IO_QUICKSAVE};

  listen 0.0.0.0:443 ssl;
  listen [::]:443 ssl;

  ssl_certificate     ${IO_QUICKSAVE_CERT_DIR}/${IO_QUICKSAVE}.crt;
  ssl_certificate_key ${IO_QUICKSAVE_CERT_DIR}/${IO_QUICKSAVE}.key;

  root ${IO_QUICKSAVE_WWW_DIR};

  access_log ${IO_QUICKSAVE_LOG_DIR}/${IO_QUICKSAVE}_access.log;
  error_log  ${IO_QUICKSAVE_LOG_DIR}/${IO_QUICKSAVE}_error.log;
}

server {
  server_name ${IO_QUICKSAVE} ${IO_QUICKSAVE_WWW};
  listen 80;
  return 301 https://${IO_QUICKSAVE}\$request_uri;
}

server {
  server_name   ${IO_QUICKSAVE_WWW};

  listen        0.0.0.0:443 ssl;
  listen [::]:443 ssl;

  ssl_certificate     ${IO_QUICKSAVE_CERT_DIR}/${IO_QUICKSAVE}.crt;
  ssl_certificate_key ${IO_QUICKSAVE_CERT_DIR}/${IO_QUICKSAVE}.key;

  return 301 https://${IO_QUICKSAVE}\$request_uri;
}
