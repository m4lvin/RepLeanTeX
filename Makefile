
default:
	rm -rf *.fdb_latexmk *.fls *.log
	latexmk -interaction=nonstopmode -f -pdf -shell-escape main

clean:
	rm -rf pipe *.fdb_latexmk *.fls *.log *.aux main.pdf
	rm -rf output.txt clean.txt pipe other pid
	rm -rf repl
	rm -rf myProject/.lake myProject/lake-manifest.json

# get repl
setup:
	git clone https://github.com/leanprover-community/repl
	cd repl && git checkout 4fc1e6d1dda170e8f0a6b698dd5f7e17a9cf52b4 && lake build
	cd myProject && lake exe cache get && lake build

.PHONY: clean default setup
