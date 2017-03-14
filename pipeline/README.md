Workflow consist in:

# 000 - barcode

Join the four lane files for illumina output
into just one forward and one reverse file.

Prepend the sample name on each line,
so that files can be merged in just one
without losing information.

**NOTE**: this feature may be replaced by some `readgroups` module,
that has this same functionality but uses true BAM features.

# 001 - trimmomatic

Remove adapter sequences, and then:

- remove low quality in leading and trailing sequences.
- remove sequences with less than 18 in average quality.

This step split the files in paired and unpaired.

# 002 - prinseq

Remove repeats using the dust algorightm.

# 003 - filter human out

Remove human sequences using snap-aligner.

# 004a - fast mode

Align to the FAST_MODE surpi reference to find pathogens.

# 007a - surpi annotate

Use SURPI taxonomy_lookup.pl to find the organisms on the alignments.

# 008a - surpi report

Use the taxonomy annotation to report the number of reads for each organism.

The output is a file counting the reads for each GI
and another counting the reads for each pathogen.

# 004b - comprehensive mode

Align the sequences to NT (characteristic sequences for a large number of organisms) using snap.

The NT reference is too large for SNAP, so the reference is splitted.

Original SURPI substracts the sequences found at each step.
mkSURPI outputs just the aligned sequences.

# 005b - sort-nt

Sort the aligned sequences by their sample name so they can be merged.

# 006b - merge

Merge the sorted sequences on all aligned files using sam format
because samtools chrashes when the headers are too long.

Then convert the sam into a bam.

# 007b - sort

Sort the bam file by read name,
in order to compare each read and select the best match.

**NOTE** preliminary results found each read aligned pretty much to the same organism.
