# Soularr: searches slskd for albums Lidarr wants and hands the downloads back to Lidarr
{ config, ... }:
let
  slskdDownloads = config.nixflix.slskd.settings.directories.downloads;
in
{
  sops.templates."soularr.ini".content = ''
    [Lidarr]
    api_key = ${config.sops.placeholder.lidarr_api_key}
    host_url = http://127.0.0.1:${toString config.nixflix.lidarr.config.hostConfig.port}
    download_dir = ${slskdDownloads}
    disable_sync = False

    [Slskd]
    api_key = ${config.sops.placeholder.slskd_api_key}
    host_url = http://127.0.0.1:${toString config.nixflix.slskd.settings.web.port}
    url_base = /
    download_dir = ${slskdDownloads}
    delete_searches = False
    stalled_timeout = 3600

    [Release Settings]
    use_most_common_tracknum = True
    allow_multi_disc = True
    accepted_countries = Europe,Italy,Worldwide
    skip_region_check = False
    accepted_formats = CD,Digital Media,Vinyl

    [Search Settings]
    search_timeout = 5000
    maximum_peer_queue = 50
    minimum_peer_upload_speed = 0
    minimum_filename_match_ratio = 0.8
    allowed_filetypes = flac 24/192,flac 16/44.1,flac,mp3 320
    ignored_users =
    search_for_tracks = True
    album_prepend_artist = False
    track_prepend_artist = True
    search_type = incrementing_page
    number_of_albums_to_grab = 10
    remove_wanted_on_failure = False
    title_blacklist =
    search_source = missing

    [Logging]
    level = INFO
    format = [%(levelname)s|%(module)s|L%(lineno)d] %(asctime)s: %(message)s
    datefmt = %Y-%m-%dT%H:%M:%S%z
  '';

  systemd.tmpfiles.rules = [ "d /var/lib/soularr 0750 root root -" ];

  virtualisation.oci-containers.containers.soularr = {
    image = "docker.io/mrusse08/soularr:latest";
    environment.SCRIPT_INTERVAL = "300";
    volumes = [
      "/var/lib/soularr:/data"
      "${config.sops.templates."soularr.ini".path}:/data/config.ini:ro"
      # Same path inside and out, so the paths Soularr passes to Lidarr resolve on the host
      "${slskdDownloads}:${slskdDownloads}"
    ];
    extraOptions = [ "--network=host" ];
    log-driver = "journald";
  };
}
