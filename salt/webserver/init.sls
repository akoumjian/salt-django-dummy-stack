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
uwsgi_upstart:
  file.managed:
    - name: /etc/init/uwsgi.conf
    - source: salt://webserver/uwsgi.conf

/etc/uwsgi/apps-enabled/myapp.ini:
  file.managed:
    - source: salt://webserver/myapp.ini
    - watch_in:
      - service: uwsgi

/var/log/uwsgi:
  file:
    - directory

uwsgi:
  pip:
    - installed
  service:
    - running
    - require:
      - pip: uwsgi
      - file: uwsgi_upstart
      - file: /etc/uwsgi/apps-enabled/myapp.ini
    - watch:
      - git: myapp
      - file: settings


