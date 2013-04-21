include:
  - app

# Install and configure nginx
nginx:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/default:
  file.managed:
    - source: salt://webserver/nginx_site.conf
    - watch_in:
      - service: nginx

# Install and configure uwsgi
uwsgi:
  pkg:
    - installed
  service:
    - running
    - watch:
      - git: myapp
      - file: /var/www/myapp/djang_project/settings_local.py

/etc/uwsgi/apps-enabled/app:
  file.managed:
    - source: salt://webserver/myapp_uwsgi.ini
    - watch_in:
      - service: uwsgi
