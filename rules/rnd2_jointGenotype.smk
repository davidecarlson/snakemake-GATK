rule genotype_rnd2:
        input:
            gvcf=config['results_loc']+"/gvcf/all.recal.g.vcf.gz",
            ref=REF
        output:
            vcf=config['results_loc']+"/vcfs/all.recal.vcf.gz"
        log:
            config['results_loc']+"/logs/jointgenotype/genotype.rnd2.log"
        params:
            java_opts="-Xmx12G",
            extra="--include-non-variant-sites true"
        wrapper:
            "0.50.4/bio/gatk/genotypegvcfs"

