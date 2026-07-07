# Changelog

All notable changes to this project will be documented in this file.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Changed

- Generalized the workflow from being hardcoded to *Synechocystis* sp.
  PCC6803 to supporting any organism, using *Nostoc* sp. PCC7120 as the
  new default worked example:
  - `rapdorconfig.yml`: retargeted `tax_id`, `genus`, `keggOrgID`, `gff`,
    and the tRNA regex in `highlight` from Synechocystis to Nostoc values;
    added explanatory comments pointing to the NCBI Taxonomy and KEGG
    organism-list lookup pages.
  - `motifEnrichment.yml`: retargeted `Fasta` to the Nostoc genome file.
  - `README.md`: replaced the old one-line "Visualization" section with a
    new "Configuring for a different organism" section — a field-by-field
    guide plus parallel Synechocystis/Nostoc config examples.
  - `rules/transmembrane.smk`: flagged the `downloadSynProteinDistribution`
    / `convertSynProteinDistribution` rules as Synechocystis-specific,
    with a note that other organisms need their own proteomics data.
- Applied consistent code formatting (2-space indentation, spacing around
  `=`, multi-line function-call layout) across `Rscripts/*.R`
  (`GSEA.R`, `calcSemSim.R`, `checkTransmembrane.R`, `createAnnotation.R`,
  `deseq.R`, `downloadKEGGdb.R`, `extractDESeqResult.R`, `goEnrichment.R`,
  `installClusterProfiler.R`, `keggEnrichment.R`) — no functional changes.
- Removed trailing empty-value tabs from the
  `testdata/ensgene_to_uniprot.tsv` test fixture.

### Fixed

- Removed stray trailing blank lines / missing final newlines in
  `multilevelDESeq.smk`, `runComparison.smk`, `runRAPDOR.smk`,
  `rules/leastSig.smk`, and `example_layout.py`.
