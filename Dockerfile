FROM probcomp/metaprob-clojure

USER metaprob

ENV METAPROB_DIR /home/metaprob/projects/metaprob-clojure

WORKDIR $METAPROB_DIR

COPY --chown=metaprob:metaprob ps2-metaprob-basics $METAPROB_DIR/ps2-metaprob-basics
