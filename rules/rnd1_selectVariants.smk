#remove sites that failed filter and only include SNPs - for purposes of BQSR

rule selectVariants:
        input:
            vcf=config['results_loc']+"/vcfs/all.rnd1.filtered.vcf.gz",
            ref=REF
        output:
            vcf=config['results_loc']+"/vcfs/all.rnd1.filtered.snps.vcf.gz"
        log:
            config['results_loc']+"/logs/jointgenotype/select.rnd1.log"
        params:
            java_opts="-Xmx12G",
            extra="--exclude-filtered --select-type-to-include SNP"
        wrapper:
            "0.50.4/bio/gatk/selectvariants"

