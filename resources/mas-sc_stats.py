

import json
import codecs
import subprocess
import os
import sys
sample = sys.argv[1]


with open("results/" + sample + '.flnc.filter_summary.report.json', 'r') as f:
    fl = json.load(f)
    for i in fl['attributes']:
        if i['id'] == "num_reads_fl":
            fl1 = str(i['value'])
        if i['id'] == "num_reads_flnc":
            fl2 = str(i['value'])
        if i['id'] == "num_reads_flnc_polya":
           fl3 = str(i['value'])

# Closing file
#f.close()


with open("results/" + sample + '.segmented.summary.json', 'r') as seg:
    segmented = json.load(seg)
    for j in segmented['attributes']:
        if j['id'] == "reads":
            ccs = str(j['value'])
        if j['id'] == "s_reads":
            seg1 = str(j['value'])
        if j['id'] == "mean_len_s_reads":
           seglen = str(j['value'])
        if j['id'] == "mean_array_size":
           segarr = str(j['value'])
        if j['id'] == "percent_full_array":
            segper = str(j['value'])



with open("results/" + sample + '.report.json', 'r') as cell:
    cells = json.load(cell)
    for k in cells['attributes']:
        if k['id'] == "median_genes_per_cell":
            c1 = str(k['value'])
        if k['id'] == "median_transcripts_per_cell":
            c2 = str(k['value'])
        if k['id'] == "total_unique_genes":
            c3 = str(k['value'])
        if k['id'] == "total_unique_transcripts":
            c4 = str(k['value'])

with open("results/" + sample + '_classification.filtered.report.json', 'r') as cell:
    cells = json.load(cell)
    for k in cells['attributes']:
        if k['id'] == "median_genes_per_cell_known":
            c1 = str(k['value'])
        if k['id'] == "median_transcripts_per_cell_known":
            c2 = str(k['value'])
        if k['id'] == "total_unique_genes_known":
            c3 = str(k['value'])
        if k['id'] == "total_unique_transcripts_known":
            c4 = str(k['value'])


with open("results/" + sample + '.bcstats.json', 'r') as bc:
    bcstat = json.load(bc)
    for l in bcstat['attributes']:
        if l['id'] == "number_of_cells":
            bc1 = str(l['value'])
        if l['id'] == "mean_reads_per_cell":
            bc2 = str(l['value'])
        if l['id'] == "median_umis_per_cell":
            bc3 = str(l['value'])



dedup =  str(subprocess.check_output('grep -c ">" ' "results/" + sample + '.dedup.fasta',shell = True).strip(), 'utf-8')
#dedup = subprocess.call('grep -c ">" ' + sample + '.dedup.fasta',shell = True)
#dedup = proc.stdout.read()
with open("results/" + sample + '.flagstat.txt') as fg:
    for line in fg:
        if 'primary mapped' in line:
            dedup_map= line.strip().split(' ')[0]

myfile = open("results/tables/" + sample + ".MAS-SC.stats.csv",'w')

header = 'Sample,HiFi,S-reads,Mean Length of S-Reads,Percentage of Reads with Full Array,Mean Array Size (Concatenation Factor),Full-Length,Full-Length Non-Chimeric Reads,Full-Length Non-Chimeric Reads with Poly-A Tail,Dedup Reads,Deduplicated Reads Mapped to Genome,Number of Cells,Mean Reads per Cell,Median UMIs Per Cell,Total Unique Genes (known genes only),Total Unique Transcripts (known transcripts only),Median Genes Per Cell,Median Transcripts Per Cell'

myfile.write(header +'\n')

lst = [sample,ccs,seg1,seglen,segper,segarr,fl1,fl2,fl3, str(dedup),dedup_map,bc1, bc2, bc3,c3, c4, c1, c2]
#lst1 = ["{:,}".format(round(float(x),2)) for x in lst[1:]]
#print (lst)
strF = ','.join(lst)
myfile.write(strF +'\n')

myfile.close()

