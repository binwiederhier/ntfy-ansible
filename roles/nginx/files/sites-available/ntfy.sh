server {
  listen 80;
  server_name ntfy.sh;

  location / {
    # Redirect to HTTPS
    set $redirect_https "";
    if ($request_method = GET) {
      set $redirect_https "yes";
    }
    if ($request_uri ~* "^/([-_a-z0-9]{0,64}$|docs/|static/)") {
      set $redirect_https "${redirect_https}yes";
    }
    if ($redirect_https = "yesyes") {
      return 302 https://$http_host$request_uri$is_args$query_string;
    }

    # Rate limit (fail2ban)
    limit_req zone=one burst=1000 nodelay;

    # Proxy to backend
    proxy_pass http://127.0.0.1:11080;
    proxy_http_version 1.1;

    proxy_buffering off;
    proxy_request_buffering off;
    proxy_redirect off;

    proxy_set_header Host $http_host;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    proxy_connect_timeout 3m;
    proxy_send_timeout 3m;
    proxy_read_timeout 3m;

    client_max_body_size 20m; # Must be >= attachment-file-size-limit in /etc/ntfy/server.yml
  }

  location /docs {
    rewrite ^/docs/?$ https://docs.ntfy.sh/ redirect;
    rewrite ^/docs/(.+)$ https://docs.ntfy.sh/$1 redirect;
    return 302 https://docs.ntfy.sh/;
  }
}

server {
  listen 443 ssl;
  server_name ntfy.sh;

  # SSL/TLS
  ssl_session_cache builtin:1000 shared:SSL:10m;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_ciphers HIGH:!aNULL:!eNULL:!EXPORT:!CAMELLIA:!DES:!MD5:!PSK:!RC4;
  ssl_prefer_server_ciphers on;

  ssl_certificate /etc/letsencrypt/live/ntfy.sh/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/ntfy.sh/privkey.pem;

  location / {
    # Rate limit (fail2ban)
    limit_req zone=one burst=1000 nodelay;

    # Proxy to backend
    proxy_pass http://127.0.0.1:11080;
    proxy_http_version 1.1;

    proxy_buffering off;
    proxy_request_buffering off;
    proxy_redirect off;

    proxy_set_header Host $http_host;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    proxy_connect_timeout 3m;
    proxy_send_timeout 3m;
    proxy_read_timeout 3m;

    client_max_body_size 20m; # Must be >= attachment-file-size-limit in /etc/ntfy/server.yml
  }

  location /docs {
    rewrite ^/docs/?$ https://docs.ntfy.sh/ redirect;
    rewrite ^/docs/(.+)$ https://docs.ntfy.sh/$1 redirect;
    return 302 https://docs.ntfy.sh/;
  }
}
