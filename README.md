# MAS-Seq for single-cell isoform sequencing

The Multiplexed Arrays Sequencing (MAS-Seq) method, as described by Al’Khafaji et al. in 2021, is a technique designed to increase throughput by concatenating cDNA molecules into longer fragments. These concatenated molecules are then sequenced using HiFi sequencing, and bioinformatics tools are employed to deconcatenate the sequences back into their original cDNA sequences. This approach enhances throughput and reduces the sequencing requirements, making single-cell isoform sequencing more cost-effective. PacBio HiFi reads sequence full-length RNA isoforms along with single-cell barcode and UMI information, revealing isoform diversity at the single-cell level.

In the SF_MAS-SC workflow, full-length cDNA sequences are processed and classified against a reference annotation database. This classification allows for the identification of novel genes and isoforms. The output of this process includes count matrices at both the gene and isoform levels, which are compatible with tertiary analysis software [Seurat](https://satijalab.org/seurat/articles/pbmc3k_tutorial.html). This workflow enables comprehensive analysis of single-cell transcriptomes, providing valuable insights into gene expression and isoform diversity at the single-cell level.

[![Snakemake](https://img.shields.io/badge/snakemake-≥5.7.0-brightgreen.svg)](https://snakemake.bitbucket.io)
[![Build Status](https://travis-ci.org/snakemake-workflows/SF_MAS-SC.svg?branch=master)](https://travis-ci.org/snakemake-workflows/SF_MAS-SC)


## Authors

* Sulbha Choudhari (@choudharis2)


### Step 1: Obtain a copy of this workflow

[Clone](https://help.github.com/en/articles/cloning-a-repository) the newly created repository to your local system, into the place where you want to perform the data analysis.

### Step 2: Configure workflow

Configure the workflow according to your needs via editing the files in the `config/` folder. Adjust `config.yaml` to configure the workflow execution.

### Step 3: Install Snakemake

Install Snakemake using [conda](https://conda.io/projects/conda/en/latest/user-guide/install/index.html):

    conda create -c bioconda -c conda-forge -n $NAME snakemake

For installation details, see the [instructions in the Snakemake documentation](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html).

### Step 4: Execute workflow

Activate the conda environment:

    conda activate $NAME

Test your configuration by performing a dry-run via

    snakemake --use-conda -n

Execute the workflow locally via

    snakemake --use-conda --cores $N

See the [Snakemake documentation](https://snakemake.readthedocs.io/en/stable/executable.html) for further details.

### Step 5: Investigate results

After successful execution, you can create a self-contained interactive HTML report with all results via:

    snakemake --report report.html

To access the results, including files, plots and tables, navigate to the `results` folder.

### References
1:	Al'Khafaji et al., (2021) High-throughput RNA isoform sequencing using programmable cDNA concatenation. bioRxiv, 10.01.462818

2:	https://www.pacb.com/wp-content/uploads/Application-note-MAS-Seq-for-single-cell-isoform-sequencing.pdf

3:	https://isoseq.how/


## Contact
CCRSF_IFX@nih.gov
