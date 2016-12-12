shell.prefix("set -euo pipefail;")
configfile: "config.yaml"

SAMPLES_PE = [x for x in config["samples_pe"]]
PAIRS = "pe_pe pe_se".split()
ENDS = "1 2".split()

BLOCK_THREADS = 99999999

snakefiles = "bin/snakefiles/"

include: snakefiles + "folders"
include: snakefiles + "clean"
include: snakefiles + "raw"
include: snakefiles + "qc"
include: snakefiles + "diginorm"
include: snakefiles + "transfuse"



rule all:
    input:
        MERGE_DIR + "merged.fa",
        files_pe = expand(
            NORM_DIR + "{sample}_{end}.fq.gz",
            sample = SAMPLES_PE,
            end = ENDS
        ),
        html= NORM_DIR + "multiqc_report.html"

        