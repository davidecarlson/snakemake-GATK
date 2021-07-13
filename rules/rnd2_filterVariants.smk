# Note:  filters taken from https://gatk.broadinstitute.org/hc/en-us/articles/360035890471-Hard-filtering-germline-short-variants
# The specific thresholds set here are based off of plotting the results and evaluating the cutoffs.  A few changes have been made to the BROAD recommendations to increase stringency

rule filter_rnd2:
        input:
            vcf=config['results_loc']+"/vcfs/all.recal.vcf.gz",
            ref=REF
        output:
            vcf=config['results_loc']+"/vcfs/all.recal.filtered.vcf.gz"
        log:
            config['results_loc']+"/logs/jointgenotype/filter.rnd2.log"
        params:
            java_opts="-Xmx12G",
            #filters={"myfilter": "QD < 2.0 || FS > 60.0 || SOR > 3.0 || MQ < 50.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" },
            filter1="QD_filter",
            filter1exp="QD < 3.0",
            filter2="FS_filter",
            filter2exp=" FS > 50.0",
            filter3="SOR_filter",
            filter3exp="SOR > 3.0",
            filter4="MQ_filter",
            filter4exp="MQ < 40.0",
            filter5="MQRS_filter",
            filter5exp="MQRankSum < -8.0",
            filter6="RPRS_filter",
            filter6exp="ReadPosRankSum < -8.0",
        shell:
            "gatk --java-options {params.java_opts} VariantFiltration -R {input.ref} -V {input.vcf} -O {output.vcf} "
            "--filter-name '{params.filter1}' --filter-expression '{params.filter1exp}' "
            "--filter-name '{params.filter2}' --filter-expression '{params.filter2exp}' "
            "--filter-name '{params.filter3}' --filter-expression '{params.filter3exp}' "
            "--filter-name '{params.filter4}' --filter-expression '{params.filter4exp}' "
            "--filter-name '{params.filter5}' --filter-expression '{params.filter5exp}' "
            "--filter-name '{params.filter6}' --filter-expression '{params.filter6exp}' 2> {log}"

