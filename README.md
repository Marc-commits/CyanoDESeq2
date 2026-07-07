# SynDESeq2

This repository contains snakemake workflows used to perform differential gene expression analysis using DESeq2 and
GO Term analysis via ClusterProfiler.

## Hardware requirements
SynDESeq2 only requires a standard computer with sufficient RAM depending on the analyzed dataset.

## Software requirements

### OS
SynDESeq2 is supported for Linux.

### Dependencies

The software was tested on Ubuntu 22.04 using following dependencies:

```text
conda
python=3.12.10,
snakemake
```


## Install

Fetch the Git repository and install the following dependencies

```shell
conda create -n SynDESeq2
conda activate SynDESeq2
conda install python==3.12 snakemake
```

## Running

### Demo
You can run the pipeline using the axample `airway` dataset via the following command:

```shell
snakemake -s snakefile.smk  --cores 1 --configfile example_config.yml --use-conda --conda-frontend conda
```

Note that you need to download the Git repository for that


### Using your data

You can either create a custom config.yaml file and run the Workflow as shown in the Demo or include the workflow from
github in your own snakemake file as follows:

```python
snakefile = github("domonik/SynDESeq2", path="snakefile.smk")

module syndeseq_workflow:
    snakefile: snakefile
    config: config["SynDESeqConfig"]

use rule * from syndeseq_workflow as syndeseq_*
```

This way you have access to all the rules in this workflow, or you can just generate the files via requesting them in
 your target rule:


```python
rule all:
    default_target: True
    input:
        syndeseq = rules.syndeseq_all.input,
```


## Configuring for a different organism

The workflow is designed to work with any organism available in UniProt and KEGG. The default
configuration targets **Nostoc sp. PCC7120** (`rapdorconfig.yml`). To use a different organism,
copy the config file and update the following fields:

| Field | Description | How to find it |
|---|---|---|
| `tax_id` | NCBI Taxonomy ID | Search at [https://www.ncbi.nlm.nih.gov/taxonomy](https://www.ncbi.nlm.nih.gov/taxonomy) |
| `genus` | Genus name (e.g. `"Nostoc"`) | From the taxonomy entry |
| `species` | Species epithet (e.g. `"sp"`) | From the taxonomy entry |
| `keggOrgID` | 3-letter KEGG organism code | Browse [https://www.genome.jp/kegg/catalog/org_list.html](https://www.genome.jp/kegg/catalog/org_list.html) |
| `gff` | Path to GFF3 annotation file | Download from NCBI or CyanoBase for your strain |
| `tag2Name` | Optional locus-tag → gene-name mapping CSV | Organism-specific; set to `False` if unavailable |
| `highlight` | Regex patterns for volcano plot labels | Adjust to match the gene naming conventions of your organism (e.g. tRNA genes end in `"6803t"` for Synechocystis PCC6803, `"7120t"` for Nostoc PCC7120) |

**Example — Synechocystis sp. PCC6803:**

```yaml
tax_id: 11117
genus: "Synechocystis"
species: "sp"
keggOrgID: "syn"
gff: "initialData/Synsp.gff3"
highlight: {"ribosomal proteins": ["black", "rpl|rps"], "ncRNA/sRNA": ["blue", "ncr|ncl"], "tRNA": ["purple", "6803t"]}
```

**Example — Nostoc sp. PCC7120 (default):**

```yaml
tax_id: 103690
genus: "Nostoc"
species: "sp"
keggOrgID: "ana"
gff: "initialData/Nostocsp.gff3"
highlight: {"ribosomal proteins": ["black", "rpl|rps"], "ncRNA/sRNA": ["blue", "ncr|ncl"], "tRNA": ["purple", "7120t"]}
```

> **Note:** The rules `downloadSynProteinDistribution` and `convertSynProteinDistribution` in
> `rules/transmembrane.smk` download proteomics data from a Synechocystis-specific publication.
> If you are working with a different organism you must supply your own proteomics data and adapt
> those rules.

## Visualization

The results of a workflow run can be visualized using the DEplots python package. Visit
 https://github.com/domonik/DEplots for more details.
