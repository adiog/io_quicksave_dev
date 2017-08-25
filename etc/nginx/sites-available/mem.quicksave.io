server {
  listen   80;

  root ${IO_QUICKSAVE_MEM_DIR};
  index index.php index.html index.htm;

  server_name mem.quicksave.io;

  location / {
          try_files \$uri \$uri/ /index.html;
  }

  # pass the PHP scripts to FastCGI server listening on the php-fpm socket
  location ~ \.php\$ {
          try_files \$uri =404;
          fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
          fastcgi_index index.php;
          fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
          include fastcgi_params;
 }
}