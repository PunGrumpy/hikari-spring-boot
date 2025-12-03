CREATE USER IF NOT EXISTS 'instanauser'@'172.19.0.1'
  IDENTIFIED BY 'P@ssw0rd_Instana_2025';

GRANT SELECT ON performance_schema.* TO 'instanauser'@'172.19.0.1';
FLUSH PRIVILEGES;