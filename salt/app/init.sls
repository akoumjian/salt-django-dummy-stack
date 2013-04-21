deploy_keys:
  file.recurse:
    - name: /root/.ssh/
    - source: salt://app/keys
    - file_mode: 600

app-pkgs:
  pkg.installed:
    - pkgs:
      - git
      - python-dev

myapp:
  git.latest:
    - name: git@github.com:akoumjian/dummy_django_project.git
    - rev: master
    - target: /var/www/myapp
    - force: true
    - require:
      - pkg: app-pkgs
      - file: deploy_keys

/var/www/myapp/requirements.txt:
  pip.installed:
    - require:
      - git: myapp

/var/www/myapp/django_project/settings_local.py:
  file.managed:
    - source: salt://app/settings_local.py
    - require:
      - git: myapp
