#SAMPLES,INTERVALS, = glob_wildcards(config['results_loc']+"/gvcf/{sample}/{id}.g.vcf.gz")

#print(INTERVALS)

rule gather_vcf:
    input:
        vcf_dir=config['results_loc']+"/gvcf/{sample}"
    output:
        combined_vcf=config['results_loc']+"/gvcf/{sample}.combined.g.vcf.gz"
    log:
        config['results_loc']+"/logs/bcftools/{sample}.merge.rnd1.log"
    params:
        tempdir=config['results_loc']+"/gvcf/{sample}_temp"
    shell:
        "mkdir {params.tempdir} && bcftools concat {input.vcf_dir}/*.vcf.gz | bcftools sort -m 12G -T {params.tempdir} -Oz -o {output.combined_vcf} 2> {log}"
