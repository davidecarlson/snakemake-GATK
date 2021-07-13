rule combine_gvcfs:
        input:
            gvcfs=expand(config['results_loc']+"/gvcf/{sample}.combined.g.vcf.gz",  sample=SAMPLES),
            vcf_indexes=expand(config['results_loc']+"/gvcf/{sample}.combined.g.vcf.gz.tbi",  sample=SAMPLES),
            ref=REF
        output:
            gvcf=config['results_loc']+"/gvcf/all.g.vcf.gz"
        log:
            config['results_loc']+"/logs/combineGVCF/combine.rnd1.log"
        params:
            java_opts="-Xmx12G"
        wrapper:
            "0.50.4/bio/gatk/combinegvcfs"

