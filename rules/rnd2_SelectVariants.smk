MAX_MISSING = len(SAMPLES) - 1

rule select_rnd2:
        input:
            vcf=config['results_loc']+"/vcfs/all.recal.filtered.vcf.gz",
            ref=REF
        output:
            vcf=config['results_loc']+"/vcfs/all.recal.filtered.min1geno.vcf.gz"
        log:
            config['results_loc']+"/logs/selectvariants/select.rnd2.log"
        params:
            java_opts="-Xmx12G",
            missing=MAX_MISSING
        shell:
                "gatk --java-options {params.java_opts} SelectVariants -R {input.ref} -V {input.vcf} --max-nocall-number {params.missing} -O {output.vcf}  2> {log}"

