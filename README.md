# Genome Assembly

## The following are the procedures used to assemble the forward and reverse reads in paired-end mode.

1. Download reads to laptop from Google Drive.
2. Place in a project directory:
```bash
mkdir ANGELIKA
mv [WI][2-5]*fasta ANGELIKA
```
3. Compress reads:
```bash
gzip ANGELIKA/*fasta
```
4. Transfer reads to supercomputer:
```bash
scp -r ANGELIKA farman@xxx.uky.edu:
```
5. Uncompress reads:
```bash
gunzip ANGELIKA/*fasta
```
6. Use [velvetFasta.sh](/scripts/velvetFasta.sh) script to assemble reads with velvetoptimiser 2.2.6 running velvet 1.2.10. Note that no quality filtering or adaptor trimming was used because there are no quality scores in .fasta format reads and information on any barcodes used in the project were not provided. 
```bash
for f in I2 I3 I4 I5 W2; do sbatch $scripts/velvetFasta.sh ANGELIKA $f; done
```
7. Move assembly directories to ANGELIKA directory:
```bash
mv [WI][2-5] ANGELIKA/
```
8. Copy data to Teams directory:
```bash
module load ccs/rclone/1.59.2
rclone copy ANGELIKA farmanlab2:ANGELIKA
```
