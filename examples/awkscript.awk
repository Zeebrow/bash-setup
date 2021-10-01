#!/usr/bin/awk -f
## Random awk script
# This script deletes lines between some  "<script></script>" and "<script>" html tags
# once upon a time it served a purpose, keeping it around since I rarely 
# use awk in scripts.
#
# It also implements a pattern I use frequently to CRUD file data (see wish/mddb)
#
## Notes
# Not 100% convinced this particular script is infaliable,
# but the resulting html rendered, and w/o script tags, so hooray
BEGIN{
  # no such thing as "assigning booleans" in awk
  true=(0!=1)
  false=(0==1)

  printme=true
}
{
  if (printme==true && $0 !~ /<script.*>/) print $0;
  # next skips to next line iteration, like continue in other loops
  if ($0 ~ /^<script.*>/ && $0 ~ /<script\/>/) next; 
  if ($0 ~ /<script.*>/) printme=!printme;
  if ($0 ~ /<\/script>/) printme=!printme;
}

END{}


# awk scripts structured like
# BEGIN{}
# {}
# END{}
