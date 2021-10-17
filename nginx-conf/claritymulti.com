server {
    listen         80 default_server;
    listen         [::]:80 default_server;
    root           /var/www/claritymulti.com;
    index          index.html index.php;

  location ~* \.php$ {
    fastcgi_pass    127.0.0.1:9000;
    include         fastcgi_params;
    fastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;
    fastcgi_param   SCRIPT_NAME        $fastcgi_script_name;
  }
}