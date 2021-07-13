rule genotype:
        input:
            gvcf=config['results_loc']+"/gvcf/all.g.vcf.gz",
            ref=REF
        output:
            vcf=config['results_loc']+"/vcfs/all.rnd1.vcf.gz"
        log:
            config['results_loc']+"/logs/jointgenotype/genotype.rnd1.log"
        params:
            java_opts="-Xmx12G"
        wrapper:
            "0.50.4/bio/gatk/genotypegvcfs"

