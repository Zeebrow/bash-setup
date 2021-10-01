#!/usr/bin/awk -f
BEGIN{
  true=(0!=1)
  false=(0==1)
  printme=true
}
{
  if (printme==true && $0 !~ /<script.*>/) print $0;
  if ($0 ~ /^<script.*>/ && $0 ~ /<\/script>/) next; # next skips to next line iteration
  if ($0 ~ /<script.*>/) printme=!printme;
  if ($0 ~ /<\/script>/) printme=!printme;
}

END{}
