#!/usr/bin/env bash

VENV="dna2vec-test"

source activate $VENV \
  || ( conda create -y -n $VENV python=3  \
       && source activate $VENV           \
       && pip install -r requirements.txt )

/usr/bin/time -v -o "train_dna2vec_bacteria.log" \
  python ./scripts/train_dna2vec.py -c configs/bacteria-refseq.yml

source deactivate $VENV
