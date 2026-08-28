# Variant calling using GATK haplotype
wget https://github.com/broadinstitute/gatk/releases/download/4.6.2.0/gatk-4.6.2.0.zip 

# Unzip file
unzip gatk-4.6.2.0.zip 

# Go inside directory 
cd gatk-4.6.2.0

# Install python 
python3 --version
python --version

# Check version again
python --version 

# Show path
which python 

# Create FASTA index
samtools faidx ../chr17.fa

# Create GATK sequence dictionary
./gatk CreateSequenceDictionary -R ../chr17.fa

# Gatk haplotype apply
./gatk GenotypeGVCFs … 

# Check if it shown
ls -lh ../chr17.fa ../chr17.fa.fai ../chr17.dict 

# Run gatk gvcf haplotype
./gatk HaplotypeCaller -R chr17.fa -I aligned.markdup.bam -O SRR39453243.g.vcf.gz -ERC GVCF

# Convert gvcf to vcf 
./gatk GenotypeGVCFs \ 
-R ../chr17.fa \ 
-V SRR39453243.g.vcf.gz \ 
-O ../SRR39453243.vcf.gz 

ls -lh ../SRR39453243.vcf.gz* 

# Header
bcftools view -H ../SRR39453243.vcf.gz | head 

# Check vcf file is valid or not
gzip -t ../SRR39453243.vcf.gz 

# Variant filtering
bcftools view -i 'QUAL>=30 && INFO/DP>=10 && INFO/MQ>=40 && INFO/QD>=2' ../SRR39453243.vcf.gz -Oz -o ../SRR39453243.filtered.vcf.gz

# Check filtered variants
bcftools view -H ../SRR39453243.filtered.vcf.gz | head

# Count filtered variants
bcftools view -H ../SRR39453243.filtered.vcf.gz | wc -l

