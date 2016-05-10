NPROC=12
OBJ="NCBI/nt" \
	"NCBI/nr" \
	"taxonomy/names_scientificname.db" \
	"curated/Bacterial_Refseq_05172012.CLEAN.LenFiltered.uniq.fa" \
	"curated/hg19_rRNA_mito_Hsapiens_rna.fa" \
	"curated/rapsearch_viral_aa_130628_db_v2.12.fasta" \
	"curated/viruses-5-2012_trimmedgi-MOD_addedgi.fa" \
	"RiboClean_SNAP/snap_index_18s_rRNA_gene_not_partial/GenomeIndex" \
	"RiboClean_SNAP/snap_index_23s/GenomeIndex" \
	"RiboClean_SNAP/snap_index_28s_rRNA_gene_NOT_partial_18s_spacer_5.8s/GenomeIndex" \
	"curated/rdp_typed_iso_goodq_9210seqs.fa"

TAX_OBJS=taxonomy/nodes.dmp \
	taxonomy/names_scientificname.dmp \
	taxonomy/gi_taxid_prot.dmp \
	taxonomy/gi_taxid_nucl.dmp

DIRS=COMP_SNAP/ FAST_SNAP/ RAPSearch/ RiboClean_SNAP/ taxonomy/ NCBI/ curated/

all:V: $DIRS $OBJ


# taxonomy database
taxonomy/names_scientificname.db: $TAX_OBJS
	sh -c "cd taxonomy; create_taxonomy_db.py"

taxonomy/names_scientificname.dmp:	NCBI/taxdump.tar.gz.ok
	bsdtar -x --to-stdout -f `echo $prereq | sed -e 's#.ok##'` names.dmp \
	| grep "scientific name" > $target

taxonomy/nodes.dmp:	NCBI/taxdump.tar.gz.ok
	bsdtar -x --to-stdout -f `echo $prereq | sed -e 's#.ok##'` nodes.dmp > $target

taxonomy/gi_%.dmp:	NCBI/gi_%.dmp.gz.ok
	pigz -dc -k `echo $prereq | sed -e 's#.ok##'` > $target

# snap indexes
FAST_SNAP/snap_index_%/GenomeIndex: curated/%.fa
	snap-aligner index $prereq `dirname $target`

RiboClean_SNAP/snap_index_%/GenomeIndex: curated/%.fa
	snap-aligner index $prereq `dirname $target`

# uncompress genetic data
NCBI/nr: NCBI/nr.gz.ok
	pigz -dc -k `echo $prereq | sed -e 's#.ok##'` > $target

NCBI/nt: NCBI/nt.gz.ok
	pigz -dc -k `echo $prereq | sed -e 's#.ok##'` > $target

curated/%.fasta: curated/%.fasta.gz.ok
	pigz -dc -k `echo $prereq | sed -e 's#.ok##'` > $target

curated/%.fa: curated/%.fa.gz.ok
	pigz -dc -k `echo $prereq | sed -e 's#.ok##'` > $target

# check downloaded info
%.ok:	%
	./check-data $prereq

# download info
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

# make dirs
%/:
	mkdir -p $stem

clean:
	rm -r $DIRS
