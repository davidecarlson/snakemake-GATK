rule index_vcf_rnd2:
    input:
        vcf=config['results_loc']+"/gvcf/{sample}.combined.recal.g.vcf.gz"
    output:
        vcf_index=config['results_loc']+"/gvcf/{sample}.combined.recal.g.vcf.gz.tbi"
    log:
        config['results_loc']+"/logs/vcfIndex/{sample}.index.rnd2.log"
    shell:
        "gatk IndexFeatureFile -I {input.vcf} -O {output.vcf_index} 2> {log}"
