This project is a [surpi](http://chiulab.ucsf.edu/surpi/
"Sequence-based Ultra-Rapid Pathogen Identification")
port using [mk](http://www.cs.tufts.edu/~nr/cs257/archive/andrew-hume/mk.pdf
"A succesor to make.").

All the pipeline is implemented as submodules so that each step can be reused independently.

This port also:

- Is able to use paired reads.

# Prerequisites

To use this software you must have the following software installed and on your path:

- [fastQValidator](http://genome.sph.umich.edu/wiki/FastQValidator )
- [Minimo (v1.6)](http://sourceforge.net/projects/amos/files/amos/3.1.0/ )
- [Abyss (v1.3.5)](http://www.bcgsc.ca/platform/bioinfo/software/abyss )
- [RAPSearch (v2.12)](http://omics.informatics.indiana.edu/mg/RAPSearch2/ )
- [seqtk (v 1.0r31)](https://github.com/lh3/seqtk )
- [SNAP (v0.15)](http://snap.cs.berkeley.edu )
- [gt (v1.5.1)](http://genometools.org/index.html )
- [fastq](https://github.com/brentp/bio-playground/tree/master/reads-utils )
- [fqextract](https://gist.github.com/drio/1168330 )
- trimmomatic
- [prinseq-lite.pl](http://prinseq.sourceforge.net)
- [dropcache](http://stackoverflow.com/questions/13646925/allowing-a-non-root-user-to-drop-cache )
