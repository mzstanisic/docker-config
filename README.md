# docker-config

Scripts and configs to setup a docker stack on a home server.

- [Code Server](https://coder.com/docs/code-server/install#docker) is used to access various YAML and config files for other docker containers in the server without having to remote/SSH into the server. Currently using the linuxserver image [here.](https://docs.linuxserver.io/images/docker-code-server/)
- [Hoarder](https://github.com/hoarder-app/hoarder/blob/main/docker/docker-compose.yml) is used to keep track of bookmarks across different environments. Supports archiving and screenshots to make bookmarks easier to read through.
- [Homepage](https://gethomepage.dev/installation/docker/) is used to aggregate the links to all the services running on the containers, as well as other services like hypervisors, router portals, etc.
- [Jellyfin](https://jellyfin.org/docs/general/installation/container#docker) is used to serve media from the server. Preferred to Plex since it is open source and hardware transcoding is free.
- [Joplin Server](https://github.com/laurent22/joplin/tree/dev/packages/server) is used as a self-hosted solution to sync and save Joplin notes.
- [Gluetun](https://hub.docker.com/r/qmcgaw/gluetun) is used to pass through various containers through a VPN.
- [qBittorrent](https://hub.docker.com/r/linuxserver/qbittorrent) is used as a torrent client.
- [Bazarr](https://hub.docker.com/r/linuxserver/bazarr) is used to retrieve subtitles for movies and shows.
- [Radarr](https://hub.docker.com/r/linuxserver/radarr) is used to manage and organize movies.
- [Sonarr](https://hub.docker.com/r/linuxserver/sonarr) is used to manage and organize shows.
- [Recyclarr](https://recyclarr.dev/wiki/) is used to retrieve recommended quality profiles from Trash Guides for Radarr and Sonarr.
- [Portainer](https://docs.portainer.io/start/install-ce/server/docker/linux) is used to manage Docker containers from a web interface, instead of having to remote/SSH into the server.
- [Watchtower](https://hub.docker.com/r/containrrr/watchtower) is used to automatically update containers when an update is available.
