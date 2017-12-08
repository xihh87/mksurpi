This project is a [surpi](http://chiulab.ucsf.edu/surpi/ "Sequence-based Ultra-Rapid Pathogen Identification")
port using [mk](http://www.cs.tufts.edu/~nr/cs257/archive/andrew-hume/mk.pdf "A succesor to make.").

All the pipeline is implemented as submodules so that each step can be reused independently.

This port also:

- Is able to use paired reads.

# Usage

You should add to `data/` directory
your fastq.gz files named:

```
SAMPLE_LIBRARY_TREATMENT_PLATFORM_CENTER_L00[0-8]_R[12].fastq.gz
```

Then execute:

```
mk
```

The pipeline must give you report of bacterial pathogen abundance on your samples,
your results should be on the `results` directory.
