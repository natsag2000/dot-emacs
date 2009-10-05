;; -*- emacs-lisp -*-

;; -----------------------------------------------------------------------------
;; Sekeleton буюу арьснууд
;;
;; эд нар нь функц дуудангуут орлуулга хийдэг үйлдлүүд билээ
;; миний хуулбарласан оригинал тайлбар нь:
;;
;; The following skeletons can be called by their function names.  To
;; add a new one I suggest looking at latex-brief-article-skeleton as
;; an example.  To have more than one variable look to
;; latex-letter-skeleton as a model.
;;
;; These can be added to the menu bar as above file using
;; easy-menu-add-item.
;;
;; http://www.math.umd.edu/~halbert/dotemacs.html
;; -----------------------------------------------------------------------------

;; тайлбар хэсэг орлуулах функц
;; --------------------------------
(define-skeleton elisp-separator-skeleton
  "Inserts a separator for elisp file."
  nil
  ";; -----------------------------------------------------------------------------\n"
  ";; "_"\n"
  ";; -----------------------------------------------------------------------------\n"
  )

(defun latex-letter-skeleton (receivers-address)
  "Inserts a LaTeX letter skeleton into current buffer.  This
  only makes sense for empty buffers."
  (interactive "MReceiver's Address? ")
  (skeleton-insert
   '(nil                ;no prompt
     "\\documentclass[12pt]{letter}\n"
     "\\usepackage[margin=1in]{geometry}\n"
     "\\usepackage{pdfsync}\n"
     "% Some of the article customisations are relevant for this class\n"
     "\n"
     "\\name{S.Natsagdorj} % return address on the envelope\n"
     "\\signature{S. Natsagdorj} % Goes after the closing\n"
     "\\address{Address}\n"
     "\n"
     "%\\makelabels % this command prints envelope labels on the final\n"
     "            % page of the document\n"
     "\n"
     "\\begin{document}\n"
     "\\begin{letter}{"receivers-address"}\n"
     "\n"
     "\\opening{" _ "} % eg Hello.\n"
     "\n"
     "\n"
     "\n"
     "\\closing{} % eg Regards,\n"
     "\n"
     "%\\cc{} % people this letter is cc-ed to\n"
     "%\\encl{} % list of anything enclosed\n"
     "%\\ps{} % any post scriptums.\n"
     "\n"
     "\\end{letter}\n"
     "\\end{document}\n")))

(define-skeleton latex-simple-text-skeleton
  "inserts a simple blank page skeleton."
  nil
  "\\documentclass{article}\n"
  "\\usepackage{geometry}\n"
  "\\geometry{margin=1in}\n"
  "\\usepackage{graphicx}\n"
  "\\usepackage{shortcuts}\n"
  "\\usepackage{pdfsync}\n"
  "\\usepackage{amssymb, amsmath, latexsym}\n"
  "\\setlength{\\parskip}{2.3ex}            % vertical space between paragraphs\n"
  "\\setlength{\\parindent}{0in}            % amount of indentation of paragraph\n"
  "%this package allows for hyperlinks within the pdf document\n"
  "\\usepackage[colorlinks=true, linkcolor=blue,pdfstartview=FitV,\n"
  "citecolor=gray40, urlcolor=blue]{hyperref}\n"
  "\n"
  "\\begin{document}\n"
  "\\thispagestyle{empty}\n"
  "\\begin{center}\n"
  "  \\large{\\textbf{Title}}\n"
  "\\end{center}\n"
  "\n"
  "An example of a\n"
  "\\href{http://www.math.umd.edu/research/spotlight}{hyperlink} is\n"
  "given here.\n"
  _"\n"
  "\\end{document}\n")

(define-skeleton elisp-skeleton
  "Inserts a elisp skeleton."
  nil
  ";;; " (file-name-nondirectory buffer-file-name) "--- \n"
  ";;\n"
  ";;\n"
  ";;\n"
  ";; Author: " (user-full-name) "\n"
  ";;\n"
  ";;; Commentary:\n"
  ";; "_"\n"
  ";; \n"
  ";;; Code:\n")

