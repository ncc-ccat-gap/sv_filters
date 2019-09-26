#! /bin/bash
set -eux

FILE_PREFIX=${JUNCTION}/${SAMPLE}

sv_utils filter ${FILE_PREFIX}.genomonSV.result.txt ${FILE_PREFIX}.genomonSV.result.filt.txt --min_tumor_allele_freq 0.05 --inversion_size_thres 1000 --simple_repeat_file ${SV_UTILS_RESOUECE}/simpleRepeat.txt.gz --remove_rna_junction --grc
sv_utils annotation ${FILE_PREFIX}.genomonSV.result.filt.txt ${FILE_PREFIX}.genomonSV.result.filt2.txt --grc --re_gene_annotatio --closest_exon --closest_coding --coding_info
python ${SV_FILTER_DIR}/filter_additional_filt2.py ${FILE_PREFIX}.genomonSV.result.filt2.txt ${FILE_PREFIX}.genomonSV.result.filt3.txt
python ${SV_FILTER_DIR}/filter_additional_filt3.py ${FILE_PREFIX}.genomonSV.result.filt3.txt ${FILE_PREFIX}.genomonSV.result.filt4.txt

###### output ######
mkdir -p ${GENOMON_DIR}
cp ${FILE_PREFIX}.genomonSV.result.txt       ${GENOMON_DIR}/
cp ${FILE_PREFIX}.genomonSV.result.filt.txt  ${GENOMON_DIR}/
cp ${FILE_PREFIX}.genomonSV.result.filt2.txt ${GENOMON_DIR}/
cp ${FILE_PREFIX}.genomonSV.result.filt3.txt ${GENOMON_DIR}/
cp ${FILE_PREFIX}.genomonSV.result.filt4.txt ${GENOMON_DIR}/

