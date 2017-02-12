database-pkgs:
  pkg.installed:
    - names:
      - postgresql

pg_zosia_user:
  postgres_user.present:
    - name: zosia
    - require:
        - pkg: database-pkgs

pg_zosia_database:
  postgres_database.present:
    - name: zosia
    - owner: zosia
    - require:
        - postgres_user: pg_zosia_user
        - pkg: postgresql
