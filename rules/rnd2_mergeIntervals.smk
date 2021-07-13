rule gather_vcf_rnd2:
    input:
        vcf_dir=config['results_loc']+"/gvcf/{sample}_recal"
    output:
        combined_vcf=config['results_loc']+"/gvcf/{sample}.combined.recal.g.vcf.gz"
    log:
        config['results_loc']+"/logs/bcftools/{sample}.merge.rnd2.log"
    params:
        tempdir=config['results_loc']+"/gvcf/{sample}_recal_temp"
    shell:
        "mkdir {params.tempdir} && bcftools concat {input.vcf_dir}/*.vcf.gz | bcftools sort -m 12G -T {params.tempdir} -Oz -o {output.combined_vcf} 2> {log}"
