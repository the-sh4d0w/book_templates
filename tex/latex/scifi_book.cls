\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{scifi_book}[2025-05-05 SciFi book template v4]
\LoadClass[11pt,a5paper,twoside,openright]{extbook}


% all required packages
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{fontspec}
\RequirePackage[T1]{fontenc}
\RequirePackage[top=3cm,bottom=2.5cm]{geometry}
\RequirePackage[explicit]{titlesec}
\RequirePackage{linegoal}
\RequirePackage{fancyhdr}
\RequirePackage{lettrine}
\RequirePackage{etoolbox}
\RequirePackage[autostyle,english=british]{csquotes}
\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{censor}
\RequirePackage{graphicx}
\RequirePackage[pscoord]{eso-pic}
\RequirePackage{pdfpages}
\RequirePackage{standalone}


% fonts
\setromanfont{Hoefler Text}
\setmonofont{Courier New}
\setsansfont{Nunito}


% general style
\frenchspacing
\MakeOuterQuote{"}

% pagestyle; header and footers
\pagestyle{fancy}
\fancyfoot[C]{- \textsf{\small\thepage}\ -}
\fancyhead[CE]{\textsf{\footnotesize\textbf{\MakeUppercase\@author}}}
\fancyhead[CO]{\textsf{\footnotesize\textbf{\MakeUppercase{\@title}:} \MakeUppercase\@subtitle}}
\renewcommand{\headrule}{}

% chapter style; a bit weird, but it works
\titleformat{\chapter}{\LARGE\filleft}{}{}{\vspace*{-2cm}\textsf{\textbf{#1}}}
[\rule{\textwidth}{2pt}\\\vspace*{-0.5cm}\rule{\textwidth}{2pt}\vspace*{4cm}]

% fixes chapter pages not having correct footer (and header)
\patchcmd{\chapter}{\thispagestyle{plain}}{\thispagestyle{fancy}}{}{}

% dropcap style
\setcounter{DefaultLines}{3}
\renewcommand{\LettrineFontHook}{\sffamily\fontseries{bx}}


% loctimetitle: bold and right aligned on two lines; used for location and time titles
\makeatletter
\DeclareRobustCommand\loctimetitle[2]{{
            \setlength\partopsep{0em}
            \begin{flushright}
                \textsf{\textbf{#1\\#2}}
            \end{flushright}}}
\makeatother

% loctimestitle: bold and right aligned on three lines; used for location and central and local \
% time titles
\makeatletter
\DeclareRobustCommand\loctimestitle[3]{{
            \setlength\partopsep{0em}
            \begin{flushright}
                \textsf{\textbf{#1\\#2\\#3}}
            \end{flushright}}}
\makeatother

% boldright: bold right aligned text; once used for location and time titles
\makeatletter
\DeclareRobustCommand\boldright[1]{{\mbox{}\hfill\textsf{\textbf{#1}}\\}}
\makeatother

% monopar: monospace with aligned small caps paragraph; used for transmission titles
\makeatletter
\DeclareRobustCommand\monopar[2]{\noindent\texttt{#1: \parbox[t]{\linegoal}{#2}\\}}
\makeatother

% monoleft: monospace left aligned small caps text; also used for transmission
\makeatletter
\DeclareRobustCommand\monoleft[1]{\noindent\texttt{#1\\}}
\makeatother

% monocenter: monospace center with extra formatting; used for AI communication
\makeatletter
\DeclareRobustCommand\monocenter[3]{\vspace*{1em}
    \begin{tabularx}{\textwidth}{X}
        \texttt{</ #1 >> #2 />} \\
        \texttt{// #3 //}
    \end{tabularx}
    \vspace*{1em}}
\makeatother

% dropcap: big letter for start of chapter
\makeatletter
\DeclareRobustCommand\dropcap[1]{\lettrine{#1}{}}
\makeatother

% sep: seperator
\newcommand{\sep}{
    ~\\
    \begin{center}
        $\bigodot$
    \end{center}
    ~\\
}

% iddef: if variable defined
\makeatletter
\DeclareRobustCommand\ifxdef[2]{
    \ifx#1\undefined
    \else
        #2
    \fi
}
\makeatother

% cover page; first page
\makeatletter
\newcommand{\makecoverpage}{
    \setcounter{page}{0}
    \includepdf{\@cover}
}
\makeatother

% title page; always a right page
\makeatletter
\newcommand{\maketitlepage}{
    \cleardoublepage
    \vspace*{10em}
    \begin{center}
        \textsf{
            \textbf{\Huge{\@title}}\\
            \@subtitle\\
            \vspace*{6em}
            \textbf{\MakeUppercase{\@author}}
        }
    \end{center}
}
\makeatother

% information page; always a left page (and back of title)
\makeatletter
\newcommand{\makeinformationpage}{
    \newpage
    \vspace*{\fill}
    {\scriptsize\sffamily\setlength\parindent{0em}
        This book is a work of fiction. Any references to historical events, real people, or real
        places are used fictitiously. Other names, characters, places, and events are products of
        the author's imagination, and any resemblance to actual events or places or persons,
        living or dead, is entirely coincidental.\\

        Copyright \copyright{} \@date{} \@author\\

        All rights reserved. No part of this book may be reproduced or used in any manner without
        permission of the author.\\

        \ifxdef{\@covercredit}{Cover image by \@covercredit\\}
        \ifxdef{\@coveredited}{Cover edited by \@coveredited\\}

        \ifxdef{\@edition}{\@edition\\}
        \ifxdef{\@note}{\@note\\}

        \ifxdef{\@publisher}{\@publisher\\}
        \vspace*{-\baselineskip}

    }
}
\makeatother

% dedication page; always a right page
\makeatletter
\newcommand{\makededicationpage}{
    \cleardoublepage
    \hfill\begin{minipage}{0.7\linewidth}
        \vspace*{3em}
        \textsf{\@dedication}
    \end{minipage}
}
\makeatother

% redefine \maketitle command for custom front matter; cover, title, information, and dedication
\makeatletter
\renewcommand\maketitle{{
            \frontmatter
            \pagestyle{empty}
            % cover page; create if cover is set
            \ifxdef{\@cover}{\makecoverpage}
            % title page; always create
            \maketitlepage
            % information page; always create
            \makeinformationpage
            % dedication page; create if dedication is set
            \ifxdef{\@dedication}{\makededicationpage}
            \mainmatter
            \pagestyle{fancy}
        }}
\makeatother


% custom variables: cover, covercredit, title, subtitle, author, date, edition, note, dedication
\makeatletter
% set default values: title, subtitle, author, date
\gdef\@title{[title placeholder]}
\gdef\@subtitle{[subtitle placeholder]}
\gdef\@author{[author placeholder]}
\gdef\@date{[date placeholder]}
% setter commands
\DeclareRobustCommand\cover[1]{\gdef\@cover{#1}}
\DeclareRobustCommand\covercredit[1]{\gdef\@covercredit{#1}}
\DeclareRobustCommand\coveredited[1]{\gdef\@coveredited{#1}}
\DeclareRobustCommand\title[1]{\gdef\@title{#1}}
\DeclareRobustCommand\subtitle[1]{\gdef\@subtitle{#1}}
\DeclareRobustCommand\author[1]{\gdef\@author{#1}}
\DeclareRobustCommand\date[1]{\gdef\@date{#1}}
\DeclareRobustCommand\edition[1]{\gdef\@edition{#1}}
\DeclareRobustCommand\note[1]{\gdef\@note{#1}}
\DeclareRobustCommand\publisher[1]{\gdef\@publisher{#1}}
\DeclareRobustCommand\dedication[1]{\gdef\@dedication{#1}}
\makeatother