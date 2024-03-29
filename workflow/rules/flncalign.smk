rule bam2fastq:
    input: "results/" + sample + ".flnc.bam"
    output: "results/" + sample + ".flnc.fastq"
    params: "results/" + sample + ".flnc"
    conda: "envs/bam2fastq.yaml" 
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/" + sample + ".bam2fastq.log"
    shell: "bam2fastq {input} -o {params} -u 2>{log}"

rule pbmm2_flnc:
    input: "results/" + sample + ".flnc.bam"
    output: "results/" + sample + ".flnc.mapped.bam"
    params: config['ref']
    conda: "envs/pbmm2.yaml" 
    threads: 16
    log: "results/logs/"  + sample + ".pbmm2.flnc.log"
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    shell: "pbmm2 align --preset ISOSEQ --sort -j 36 {params} {input} > {output} 2>{log}"

rule pbmm2_index:
    input: "results/" + sample + ".flnc.mapped.bam"
    output: "results/" + sample + ".flnc.mapped.bam.bai"
    conda: "envs/isoseq3.yaml" 
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime']
    shell: "samtools index {input}"
