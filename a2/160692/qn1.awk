#!/usr/bin/gawk
BEGIN{
  numComments=0
  numStrings=0
  flag=0
  combo=0
  startline=0
}
{
  if ($0 ~ /\".*\".*\/\*.*\*\//) { combo=1; numStrings++; numComments++; }
  if ($0 ~ /\".*\".*\/\// ) { combo=1; numStrings++; numComments++; }
  if ($0 ~ /\/\*.*\*\/.*\".*\"/) { combo=1; numStrings++; numComments++; }
  if ($0 ~ /\/\*.*\".*\".*\\*\//) { combo=1; numComments++; }
  if ($0 ~ /\/\/.*\".*\"/) { combo=1; numComments++; }
  if ($0 ~ /\".*\/\/.*\"/) { combo=1; numStrings++; }
  if ($0 ~ /\".*\/\*.*\*\/.*\"/) { combo=1; numStrings++; }

  if (combo==0 && $0 ~ /\/\//) { numComments++; }
  if (combo==0 && $0 ~ /\/\*/ && flag==0) { flag=1; startline=NR; }
  if (combo==0 && flag==1 && $0 ~ /\*\//) { flag=0; numComments+=(NR-startline+1); }
  if (combo==0 && $0 ~ /\".*\"/) { numStrings++; }

  combo=0;
}
END{
  printf "%d-%d", numComments, numStrings
}
