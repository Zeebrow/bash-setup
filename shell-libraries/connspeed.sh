#!/bin/bash

connspeed(){
  [ -z "$1" ] && echo no. && exit 1

  time curl -w "\ncontent_type=%{content_type}\nfilename_effective=%{filename_effective}\nftp_entry_path=%{ftp_entry_path}\nhttp_code=%{http_code}\nhttp_connect=%{http_connect}\nlocal_ip=%{local_ip}\nlocal_port=%{local_port}\nnum_connects=%{num_connects}\nnum_redirects=%{num_redirects}\nredirect_url=%{redirect_url}\nremote_ip=%{remote_ip}\nremote_port=%{remote_port}\nsize_download=%{size_download}\nsize_header=%{size_header}\nsize_request=%{size_request}\nsize_upload=%{size_upload}\nspeed_download=%{speed_download}\nspeed_upload=%{speed_upload}\nssl_verify_result=%{ssl_verify_result}\ntime_appconnect=%{time_appconnect}\ntime_connect=%{time_connect}\ntime_namelookup=%{time_namelookup}\ntime_pretransfer=%{time_pretransfer}\ntime_redirect=%{time_redirect}\ntime_starttransfer=%{time_starttransfer}\ntime_total=%{time_total}\nurl_effective=%{url_effective}\n\n" -o /dev/null -s --head "$1"
}

export -f connspeed

