# regenerate rulegraph.svg in the repo root (this repo has no workflow/ dir).
# snakefile.smk is passed with -s (as a positional it is read as a rule name).
# example_config.yml is required: rules/setup.smk reads config["RUN_DIR"] at
# module scope, so parsing fails without a configfile even for --rulegraph.
chore:
    #!/usr/bin/env bash
    set -euo pipefail
    PYTHONHASHSEED=0 snakemake --rulegraph --forceall -s snakefile.smk --configfile example_config.yml | dot -Tsvg >rulegraph.svg
