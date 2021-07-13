#touch output file so that the sample wildcard is propagated to the next step
rule samtools_index:
        input:
            bam=config['results_loc']+"/bams/{sample}.sorted.RG.bam"
        output:
            index=config['results_loc']+"/bams/{sample}.sorted.RG.bam.bai"
        threads:
            6
        shell:  "samtools index -@ {threads} {input.bam} && touch {output.index}"
