#!/usr/bin/env bash

test -z $BASH && ( echo '!! bash is required !!'; )

mkdir -p inputs/bacteria
pushd inputs/bacteria/

#SRC:https://www.ncbi.nlm.nih.gov/genome/doc/ftpfaq/#allcomplete
mkdir -p tmp/
wget -P tmp/ ftp.ncbi.nlm.nih.gov/genomes/genbank/bacteria/assembly_summary.txt
awk -F "\t" '$12=="Complete Genome" && $11=="latest"{print $20}' tmp/assembly_summary.txt > tmp/ftpdirpaths
awk 'BEGIN{FS=OFS="/";filesuffix="genomic.fna.gz"}{ftpdir=$0;asm=$10;file=asm"_"filesuffix;print ftpdir,file}' tmp/ftpdirpaths > tmp/ftpfilepaths
sed -i.bak 's#^ftp://##' tmp/ftpfilepaths


#SRC:http://stackoverflow.com/a/11850469
mkdir -p GbBac2/
ls GbBac2/* || ( xargs -a tmp/ftpfilepaths -t -n 1 -P 100 wget -q -P GbBac2/ ; gunzip GbBac2/*.gz )

popd
