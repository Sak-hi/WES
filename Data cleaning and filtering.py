Import pandas as pd
# Read the variant annotation file
df1 = pd.read_csv(
    "//wsl.localhost/Ubuntu/home/sakshi/Linux/snpEff/TP53_annotation_only.tsv", sep="\t"
)

# Keep only rows where HGVS.p is present
protein_variants = df1[
    df1["HGVS.p"].notna() &
    (df1["HGVS.p"].astype(str).str.strip() != "")
].copy()

# Remove duplicate rows based on HGVS.p
unique_protein_variants = protein_variants.drop_duplicates(
    subset=["HGVS.p"]
).reset_index(drop=True)

# Display the result
display(unique_protein_variants)

# Save the result in the same folder
output_file = "//wsl.localhost/Ubuntu/home/sakshi/Linux/snpEff/TP53_unique_protein_variants.tsv"
unique_protein_variants.to_csv(
    output_file,
    sep="\t",
    index=False
)

print("Unique protein variants:", len(unique_protein_variants))
print("File saved at:", output_file)
