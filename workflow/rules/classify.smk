rule classify:
    input: flnc = "results/" + sample + ".collapsed.abundance.txt", gff = "results/" + sample + ".collapsed.sorted.gff"
    output: gff = "results/" + sample + "_classification.txt" , jnc = "results/" + sample + "_junctions.txt"
    params: ref = config['ref'], gtf = config['gtf'], polya = config['polya'], cagepeak = config['cagepeak'], prefix = sample
    conda: "envs/pigeon.yaml" 
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/" + sample + ".classify.log"
    shell: "pigeon classify -j {threads} --flnc {input.flnc} --poly-a {params.polya} --cage-peak {params.cagepeak} {input.gff} {params.gtf} {params.ref} -d results/ -o {params.prefix} 2>{log}"

rule filter:
    input: gff = "results/" + sample + ".collapsed.sorted.gff", classification = "results/" + sample + "_classification.txt"
    output: "results/" + sample + "_classification.filtered.report.json", "results/" +sample + "_classification.filtered_lite_classification.txt"
    conda: "envs/pigeon.yaml" 
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/" + sample + ".filter.log"
    shell: "pigeon filter -j {threads} -i {input.gff} {input.classification} 2>{log}"


