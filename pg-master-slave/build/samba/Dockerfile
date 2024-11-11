FROM debian:stretch

RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        gnupg2 \
        dirmngr \
        samba \
        vim \
        locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*  

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && echo "Asia/Ho_Chi_Minh" > /etc/timezone

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

COPY smb.conf /etc/samba/smb.conf

ENV LANG en_US.utf8

RUN groupadd -r postgres && useradd -r -g postgres postgres

RUN mkdir -p /postgres-0 /postgres-1 /postgres-2 \
    && chown -R postgres:postgres /postgres-0 /postgres-1 /postgres-2 \
    && chmod 770 /postgres-0 /postgres-1 /postgres-2

VOLUME [ "/postgres-0", "/postgres-1", "/postgres-2" ]

EXPOSE 139 445

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD ["tail", "-f", "/dev/null"]
