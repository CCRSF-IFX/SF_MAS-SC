
rule skera:
    input: rawdir + "/" + sample + ".hifi.bam"
    output: "results/" + sample + ".segmented.bam"
    params: config['MAS_SMRTbell_adapters_barcodes']
    conda: "envs/skera.yaml" 
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/"+ sample + ".skera.log"
    shell: "skera split --algorithm kmer -j {threads} --log-level INFO --log-file {log} {input} {params} {output}"

rule lima:
    input: "results/" + sample + ".segmented.bam"
    output: "results/" + sample + ".5p--3p.bam", "results/" + sample + ".lima.clips"
    params: prefix = "results/" + sample + ".bam"
    conda: "envs/lima.yaml"
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/" + sample + ".lima.log"
    shell: "lima --per-read --num-threads {threads} --isoseq --log-level INFO --log-file {log} {input} {primers} {params.prefix}"


rule itag:
    input: "results/" + sample + ".5p--3p.bam"
    output: "results/" + sample + ".tagged.bam"
    params: config['lib']
    conda: "envs/isoseq3.yaml"
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/" + sample + ".itag.log"
    shell: "isoseq3 tag --design {params} {input} {output} -j {threads} 2>{log}"

rule refine:
    input: "results/" + sample + ".tagged.bam"
    output: "results/" + sample + ".flnc.bam"
    conda: "envs/isoseq3.yaml"
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/" + sample + ".refine.log"
    shell: "isoseq3 refine --require-polya {input} {primers} {output} -j {threads} 2>{log}"
