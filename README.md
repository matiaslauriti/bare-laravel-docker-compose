# xDebug setup for Phpstorm

1. Create a server with the desired name, usually `localhost` and map `src` to `/var/www`.
2. When selecting the PHP CLI interpreter (`Docker Compose -> Service: app`), add
   this `Environment Variable`: `PHP_IDE_CONFIG="serverName=tests"` (for tests !!!).
