#! /usr/bin/env python

import sys

input_file = sys.argv[1]
output_file = sys.argv[2]

hout = open(output_file, 'w')
with open(input_file, 'r') as hin:

    header_line = "#"
    while header_line.startswith("#"):
        header_line = hin.readline().rstrip('\n')

    print >> hout, header_line
    header = header_line.split('\t')

    header2ind = {}
    for i in range(0, len(header)):
        header2ind[header[i]] = i

    for line in hin:
        F = line.rstrip('\n').split('\t')

        if F[1] == "178098828":
            pass

        if int(F[header2ind["Dist_To_Coding"]]) > 100: continue
        if F[header2ind["Intra_or_Inter_Gene"]] == "intergenic": continue

        if F[header2ind["Variant_Type"]] == "deletion":
            var_size = int(F[header2ind["Pos_2"]]) - int(F[header2ind["Pos_1"]]) - 1
            if F[header2ind["Inserted_Seq"]] == "---" and var_size < 20: continue
        elif F[header2ind["Variant_Type"]] == "tandem_duplication":
            var_size = int(F[header2ind["Pos_2"]]) - int(F[header2ind["Pos_1"]]) + 1
            if F[header2ind["Inserted_Seq"]] == "---" and var_size < 12: continue

        if F[header2ind["Mutation_Detection"]] != "mut" and int(F[header2ind["Max_Over_Hang_1"]]) + int(F[header2ind["Max_Over_Hang_2"]]) < 200: continue
    
        print >> hout, '\t'.join(F)

hout.close()

