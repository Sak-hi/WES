# Quality control
fastqc SRR39453243_1.fastq.gz
fastqc SRR39453243_2.fastq.gz

# Improve quality control results and adapter trimming install fastp
Sudo apt install fastp
fastp \ 
-i SRR39453243_1.fastq.gz \ 
-I SRR39453243_2.fastq.gz \ 
-o clean_R1.fastq.gz \ 
-O clean_R2.fastq.gz \ 
--detect_adapter_for_pe \ 
-h fastp.html \ 
-j fastp.json 

# Quality control again
fastqc clean_R2.fastq.gz
fastqc clean_R1.fastq.gz

# Reference sequence of chr17
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/chromosomes/chr17.fa.gz 

# Unzip file
gunzip chr17.fa.gz 

# Index chromosome 17
bwa index chr17.fa 

# BWA MEM for alignment
bwa mem \ 
-R '@RG\tID:SRR39453243\tSM:SRR39453243\tPL:ILLUMINA' \ 
chr17.fa \ 
clean_R1.fastq.gz \ 
clean_R2.fastq.gz > aligned1.sam 
