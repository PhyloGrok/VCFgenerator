## Requires EDirect installed
## Download a list of all SRA runs associated with a specific bioproject
esearch -db sra -query "PRJNA541441" | efetch -format docsum | xtract -pattern Runs -ACC @acc  -element "&ACC" > pH.txt
