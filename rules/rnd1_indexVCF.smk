rule index_vcf:
    input:
        vcf=config['results_loc']+"/gvcf/{sample}.combined.g.vcf.gz"
    output:
        vcf_index=config['results_loc']+"/gvcf/{sample}.combined.g.vcf.gz.tbi"
    log:
        config['results_loc']+"/logs/vcfIndex/{sample}.index.rnd1.log"
    shell:
        "gatk IndexFeatureFile -I {input.vcf} -O {output.vcf_index} 2> {log}"
