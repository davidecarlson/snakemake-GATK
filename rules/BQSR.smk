#Recalibrate base quality scores using bootstrapped results from first round of variant calling followed by filtering

rule recal:
        input:
            known=config['results_loc']+"/vcfs/all.rnd1.filtered.snps.vcf.gz",
            ref=REF,
            bam=config['results_loc']+"/bams/{sample}.sorted.RG.bam"
        output:
            bam=config['results_loc']+"/bams/{sample}.sorted.RG.recal.bam"
        log:
            config['results_loc']+"/logs/bqsr/{sample}.recal.log"
        wrapper:
            "0.50.4/bio/gatk/baserecalibrator"

