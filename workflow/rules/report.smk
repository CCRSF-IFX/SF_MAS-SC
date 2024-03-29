rule flagstat:
    input: "results/" + sample + ".mapped.bam"
    output: "results/" + sample + ".flagstat.txt"
    conda: "envs/isoseq3.yaml" 
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "logs/" + sample + ".flagstat.log"
    shell:"samtools flagstat {input} > {output} 2>{log}"


rule report:
    input: "results/" + sample + "_classification.filtered.report.json",  "results/" + sample + ".flagstat.txt"
    output: "results/tables/" + sample + ".MAS-SC.stats.csv"
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] # , partition=config['medium']['partition']
    log: "results/logs/" + sample + ".report.log"
    params: sample = sample, stats = 'resources/mas-sc_stats.py'
    shell: "python {params.stats} {params.sample} 2>{log}"

rule kneeplot:
    input: "results/" + sample + ".bcstats.tsv"
    output: "results/plots/" + sample + ".knee.png"
    threads: 16
    resources: mem_mb=config['medium']['mem'], runtime=config['medium']['runtime'] #, partition=config['medium']['partition']
    log: "results/logs/" + sample + ".kneeplot.log"
    params: sample = "results/plots/" + sample, kneeplot = "resources/plot_knees.py"
    shell: "{params.kneeplot} -t {input} -o {params.sample} 2>{log}"
