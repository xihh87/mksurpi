NPROC=12
OBJ="NCBI/nt" \
	"NCBI/nr" \
	"taxonomy/names_scientificname.db" \
	"curated/Bacterial_Refseq_05172012.CLEAN.LenFiltered.uniq.fa" \
	"curated/hg19_rRNA_mito_Hsapiens_rna.fa" \
	"curated/rapsearch_viral_aa_130628_db_v2.12.fasta" \
	"curated/viruses-5-2012_trimmedgi-MOD_addedgi.fa" \
	"RiboClean_SNAP/snap_index_18s_rRNA_gene_not_partial/Genome_index" \
	"RiboClean_SNAP/snap_index_23s/Genome_index" \
	"RiboClean_SNAP/snap_index_28s_rRNA_gene_NOT_partial_18s_spacer_5.8s/Genome_index" \
	"curated/rdp_typed_iso_goodq_9210seqs.fa"

DIRS=COMP_SNAP/ FAST_SNAP/ RAPSearch/ RiboClean_SNAP/ taxonomy/ NCBI/ curated/

all:V: $DIRS $OBJ

%/:
	mkdir -p $stem

FAST_SNAP/snap_index_%/Genome_index: curated/%.fa
	snap-aligner index $prereq `dirname $target`

RiboClean_SNAP/snap_index_%/Genome_index: curated/%.fa
	snap-aligner index $prereq `dirname $target`

NCBI/nr: NCBI/nr.gz
	pigz -dc -k $prereq > $target

NCBI/nt: NCBI/nt.gz
	pigz -dc -k $prereq > $target

taxonomy/names_scientificname.db:	NCBI/taxdump.tar.gz	taxonomy/gi_taxid_prot.dmp	taxonomy/gi_taxid_nucl.dmp
	bsdtar -x --to-stdout -f NCBI/taxdump.tar.gz names.dmp | grep "scientific name" > taxonomy/names_scientificname.dmp
	sh -c "cd taxonomy; create_taxonomy_db.py"

taxonomy/%.dmp:	NCBI/%.dmp.gz
	pigz -dc -k $prereq > $target

curated/%.fasta: curated/%.fasta.gz.ok
	pigz -dc -k curated/$stem.fasta.gz > $target

curated/%.fa: curated/%.fa.gz.ok
	pigz -dc -k curated/$stem.fa.gz > $target

%.ok:	%
	./check-data $prereq

curated/%.gz:
	curl -o $target.md5 -s -L -C - http://chiulab.ucsf.edu/SURPI/databases/$stem.md5
	curl -o $target -s -L -C - http://chiulab.ucsf.edu/SURPI/databases/$stem || true

NCBI/n%.gz:
	curl -o $target.md5 -s -L -C - ftp://ftp.ncbi.nih.gov/blast/db/FASTA/n$stem.gz.md5
	curl -o $target -s -L -C - ftp://ftp.ncbi.nih.gov/blast/db/FASTA/n$stem.gz || true

NCBI/%.dmp.gz:
	curl -o $target.md5 -s -L -C - ftp://ftp.ncbi.nih.gov/pub/taxonomy/$stem.gz.md5
	curl -o $target -s -L -C - ftp://ftp.ncbi.nih.gov/pub/taxonomy/$stem.gz || true

NCBI/%.tar.gz:
	curl -o $target.md5 -s -L -C - ftp://ftp.ncbi.nih.gov/pub/taxonomy/$stem.gz.md5
	curl -o $target -s -L -C - ftp://ftp.ncbi.nih.gov/pub/taxonomy/$stem.gz || true

clean:
	rm -r $DIRS
