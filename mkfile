NPROC=12
OBJ="NCBI/nt.gz" \
	"NCBI/nr.gz" \
	"NCBI/taxdump.tar.gz" \
	"NCBI/gi_taxid_prot.dmp.gz" \
	"curated/Bacterial_Refseq_05172012.CLEAN.LenFiltered.uniq.fa" \
	"curated/hg19_rRNA_mito_Hsapiens_rna.fa" \
	"curated/rapsearch_viral_aa_130628_db_v2.12.fasta" \
	"curated/viruses-5-2012_trimmedgi-MOD_addedgi.fa" \
	"curated/18s_rRNA_gene_not_partial.fa" \
	"curated/23s.fa" \
	"curated/28s_rRNA_gene_NOT_partial_18s_spacer_5.8s.fa" \
	"curated/rdp_typed_iso_goodq_9210seqs.fa"

DIRS=COMP_SNAP/ FAST_SNAP/ RAPSearch/ RiboClean_SNAP/ taxonomy/ NCBI/ curated/

all: $DIRS $OBJ

%/:
	mkdir -p $stem

%.ok:	%
	./check-data $prereq

curated/%.gz:	curated/
	curl -o $target.md5 -s -L -C - http://chiulab.ucsf.edu/SURPI/databases/$stem.md5
	curl -o $target -s -L -C - http://chiulab.ucsf.edu/SURPI/databases/$stem || true

curated/%.fa: curated/%.fa.gz.ok
	pigz -dc -k $stem.fa.gz > $target

curated/%.fasta: curated/%.fasta.gz.ok
	pigz -dc -k $stem.fasta.gz > $target

NCBI/n%.gz:	NCBI/
	curl -o $target.md5 -s -L -C - ftp://ftp.ncbi.nih.gov/blast/db/FASTA/n$stem.gz.md5
	curl -o $target -s -L -C - ftp://ftp.ncbi.nih.gov/blast/db/FASTA/n$stem.gz || true

NCBI/%.dmp.gz:	NCBI/
	curl -o $target.md5 -s -L -C - ftp://ftp.ncbi.nih.gov/pub/taxonomy/$stem.gz.md5
	curl -o $target -s -L -C - ftp://ftp.ncbi.nih.gov/pub/taxonomy/$stem.gz || true

NCBI/%.tar.gz:	NCBI/
	curl -o $target.md5 -s -L -C - ftp://ftp.ncbi.nih.gov/pub/taxonomy/$stem.gz.md5
	curl -o $target -s -L -C - ftp://ftp.ncbi.nih.gov/pub/taxonomy/$stem.gz || true

clean:
	rm -r $DIRS
