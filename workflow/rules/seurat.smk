rule seurat_nofilter:
    input: classification = "results/" + sample + "_classification.txt", group = "results/" + sample + ".collapsed.group.txt", fasta = "results/" + sample + ".dedup.fasta"
    output: directory("results/" + sample + "_classification/") # "results/" + sample + "_junctions.txt",
    params: prefix = "results/" + sample + "_classification"
    conda: "envs/pigeon.yaml" 
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/" + sample + ".seurat.log"
    shell: "pigeon make-seurat --keep-ribo-mito-genes --dedup {input.fasta} --group {input.group} {input.classification} -o {sample}_classification -j 36 -d {params.prefix} 2>{log}"

rule seurat_filter:
    input: classification = "results/" + sample + "_classification.filtered_lite_classification.txt", group = "results/" + sample + ".collapsed.group.txt", fasta = "results/" + sample + ".dedup.fasta"
    output: directory("results/" + sample + "_classification_filtered/")
    params: prefix = "results/" + sample + "_classification_filtered"
    conda: "envs/pigeon.yaml" 
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/" + sample + ".seurat_filter.log"
    shell: "pigeon make-seurat --keep-ribo-mito-genes --dedup {input.fasta} --group {input.group} {input.classification} -o {sample}_classification_filtered -j {threads} -d {params.prefix} 2>{log}"
