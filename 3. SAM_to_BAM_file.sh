# Convert SAM to BAM
samtools view -bS aligned1.sam > aligned1.bam 

# Sort BAM
samtools sort aligned1.bam -o aligned1.sorted.bam 

# BAM index
samtools index aligned1.sorted.bam 

# Read group check
samtools view -H aligned.sorted.bam | grep '^@RG' 

# Mark duplicates essential download
wget https://github.com/broadinstitute/picard/releases/latest/download/picard.jar 
java -jar picard.jar MarkDuplicates --help 
java -version 

# if java not install
sudo apt install openjdk-17-jre -y 
java -jar ~/Linux/picard.jar MarkDuplicates --version

# Mark duplicates
java -jar picard.jar MarkDuplicates \ 
I=aligned1.sorted.bam \ 
O=aligned.markdup.bam \ 
M=duplication_metrics.txt 

# Index picard output
samtools index aligned.markdup.bam

# Check BAM quality
samtools flagstat aligned.markdup.bam 

# Generate alignment stat
samtools stats aligned.markdup.bam > alignment_stats.txt 
