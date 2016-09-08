.PHONY: opam

opam:
	opam init
	opam install --yes merlin ocp-indent
