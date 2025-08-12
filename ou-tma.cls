\ProvidesClass{ou-tma}

\LoadClass{article}

\usepackage[a4paper, margin=1.4in]{geometry}

% Required packages
\usepackage[numbered]{bookmark}
\usepackage{fancyhdr}
\usepackage{xifthen}
\usepackage{setspace}

% Internationalisation
\usepackage[UKenglish]{babel,isodate}

% Use a modern font family and font expansion
\usepackage{lmodern}
\renewcommand*\familydefault{\sfdefault}
\usepackage[T1]{fontenc}
\usepackage[nopatch=footnote]{microtype}

% Don't indent first line in a paragraph
\usepackage{parskip}

% Functions to set and present course and TMA info 
\makeatletter
    
    % Setters
    \newcommand{\student}[1]{\def \@student {#1}}         % Name                    eg. John Smith
    \newcommand{\email}[1]{\def \@email {#1}}             % Email                   eg. john@example.com
    \newcommand{\identifier}[1]{\def \@identifier {#1}}   % Personal Identifier     eg. B1234567
    \newcommand{\course}[1]{\def \@course {#1}}           % Course                  eg. S282
    \newcommand{\coursetitle}[1]{\def \@coursetitle {#1}} % Course title            eg. Astronomy
    \newcommand{\tma}[1]{\def \@tma {#1}}                 % TMA number              eg. 1
    \newcommand{\tmapart}[1]{\def \@tmapart {#1}}         % TMA Part (Optional)     eg. 1
	
    % Returns sudent name and PI number
    \newcommand{\studentinfo}{
        \href{mailto:\@email}{\@student} (\@identifier)
    }
	
    % Returns the course title and TMA number
    \newcommand{\tmatitle}{
        \@course \space \@coursetitle \space - TMA\two@digits{\@tma}
        \ifdefined \@tmapart
            \space - Part \@tmapart
        \fi
    }
    
    \AtBeginDocument{
        \hypersetup{
            hidelinks,
            pdftitle = {TMA\two@digits{\@tma}},
            pdfsubject = {\@course \space \@coursetitle},        		
            pdfauthor = {\@student}
        }
    }

\makeatother

% Title Page
\renewcommand{\titlepage}{
    \author{\studentinfo}
    \title{\tmatitle}
    \maketitle
    \thispagestyle{plain}
}

% Spacing
\onehalfspacing

% Header
\pagestyle{fancy}
\fancyhead[L] {\studentinfo}
\fancyhead[R] {\tmatitle}

% Question counters
\newcounter{questioncounter}
\newcounter{subquestioncounter}[questioncounter]
\newcounter{subsubquestioncounter}[subquestioncounter]

% Questions eg. 1, 2, 3... Starts a new page.
\newcommand{\question}{
    \stepcounter{questioncounter}
    \bookmark[level=0,dest=\arabic{questioncounter}]{Question \arabic{questioncounter}}
    \ifthenelse{\value{questioncounter} > 1}{\newpage \noindent}
    \noindent{\large \textbf{Question \arabic{questioncounter}.\hypertarget{\arabic{questioncounter}}}}
}

% Sub-questions eg. a, b, c...
\newcommand{\subquestion}{
    \stepcounter{subquestioncounter}
    \bookmark[level=1,dest=\arabic{questioncounter}.\alph{subquestioncounter}]{\alph{subquestioncounter}}
    \noindent{\\ \textbf{\alph{subquestioncounter}.\hypertarget{\arabic{questioncounter}.\alph{subquestioncounter}}}}
    \nopagebreak
}

% Sub-sub-questions eg. i, ii, iii...
\newcommand{\subsubquestion}{
    \stepcounter{subsubquestioncounter}
    \bookmark[level=2,dest=\arabic{questioncounter}.\alph{subquestioncounter}.\roman{subsubquestioncounter}]{\roman{subsubquestioncounter}}
    \noindent{\\ \textbf{\roman{subsubquestioncounter}.\hypertarget{\arabic{questioncounter}.\alph{subquestioncounter}.\roman{subsubquestioncounter}}}}
    \nopagebreak
}
