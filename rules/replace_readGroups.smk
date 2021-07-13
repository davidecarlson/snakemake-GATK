rule replace_RG:
    input:
        bam=config['bams']+"/{sample}.sorted.bam"
    output:
        RGbam=config['results_loc']+"/bams/{sample}.sorted.RG.bam"
    log:
        config['results_loc']+"/logs/picard/{sample}.replaceRG.log"
    params:
        #gatk=config['gatk'],
        ID="{sample}",
        LB="lib1",
        PL="Illumina",
        SM="{sample}",
        PU="unit1"
    shell:
        "picard AddOrReplaceReadGroups I={input.bam} O={output.RGbam} RGID={params.ID} RGLB={params.LB} RGPL={params.PL} RGSM={params.SM} RGPU={params.PU} 2> {log}"
