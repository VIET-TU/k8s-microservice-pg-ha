FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres

RUN apt update && apt upgrade -y && \
    apt install -y wget gnupg lsb-release sudo && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt update && \
    apt install -y postgresql-14 postgresql-contrib-14 && \
    apt clean

COPY entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 5432

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["postgres"]
