rule combine_gvcfs_rnd2:
        input:
            gvcfs=expand(config['results_loc']+"/gvcf/{sample}.combined.recal.g.vcf.gz", sample=SAMPLES),
            gvcf_indexes=expand(config['results_loc']+"/gvcf/{sample}.combined.recal.g.vcf.gz.tbi", sample=SAMPLES),
            ref=REF
        output:
            gvcf=config['results_loc']+"/gvcf/all.recal.g.vcf.gz"
        log:
            config['results_loc']+"/logs/combineGVCF/combine.rnd2.log"
        params:
            java_opts="-Xmx12G"
        wrapper:
            "0.50.4/bio/gatk/combinegvcfs"

