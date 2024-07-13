
default:
	rm -rf *.fdb_latexmk *.fls *.log
	latexmk -interaction=nonstopmode -f -pdf -shell-escape main

clean:
	rm -rf pipe *.fdb_latexmk *.fls *.log *.aux main.pdf
	rm -rf output.txt clean.txt pipe other
	rm -rf repl
	rm -rf myProject/.lake myProject/lake-manifest.json

# get repl
setup:
	git clone https://github.com/m4lvin/repl
	cd repl && git checkout v4.9.0-bufferfix && lake build
	cd myProject && lake exe cache get && lake build