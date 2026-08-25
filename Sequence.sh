# Installation & update
sudo apt update 
sudo apt install sra-toolkit -y
sudo apt install bwa samtools bcftools fastqc trimmomatic -y

# Download the fastq sequence
fasterq-dump SRR39453243 --split-files  
prefetch SRR39453243   
ls -lh  

# Convert in compressed format
gzip SRR39453243_1.fastq 
gzip SRR39453243_2.fastq 
