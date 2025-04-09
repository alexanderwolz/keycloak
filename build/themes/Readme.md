  #disable theme caching
  
  in docker-compose:
  command: ["start", "--optimized", "--spi-theme-static-max-age=-1", "--spi-theme-cache-themes=false", "--spi-theme-cache-templates=false"]


  docker compose -f docker-compose.yml up --build -d