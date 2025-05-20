\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bureau_po_report}[2025-05-20 Bureau Paranatural Object file v0.1]
\LoadClass[a4paper,14pt]{extarticle}


% all required packages
\RequirePackage[margin=1.5cm]{geometry}
\RequirePackage{graphicx}
\RequirePackage{wrapfig}
\RequirePackage{tabularx}
\RequirePackage{fontspec}
\RequirePackage{xcolor}
\RequirePackage{censor}
\RequirePackage[autostyle,english=british]{csquotes}


% fonts
\setromanfont{Century}
\setmonofont{Courier New}
\setsansfont{Agency FB}


% general style
\renewcommand{\familydefault}{\sfdefault}
\frenchspacing
\MakeOuterQuote{"}
\setlength{\parindent}{0pt}

% pagestyle
\pagenumbering{gobble}

% heading: exists to consistently style sections; FIXME: improve this, shouldn't be hard
\DeclareRobustCommand\heading[1]{
    \vspace{0.8cm}
    \Large\textbf{#1}\normalsize
    \vspace{0.2cm}
}

% makeimage: add image to page
\def\makeimage{
    \begin{wrapfigure}{r}{0.33\textwidth}
        \includegraphics[width=0.3\textwidth]{\@image}
    \end{wrapfigure}}

% redefine \maketitle command
\renewcommand\maketitle{
    \begin{tabularx}{\textwidth}{X X X}
        \includegraphics[width=0.15\textwidth]{images/Seal_of_The_Bureau.png} &
        \centering\MakeUppercase{\textbf{\@clearance}}                        &
        \textbf{\hfill\@date}                                                   \\
                                                                              &
                                                                              &
        \textbf{\@author\hfill}
    \end{tabularx}
    % \hrule
    \begin{center}
        \LARGE\textbf{\@title{} (PO\@id)}
    \end{center}
}


% custom variables: author, clearance, date, title, id, image
% set default values: author, clearance, date, title, id
\gdef\@author{[author placeholder]}
\gdef\@clearance{[clearance placeholder]}
\gdef\@date{[date placeholder]}
\gdef\@title{[title placeholder]}
\gdef\@id{[id placeholder]}
% setter commands
\DeclareRobustCommand\author[1]{\gdef\@author{#1}}
\DeclareRobustCommand\clearance[1]{\gdef\@clearance{#1}}
\DeclareRobustCommand\date[1]{\gdef\@date{#1}}
\DeclareRobustCommand\title[1]{\gdef\@title{#1}}
\DeclareRobustCommand\id[1]{\gdef\@id{#1}}
\DeclareRobustCommand\image[1]{\gdef\@image{#1}}

% option to remove censoring
\DeclareOption{unredact}{
    \StopCensoring
}

% option to use typewriter font
\DeclareOption{typewriter}{
    \setmonofont{Century modern TT}
    \renewcommand{\familydefault}{\ttdefault}
}

% process options
\ProcessOptions