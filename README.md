# WES
Whole Exome Sequencing (WES) is a sequencing approach used to analyze the exome, which is the collection of protein-coding regions (exons) of genes. Although exons represent only a small portion of the human genome, they contain many variants associated with genetic disorders and other biological traits. In WES, DNA is fragmented, exonic regions are enriched using capture probes, and the enriched DNA is sequenced. The resulting sequence reads are then processed computationally to identify genetic variants such as SNVs and indels, which can be further annotated and clinically interpreted. The main purpose of WES is to efficiently identify potentially relevant coding variants without sequencing the entire genome.

The purpose of the project was to demonstrate how sequencing data can be converted into biologically and clinically interpretable genetic information through a reproducible bioinformatics workflow. The analysis aimed to identify high-confidence genetic variants, determine their potential molecular consequences, and compare candidate variants with established clinical evidence in ClinVar. In particular, the project allowed you to investigate TP53-associated variation, verify the appropriate transcript and HGVS representation, and distinguish computational predictions from clinically established classifications. Overall, the workflow demonstrates the use of bioinformatics tools for variant identification, functional annotation, validation, and clinical interpretation.

**Workflow**
┌──────────────────────────────┐
│     Raw Sequencing Reads     │
│            FASTQ             │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│      Quality Control         │
│          FastQC              │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│   Read Trimming & Cleaning   │
│           fastp              │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│          Post-QC             │
│           FastQC             │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│   Alignment to Reference     │
│          BWA-MEM             │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│       SAM → BAM              │
│         SAMtools             │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│      Sort & Index BAM        │
│         SAMtools             │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│       Mark Duplicates        │
│           Picard             │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│       Variant Calling        │
│     GATK HaplotypeCaller     │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│      Variant Filtering       │
│          bcftools            │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│      Variant Annotation      │
│           SnpEff             │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│    Clinical Interpretation   │
│           ClinVar            │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│       Final Candidate        │
│           Variants           │
└──────────────────────────────┘

**Results** 
The sequencing data were processed through a bioinformatics workflow involving quality control, read preprocessing, alignment to the chr17 reference genome, duplicate marking, variant calling, and variant quality filtering. Following functional annotation with SnpEff, one unique protein-level variant was identified in the TP53 gene from ClinVar database. The variants were characterized based on their genomic position, reference and alternate alleles, HGVS coding and protein notation, molecular consequence, and predicted impact. The identified variants included missense changes, indicating an alteration in the encoded TP53 protein. The candidate variants were subsequently cross-referenced with ClinVar to determine their previously reported clinical significance and review status. This analysis enabled the identification of TP53 variants supported by the sequencing data and their subsequent functional and clinical interpretation. 
