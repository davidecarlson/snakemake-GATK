rule calc_depth:
    input:
        bam=config['results_loc']+"/bams/{sample}.sorted.RG.bam",
        index=config['results_loc']+"/bams/{sample}.sorted.RG.bam.bai"
    output:
        depth=config['results_loc']+"/bams/{sample}.mosdepth.summary.txt"
    log:
        config['results_loc']+"/logs/mosdepth/{sample}.calcdepth.log"
    params:
        prefix=config['results_loc']+"/bams/{sample}"
    threads:    5
    shell:
        "mosdepth -n --threads {threads} {params.prefix} {input.bam} 2> {log}"
