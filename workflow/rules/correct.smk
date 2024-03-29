rule correct:
    input: "results/" + sample + ".flnc.bam"
    output: out = "results/" + sample + ".corrected.bam", sort = "results/" + sample + ".corrected.sorted.bam"
    params: method = config['method']
    conda: "envs/isoseq3.yaml" 
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/" + sample + ".correct.log"
    shell: """
        isoseq3 correct --method {params.method} --barcodes {whitelist} {input} {output.out} -j {threads} 2>{log}
        samtools sort -t CB {output.out} -o {output.sort} -@{threads}
        """

rule bcstats:
    input:  "results/" + sample + ".corrected.sorted.bam"
    output: out =  "results/" + sample + ".bcstats.tsv", json =  "results/" + sample + ".bcstats.json"
    params: method = config['method']
    conda: "envs/isoseq3.yaml" 
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/" + sample + ".bcstats.log"
    shell: "isoseq3 bcstats --method {params.method} --json {output.json} {input} -o {output.out} -j {threads} 2>{log}"


rule groupdedup:
    input:  "results/" + sample + ".corrected.sorted.bam"
    output: bam =  "results/" + sample + ".dedup.bam", fasta =  "results/" +  sample + ".dedup.fasta"
    conda: "envs/isoseq3.yaml" 
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/" + sample + ".groupdedup.log"
    shell: "isoseq3 groupdedup {input} {output.bam} -j {threads} 2>{log}"

