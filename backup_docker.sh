#!/bin/bash
##########################################################################################
#
# Backup to NFS mount script with grandparent-parent-child rotation.
# https://documentation.ubuntu.com/server/reference/backups/archive-rotation-shell-script/
#
# Restore volumes:
# https://docs.docker.com/engine/storage/volumes/#back-up-restore-or-migrate-data-volumes
##########################################################################################

# Docker config folders to backup.
backup_files="/mnt/docker"

# Docker volumes to backup.
volumes=(
	"joplin-server_data"
	"hoarder_data"
	"hoarder_meilisearch"
	"portainer_data"
	"code-server_config"
	"jellyfin_config"
	"jellyfin_cache"
	"media-management_bazarr"
	"media-management_prowlarr"
	"media-management_radarr"
	"media-management_sonarr"
	"media-management_qbittorrent"
	)

# Where to backup to.
dest="/mnt/backup/backups/docker"

# Setup variables for the archive filename.
day=$(date +%A)
hostname=$(hostname -s)

# Find which week of the month 1-4 it is.
day_num=$(date +%-d)
if (( $day_num <= 7)); then
	week_file="$hostname-week1.tgz"
elif (( $day_num > 7 && $day_num <= 14 )); then
	week_file="$hostname-week2.tgz"
elif (( $day_num > 14 && $day_num <= 21 )); then
	week_file="$hostname-week3.tgz"
elif (( $day_num > 21 && $day_num < 32 )); then
	week_file="$hostname-week4.tgz"
fi

# Find if the Month is odd or even.
month_num=$(date +%m)
month=$(expr $month_num % 2)
if [ $month -eq 0 ]; then
	month_file="$hostname-month2.tgz"
else
	month_file="$hostname-month1.tgz"
fi

# Create archive filename.
if [ $day_num == 1 ]; then
	archive_file=$month_file
elif [ $day != "Saturday"  ]; then
	archive_file="$hostname-$day.tgz"
else
	archive_file=$week_file
fi

# Print start status message.
echo
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

# Backup Docker configuration files using tar.
tar czf $dest/$archive_file $backup_files

# Backup each Docker volume.
for volume in "${volumes[@]}"; do
    volume_backup_file="$dest/${volume}-${archive_file}"
    echo "Backing up Docker volume $volume to $volume_backup_file"
    docker run --rm -v ${volume}:/data -v $dest:/backup busybox tar czf /backup/${volume}-${archive_file} /data
done

# Print end status message.
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest/
