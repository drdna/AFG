# Genome Assembly

## The following are the procedures used to assemble the foreard and reverse reads in paired-end mode.

1. Download reads to laptop:
2. Place in project directory:
```bash
mkdir ANGELIKA
mv [WI][2-5]*fasta ANGELIKA
```
3. Compress reads
```bash
gzip ANGELIKA/*fasta
```
4. Tranfer reads to supercomputer:
```bash
scp -r ANGELIKA farman@xxx.uky.edu
```
5. Use [velvetFasta.sh](/scripts/velvetFasta.sh) script to assemble reads with velvetoptimiser running velvet version 1.2.10. Note that no quality filtering or adaptor trimming was used because there is no quality information in .fasta format reads and any barcodes used in the project were not proviuded. 
```bash
for f in I2 I3 I3 I4 W2; do sbatch $scripts/velvetFasta.sh ANGELIKA $f; done
```
6. Move assembly directories to ANGELIKA directory:
```bash
mv [WI][2-5] ANGELIKA/
```
7. Copy reads to Teams directory
```bash
module load ccs/rclone/1.59.2
rclone copy ANGELIKA farmanlab2:ANGELIKA
```
