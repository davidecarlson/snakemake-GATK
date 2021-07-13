rule hapcaller_rnd1:
    input:
        bam=config['results_loc']+"/bams/{sample}.sorted.RG.bam",
        index=config['results_loc']+"/bams/{sample}.sorted.RG.bam.bai",
        ref=REF,
        script="scripts/parallel_hapcaller.py"
    output:
        gvcf_dir=directory(config['results_loc']+"/gvcf/{sample}")
    log:
        config['results_loc']+"/logs/hapcaller/{sample}.rnd1.log"
    threads:
        7
    shell:
        "mkdir {output.gvcf_dir} && python {input.script} --bam {input.bam} --reference {input.ref} --outdir {output.gvcf_dir} --threads {threads} 2> {log}"
