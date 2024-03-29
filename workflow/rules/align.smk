rule pbmm2:
    input: "results/" + sample + ".dedup.bam"
    output: "results/" + sample + ".mapped.bam"
    params: config['ref']
    conda: "envs/pbmm2.yaml" 
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/" + sample + ".pbmm2.log"
    shell: "pbmm2 align --preset ISOSEQ --sort -j {threads} {input} {params} > {output} 2>{log}"


rule collapse:
    input: "results/" + sample + ".mapped.bam"
    output: gff = "results/" + sample + ".collapsed.gff" , flnc = "results/" + sample + ".collapsed.abundance.txt",  group = "results/" + sample + ".collapsed.group.txt", fasta = "results/" + sample + ".collapsed.fasta"
    conda: "envs/isoseq3.yaml" 
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/"  + sample + ".collapse.log"
    shell:"isoseq3 collapse -j {threads} {input} {output.gff} 2>{log}"

rule sort:
    input: "results/" + sample + ".collapsed.gff"
    output: "results/" + sample + ".collapsed.sorted.gff"
    conda: "envs/pigeon.yaml" 
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/" + sample + ".sort.log"
    shell: "pigeon sort -o {output} {input} 2>{log}"

