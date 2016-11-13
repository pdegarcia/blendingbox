BASENAME=journal_compsoc
NAME=journal_compsoc.tex
pdflatex -shell-escape $NAME
bibtex $BASENAME
makeglossaries $BASENAME
pdflatex -shell-escape $NAME
pdflatex -shell-escape $NAME
