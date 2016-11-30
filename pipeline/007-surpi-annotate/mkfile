all:V:
	./targets | xargs mk

results/annotate/%.sam:D:	data/%.sam
	mkdir -p `dirname $target`
	cores=1
	taxonomy_db_directory=/labs/mksurpi/reference/taxonomy
	./taxonomy_lookup.pl \
		"$prereq" \
		sam \
		nucl \
		"$cores" \
		"$taxonomy_db_directory" \
	&& ./sort-by-organism 'data/'"$stem"'.all.annotated' > "$target";
	rm 'data/'"$stem"'.all.annotated'
