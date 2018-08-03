FROM redis:3
RUN apt update --fix-missing && apt install -y stunnel4 && apt autoremove && rm -rf /var/lib/apt/lists/*
COPY ./launch-redis-cli.sh /launch-redis-cli.sh
ENTRYPOINT ["/launch-redis-cli.sh"]
