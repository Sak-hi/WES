# Variant annotation need some installation
wget https://snpeff-public.s3.amazonaws.com/versions/snpEff_latest_core.zip 
ls -lh snpEff_latest_core.zip 
unzip snpEff_latest_core.zip
cd snpEff  
java -jar snpEff.jar -version 

# GENCODE annotation 
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_48/gencode.v48.annotation.gtf.gz 

# Chr17.gtf file generate 
zcat gencode.v48.annotation.gtf.gz | awk '$0 ~ /^#/ || $1=="chr17"' > chr17.gtf 

grep -w 'TP53' chr17.gtf | head 

# Copy and paste the files in new folder
cp ../chr17.fa data/GRCh38_chr17/sequences.fa 
cp ../chr17.gtf data/GRCh38_chr17/genes.gtf 

# Add custom genome
nano snpEff.config 
grep "GRCh38_chr17" snpEff.config 

# Remove extra file
rm -f 'data/GRCh38_chr17/chr17.gtf:Zone.Identifier' 

# Rename file chr17.gtf to genes.gtf
mv data/GRCh38_chr17/chr17.gtf data/GRCh38_chr17/genes.gtf 

# Build database
java -Xmx2g -jar snpEff.jar build -gtf22 -noCheckCds -noCheckProtein -v GRCh38_chr17 
ls -lh data/GRCh38_chr17/snpEffectPredictor.bin 

# Check filtered vcf file name
bcftools query -f '%CHROM\n' ../SRR39453243.filtered.vcf.gz | sort -u 

# Rename file chr17 to chr17_map
echo -e "chr17\t17" > chr17_map.txt 

# Annotate file for database
bcftools annotate --rename-chrs chr17_map.txt \ 
../SRR39453243.filtered.vcf.gz \ 
-Oz -o ../SRR39453243.filtered.17.vcf.gz 

# Check it
bcftools query -f '%CHROM\n' ../SRR39453243.filtered.17.vcf.gz | sort -u

# Run SnpEff annotation
java -Xmx2g -jar snpEff.jar \ 
-nodownload \ 
GRCh38_chr17 \ 
../SRR39453243.filtered.17.vcf.gz \ 
> ../SRR39453243.annotated.vcf 

# Check whether annotation was added to all genes
grep '##INFO=<ID=ANN' ../SRR39453243.annotated.vcf
grep -v '^#' ../SRR39453243.annotated.vcf | head

# Specifically find TP53
grep -v '^#' ../SRR39453243.annotated.vcf | grep -w 'TP53' 

# Annotation file in text format
bcftools query \ -f '%CHROM\t%POS\t%REF\t%ALT\t%QUAL\t%INFO/DP\t%INFO/AF\t%INFO/MQ\t%INFO/QD\t%INFO/ANN\n' \ ../SRR39453243.annotated.vcf > ../variant_annotation.txt 

# For all annotated genes in readable format & add transcript
bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%QUAL\t%INFO/ANN\n' \
SRR39453243.annotated.vcf |
awk -F'\t' 'BEGIN {
    OFS="\t";
    print "CHROM","POS","REF","ALT","QUAL","GENE","EFFECT","IMPACT","TRANSCRIPT","HGVS.c","HGVS.p"
}
{
    split($6,ann,",");
    for(i=1;i<=length(ann);i++){
        split(ann[i],a,"|");
        print $1,$2,$3,$4,$5,a[4],a[2],a[3],a[7],a[10],a[11]
    }
}' > SRR39453243_all_genes_annotation.tsv

# For TP53 only selects 
awk -F'\t' 'NR==1 || $6=="TP53"' \
SRR39453243_all_genes_annotation.tsv \
> TP53_annotation_table.tsv
