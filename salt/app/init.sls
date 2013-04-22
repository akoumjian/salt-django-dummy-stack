deploy_keys:
  file.recurse:
    - name: /root/.ssh/
    - source: salt://app/keys
    - file_mode: 600

app-pkgs:
  pkg.installed:
    - pkgs:
      - git
      - python-pip
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

myapp_requirements:
  pip.installed:
    - requirements: /var/www/myapp/requirements.txt
    - require:
      - git: myapp

settings_local:
  file.managed:
    - name: /var/www/myapp/django_project/settings_local.py
    - source: salt://app/settings_local.py
    - require:
      - git: myapp
