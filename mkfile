OBJ="NCBI/nt.gz" \
	"NCBI/nr.gz" \
	"NCBI/taxdump.tar.gz" \
	"NCBI/gi_taxid_prot.dmp.gz" \
	"curated/Bacterial_Refseq_05172012.CLEAN.LenFiltered.uniq.fa.gz" \
	"curated/hg19_rRNA_mito_Hsapiens_rna.fa.gz" \
	"curated/rapsearch_viral_aa_130628_db_v2.12.fasta.gz" \
	"curated/viruses-5-2012_trimmedgi-MOD_addedgi.fa.gz" \
	"curated/18s_rRNA_gene_not_partial.fa.gz"
	"curated/23s.fa.gz" \
	"curated/28s_rRNA_gene_NOT_partial_18s_spacer_5.8s.fa.gz" \
	"curated/rdp_typed_iso_goodq_9210seqs.fa.gz"

all: $OBJ

%/:
	mkdir -p $stem

curated/%:	curated/
	cd curated
	curl -LO -C - http://chiulab.ucsf.edu/SURPI/databases/$stem.md5 &
	curl -LO -C - http://chiulab.ucsf.edu/SURPI/databases/$stem
	md5sum -c --status $stem.md5

NCBI/n%.gz:	NCBI/
	cd NCBI
	curl -LO -C - ftp://ftp.ncbi.nih.gov/blast/db/FASTA/n$stem.gz.md5 &
	curl -LO -C - ftp://ftp.ncbi.nih.gov/blast/db/FASTA/n$stem.gz
	md5sum -c --status n$stem.md5

NCBI/%.dmp.gz:	NCBI/
	cd NCBI
	curl -LO -C - ftp://ftp.ncbi.nih.gov/pub/taxonomy/$stem.gz.md5 &
	curl -LO -C - ftp://ftp.ncbi.nih.gov/pub/taxonomy/$stem.gz
	md5sum -c --status $stem.md5

NCBI/%.tar.gz:	NCBI/
	cd NCBI
	curl -LO -C - ftp://ftp.ncbi.nih.gov/pub/taxonomy/$stem.gz.md5 &
	curl -LO -C - ftp://ftp.ncbi.nih.gov/pub/taxonomy/$stem.gz
	md5sum -c --status $stem.md5