(define-skeleton latex-foils-skeleton
  "Inserts a template for foiltex slides."
  nil
  "\\documentclass{foils}\n"
  "\\usepackage{amssymb, amsmath}\n"
  "\\usepackage{graphicx}\n"
  "\\usepackage[mathscr]{eucal}\n"
  "\\usepackage{pb-diagram}\n"
  "\\usepackage{shortcuts}\n"
  "\\usepackage{pdfsync}\n"
  "\\usepackage{color}\n"
  "\\pagenumbering{arabic}\n"
  "\n"
  "\\title{"_"}\n"
  "\\author{S.Natsagdorj}\n"
  "\\date{\\today}\n"
  "\n"
  "\\MyLogo{-- Short Talk Title --}\n"
  "%\\Restriction{}\n"
  "%\\leftfooter{} \n"
  "%\\rightfooter{}\n"
  "%\\leftheader{S.Natsagdorj}\n"
  "%\\rightheader{\\foiltexdate}\n"
  "\n"
  "\\begin{document}\n"
  "\\maketitle\n"
  "\\foilhead{}                     %References\n"
  "\\nocite{chorin2002}\n"
  "\\nocite{zwanzig:1960}\n"
  "\\nocite{zwanzig:1961}\n"
  "\n"
  "\\bibliographystyle{amsplain}\n"
  "\\bibliography{research}\n"
  "\\foilhead{Overview}\n"
  "\\begin{itemize}\n"
  "\\item \n"
  "\\end{itemize}\n"
  "\n"
  "\\rotatefoilhead{}               %landscape slide\n"
  "\n"
  "\\rotatefoilhead[-1in]{}         %landscape with adjustment\n"
  "\n"
  "\\begin{center}\n"
  "  \\Large{The End.}\n"
  "\\end{center}\n"
  "\\end{document}\n")

(define-skeleton latex-AMS-article-skeleton
  "Inserts a AMS LaTeX skeleton for an article."
  nil
  "\\documentclass[10pt]{amsart}\n"
  "\\usepackage{amssymb,latexsym}\n"
  "\\usepackage{graphicx}\n"
  "\\usepackage{shortcuts}\n"
  "\\usepackage{pdfsync}\n"
  "\\usepackage[mathscr]{eucal}\n"
  "\\thispagestyle{empty}\n"
  "\n"
  "%%% PAGE DIMENSIONS\n"
  "\\usepackage{geometry} % to change the page dimensions\n"
  "\\geometry{margin=0.75in} % for example, change the margins to 2 inches all round\n"
  "%\\geometry{landscape} % set up the page for landscape\n"
  "% read geometry.pdf for detailed page layout information\n"
  "\n"
  "\\newtheorem{theorem}{Theorem}\n"
  "\\newtheorem{corollary}[theorem]{Corollary}\n"
  "\\newtheorem{definition}{Definition}\n"
  "\\newtheorem{lemma}{Lemma}\n"
  "\\theoremstyle{remark}\n"
  "\\newtheorem{remark}{Remark}\n"
  "\n"
  "\\begin{document}\n"
  "\\title[short-title]{long title}\n"
  "\\author{S.Natsagdorj}\n"
  "\\address{Mathematics Department\\\\\n"
  "        University of Maryland\\\\\n"
  "        College Park, MD 20742}\n"
  "\\email{halbert@math.umd.edu}\n"
  "\\urladdr{http://www.math.umd.edu/$\\sim$halbert}\n"
  "\\thanks{This work was done ...}\n"
  "\\date{\\today}\n"
  "\\begin{abstract}\n"
  > _ \n
  "\\end{abstract}\n"
  "\\maketitle\n"
  "\n"
  "\n"
  "\\bibliographystyle{amsplain}\n"
  "\\bibliography{bib-database}\n"
  "\\end{document}\n")

(define-skeleton latex-brief-article-skeleton
  "Inserts a LaTeX skeleton for a brief article."
  "Title: "
  "\\documentclass[11pt]{article}\n"
  "\\usepackage{geometry}                % See geometry.pdf to learn the\n"
  "                                     % layout options. There are lots.\n"
  "\\geometry{letterpaper} \n"
  "% \\geometry{landscape} % Activate for for rotated page geometry\n"
  "% \\usepackage[parfill]{parskip} % Activate to begin paragraphs with an\n"
  "                                % empty line rather than an indent\n"
  "\\usepackage{graphicx}\n"
  "\\usepackage{amssymb}\n"
  "\\usepackage{epstopdf}\n"
  "\\usepackage{pdfsync}\n"
  "\\usepackage{shortcuts}\n"
  "\n"
  "\\DeclareGraphicsRule{.tif}{png}{.png}{`convert #1 `dirname #1`/`basename #1 .tif`.png}\n"
  "\n"
  "\\title{"str | "Brief Article""}\n"
  "\\author{S.Natsagdorj}\n"
  "% \\date{} % Activate to display a given date or no date\n"
  "\n"
  "\\begin{document}\n"
  "\\maketitle\n"
  "%\\section{}\n"
  "%\\subsection{}\n"
  "\n"
  > _ "\n"
  "\n"
  "\\end{document}\n")