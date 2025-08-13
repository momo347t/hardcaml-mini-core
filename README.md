# hardcaml-mini-core

Small OCaml/Hardcaml RTL core implementing a streaming **FIR filter** with a **ready/valid**
handshake and **property-based tests**. Focus: clean APIs, test-first RTL, and sim→synth sanity.

## Quickstart
```bash
opam switch create hardcaml 5.2.0   # adapt version if needed
opam install dune hardcaml alcotest qcheck
dune runtest
```

## Repo structure
```
dune-project
rtl/        # hardcaml modules (core, interfaces)
tb/         # alcotest/qcheck property tests + wave dumps
scripts/    # build helpers
```

## License
MIT
