%% Copyright 2022 Souchet Ferdinand
%% 
%% Permission is hereby granted, free of charge, to any person obtaining a copy of
%% this software and associated documentation files (the "Software"), to deal in
%% the Software without restriction, including without limitation the rights to
%% use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
%% the Software, and to permit persons to whom the Software is furnished to do so,
%% subject to the following conditions:
%% 
%% The above copyright notice and this permission notice shall be included in all 
%% copies or substantial portions of the Software.
%% 
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
%% FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
%% COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
%% IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
%% CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


%% Init

\newcommand\@lang{english, french}
\newcommand\@type{}

\RequirePackage{ifthen}
\newcommand\ifdefinedelse[3]{\ifthenelse{\equal{#1}{}}{#3}{#2}}

\newboolean{comments}\setboolean{comments}{false}
\newboolean{code}\setboolean{code}{false}


%% Options


\newcommand\documenttype[1]{
    \ifthenelse{\equal{#1}{class}}{
        \geometry{
            hscale=0.85, vscale=0.82, vmarginratio=6:5
        }
    }{}
    \ifthenelse{\equal{#1}{twocolumn}}{
        \geometry{
            hscale=0.91, vscale=0.8, vmarginratio=6:5,
            landscape, twocolumn,
        }
    }{}
    \DefineFancyhdr
}

\DeclareOption{comments}{\setboolean{comments}{true}}
\DeclareOption{code}{\setboolean{code}{true}}


%% Defaults

\ProcessOptions\relax
\LoadClass{article}


%% Packets
%%%%%%%%%%


\RequirePackage{pdfpages}           % Page formatting
\RequirePackage{geometry}
\RequirePackage{fancyhdr}           % great headers

\RequirePackage{xcolor}             % Colors !!!

\RequirePackage{tcolorbox}          % BOXES !!!
\RequirePackage{varwidth}           % box max width
\RequirePackage{tikz}
\tcbuselibrary{skins,breakable}

\tcbuselibrary{skins}
\RequirePackage{titling}            % redefine title
\RequirePackage{etoolbox}           % get title names
\RequirePackage{lastpage}           % total page count
\RequirePackage{amsmath,amssymb}    % math stuff
\RequirePackage{ifthen}             % conditionals
\RequirePackage{stmaryrd}
\RequirePackage{esint}              % Integrals
\RequirePackage{cancel}             % Cross things out

% reference links
\RequirePackage{hyperref}
\RequirePackage{bookmark}


%% Colors
%%%%%%%%%

\definecolor{colordef}{cmyk}{0.81,0.62,0.00,0.22}
\definecolor{colortext}{cmyk}{0.81,0.62,0.00,0.22}


%% Translations
%%%%%%%%%%%%%%%

\newcommand\contentstitle{Table of Contents}
\renewcommand\contentsname{}


\newcommand\RedeclareMathOperator[2]{
  \let#1\relax
  \DeclareMathOperator{#1}{#2}
}


\newcommand\ttheorem{theorem}
\newcommand\tTheorem{Theorem}

\newcommand\tproperty{property}
\newcommand\tProperty{Property}

\newcommand\tlemma{lemma}
\newcommand\tLemma{Lemma}

\newcommand\tdefinition{definition}
\newcommand\tDefinition{Definition}

\newcommand\tproof{proof of}
\newcommand\tProof{Proof of}

\newcommand\texample{example}
\newcommand\tExample{Example}

\newcommand\texercise{exercise}
\newcommand\tExercise{Exercise}

\newcommand\tmethod{method}
\newcommand\tMethod{Method}


%% Info commands
%%%%%%%%%%%%%%%%

\newcommand\thecontact{}
\newcommand\contact[1]{\renewcommand\thecontact{#1}}

\newcommand\theinstitution{}
\newcommand\institution[1]{\renewcommand\theinstitution{#1}}

\newcommand\thesubtitle{}
\newcommand\subtitle[1]{\renewcommand\thesubtitle{#1}}

\newcommand\thecoauthors{}
\newcommand\coauthors[1]{\renewcommand\thecoauthors{#1}}

\newcommand\thedate{}


\newcommand\thetitle{}
\newcommand\theshorttitle{}
\renewcommand\title[2][]{
    \renewcommand\thetitle{#2}
    \renewcommand\theshorttitle{#1}
}


%% Generate title page
%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\maketitlepage}{
    \begin{center}
        \Huge
        \textbf{\thetitle}

        \ifdefinedelse{\thesubtitle}{
            \vspace{0.2cm}
            \LARGE
            \thesubtitle
        }{}

        \vspace{0.5cm}

        \Large
        \theauthor \hspace{1pt}
        \ifdefinedelse{\thecontact}{(\textit{\thecontact})}{}
            
        \ifdefinedelse{\thecoauthors}{
            \vspace{0.2cm}
            \large
            \textit{\thecoauthors}
        }{}

        \ifthenelse{\equal{\theinstitution}{} \and \equal{\thedate}{}}{}{
            \vspace{0.5cm}
        }

        \theinstitution
        
        \thedate
    \end{center}

    \vspace{0.5cm}

    \begin{tcolorbox}[arc=0pt,title=\contentstitle]
        \normalsize
        \tableofcontents
    \end{tcolorbox}
    \newpage
}


%% Headers and footers
%%%%%%%%%%%%%%%%%%%%%%

% get section names (? ty stackoverflow: https://stackoverflow.com/questions/39238993/latex-get-the-name-of-an-unnumbered-subsection)
% \pretocmd{\@startsection}% <cmd>
%   {\@namedef{@sectype}{#1}}% <pre>
%   {}{}% <success><failure>
% \patchcmd{\@sect}% <cmd>
%   {\@xsect}% <search>
%   {\@namedef{\@sectype title}{#8}\@xsect}% <replace>
%   {}{}% <success><failure>
% \patchcmd{\@ssect}% <cmd>
%   {\@xsect}% <search>
%   {\@namedef{\@sectype title}{#5}\@xsect}% <replace>
%   {}{}% <success><failure>
% \makeatother

% At first set empty section titles
\def\sectiontitle{}
\def\subsectiontitle{}
\def\subsubsectiontitle{}

% Sectio title definitions in document
\newcommand\defsection[1]{\def\sectiontitle{#1}\section{#1}}
\newcommand\defsubsection[1]{\def\subsectiontitle{#1}\subsection{#1}}
\newcommand\defsubsubsection[1]{\def\subsubsectiontitle{#1}\subsubsection{#1}}


\newcommand\DefineFancyhdr{
    \pagestyle{fancy}

    % Header
    \fancyhead{}
    \setlength{\headheight}{14pt}
    \fancyhead[L]{\textbf{\ifdefinedelse{\theshorttitle}{\theshorttitle}{\thetitle}}}
    \fancyhead[R]{\ifdefinedelse{\sectiontitle}{\thesection \hspace{5px} \sectiontitle}{}}

    % Footer
    \fancyfoot{}
    \renewcommand{\footrulewidth}{0.4pt}
    \fancyfoot[L]{\textit{\theauthor}}
    \fancyfoot[C]{\thepage/\pageref*{LastPage}}
    \fancyfoot[R]{\textit{\scriptsize \thecontact}}
}


%% Mathemaical symbol declaration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Sets

\newcommand{\N}{\mathbb{N}} % entiers positifs
\newcommand{\Z}{\mathbb{Z}} % entiers relatifs
\newcommand{\Q}{\mathbb{Q}} % rationels
\newcommand{\R}{\mathbb{R}} % reals
\newcommand{\C}{\mathbb{C}} % complex

\newcommand{\K}{\mathbb{K}}

\newcommand{\polynom}[1]{\lob #1 \rcb}
\newcommand{\genfunc}[1]{\llbracket #1 \rrbracket}

\newcommand{\Primes}{\mathbb{P}} % primes

\newcommand{\M}[2]{\mathcal{M}_{#1}(#2)} % matrices


\newcommand{\funcset}[1]{\mathcal{F}\lop #1 \rcp}


%% Operators

% \DeclareMathOperator{\dim}{dim}   % dimension
% \DeclareMathOperator{\ker}{Ker}   % noyaux
\DeclareMathOperator{\im}{Im}       % image
% \DeclareMathOperator{\det}{det}   % determinant
\DeclareMathOperator{\rk}{rg}       % rang
\DeclareMathOperator{\spn}{span}    % span
\DeclareMathOperator{\tr}{tr}       % trace


\newcommand{\norm}[1]{
    \left\|
        #1
    \right\|
}


\newcommand{\inner}[2]{
    \left<
        \ifthenelse{\equal{#1}{}}
            {\cdot}
            {#1}
        \,|\,
        \ifthenelse{\equal{#2}{}}
            {\cdot}
            {#2}
    \right>
}


% Analisys

\DeclareMathOperator{\diver}{div}                       % divergence
\DeclareMathOperator{\curl}{curl}                       % curl
\DeclareMathOperator{\vcurl}{\overrightarrow{curl}}
\newcommand{\grad}{\vec{\nabla}}

\newcommand{\deriv}[2]{\dfrac{d #1}{d #2}}                  % derivative
\newcommand{\partder}[2]{\dfrac{\partial #1}{\partial #2}}  % partial derivative


% Sets
\DeclareMathOperator{\Card}{\#}             % cardinal
\DeclareMathOperator{\pset}{\mathcal{P}}    % power set

\newcommand{\tuple}[1]{\lop #1 \rcp}

% Others

\newcommand{\conj}[1]{\bar{#1}}        % conjugate



%% Abbreviations

\newcommand{\Cte}{\mathcal{C}^{te}}

\newcommand{\defeq}{\underset{\text{def}}{=}}

\renewcommand{\epsilon}{\varepsilon}
% \renewcommand{\emptyset}{\varnothing}

\newcommand{\sset}{\subset}
\newcommand{\sseteq}{\subseteq}

\newcommand{\tand}{\quad\text{and}\quad}
\newcommand{\tor}{\quad\text{or}\quad}
\newcommand{\iif}{\quad\text{if and only if}\quad}
\newcommand{\when}{\quad\text{when}\quad}
\newcommand{\with}{\quad\text{with}\quad}
\newcommand{\otherwise}{\quad\text{otherwise}}

% equivalent
\newcommand{\Dimp}{\Longleftrightarrow}
\newcommand{\dimp}{\Leftrightarrow}
\newcommand{\qDimp}{\quad\Longleftrightarrow\quad}
\newcommand{\qdimp}{\quad\Leftrightarrow\quad}

% implication
\newcommand{\Imp}{\Longrightarrow}
\newcommand{\imp}{\Rightarrow}
\newcommand{\qImp}{\quad\Longrightarrow\quad}
\newcommand{\qimp}{\quad\Rightarrow\quad}

\newcommand{\proofright}{\fbox{$\Rightarrow$}\hspace{0.5em}}
\newcommand{\proofleft}{\fbox{$\Leftarrow$}\hspace{0.5em}}
\newcommand{\proofsubright}{\fbox{$\subset$}\hspace{0.5em}}
\newcommand{\proofsubleft}{\fbox{$\supset$}\hspace{0.5em}}

% delimiters

\newcommand{\lop}{\left(}
\newcommand{\lcp}{\left)}
\newcommand{\rop}{\right(}
\newcommand{\rcp}{\right)}

\newcommand{\lob}{\left[}
\newcommand{\lcb}{\left]}
\newcommand{\rob}{\right[}
\newcommand{\rcb}{\right]}

\newcommand{\loc}{\left\{}
\newcommand{\lcc}{\left\}}
\newcommand{\roc}{\right\{}
\newcommand{\rcc}{\right\}}

\newcommand{\labs}{\left|}
\newcommand{\rabs}{\right|}
\newcommand{\abs}[1]{\labs #1 \rabs}

\newcommand{\floor}[1]{\lfloor #1 \rfloor}
\newcommand{\ceil}[1]{\lceil #1 \rceil}

% intervals
\newcommand{\open}[1]{\lop#1\rcp}
\newcommand{\openl}[1]{\lop#1\rcb}
\newcommand{\openr}[1]{\lob#1\rcp}
\newcommand{\close}[1]{\lob#1\rcb}

\newcommand{\intclose}[1]{\llbracket#1\rrbracket}


% functions

\newcommand{\function}[5]{
    \begin{aligned}[t]
        \setlength{\arraycolsep}{2pt}
        \begin{array}{r@{\,}ccl}
            #1\colon & #2 & \longrightarrow & #3\\
                     & #4 & \longmapsto     & #5
        \end{array}
    \end{aligned}
}

\newcommand{\func}[3]{
    \ifdefinedelse{#1}{#1\colon }{}#2 \rightarrow #3
}

\newcommand{\funcdef}[3]{
    #1\colon #2 \mapsto #3
}


% sequences

\newcommand{\seq}[3]{
    \left( #1 \right)_{#2 \in \ifthenelse{\equal{#3}{}}{\N}{#3}}
}


% limiting processes

\newcommand{\limit}[3][]{
    \ifthenelse{\equal{#3}{}}
        {\longrightarrow}
        {\underset{
            \ifdefinedelse{#1}{\underset{#1}
            {\ifdefinedelse{#2}{#2 \rightarrow}{} #3}
            }
            {\ifdefinedelse{#2}{#2 \rightarrow}{} #3}
        }{\longrightarrow}}
}

\newcommand{\fequiv}[2]{
    \ifthenelse{\equal{#2}{}}
        {\sim}
        {\underset{
            \ifthenelse{\equal{#1}{}}
                {#2}
                {#1 \rightarrow #2}
        }{\sim}}
}

\newcommand{\limeq}[2]{
    \ifthenelse{\equal{#2}{}}
        {=}
        {\underset{
            \ifthenelse{\equal{#1}{}}
                {#2}
                {#1 \rightarrow #2}
        }{=}}
}


% Multiline

\newcommand{\multiexpr}[1]{
    \loc
    {
        \everymath={\displaystyle}
        \begin{aligned}
            \begin{array}{ll}
                #1
            \end{array}
        \end{aligned}
    }
    \right.
}


%% Theorem, properties, proofs...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\newtcolorbox[auto counter, number within=section]{definition}[2][]{
    detach title,before upper={\underline{\textbf{\tcbtitle}}
    
    \vspace{0.2cm}},
    colframe=violet!80!black, colback=violet!10!white,
    coltitle=black, title=$\Delta$ \tDefinition~\thetcbcounter:~{#2},
    before skip=15pt, after skip=15pt, #1
}


\newcommand\defref[1]{\hyperref[#1]{$\Delta$ \ref*{#1}}}


\newtcolorbox[use counter from=definition]{theorem}[2][]{
    detach title,before upper={\underline{\textbf{\tcbtitle}}
    
    \vspace{0.2cm}},
    colframe=cyan!60!black, colback=blue!10!white,
    coltitle=black, title=$\tau$ \tTheorem~\thetcbcounter:~{#2},
    before skip=15pt, after skip=15pt, #1
}


\newcommand\thref[1]{\hyperref[#1]{$\tau$ \ref*{#1}}}


\newtcolorbox[use counter from=definition]{property}[2][]{
    detach title,before upper={\underline{\textbf{\tcbtitle}}
    
    \vspace{0.2cm}},
    colframe=orange!55!black, colback=orange!15!white,
    coltitle=black, title=$\Xi$ \tProperty~\thetcbcounter:~{#2},
    before skip=15pt, after skip=15pt, #1
}

\newcommand\prref[1]{\hyperref[#1]{$\Xi$ \ref*{#1}}}


\newtcolorbox[use counter from=definition]{lemma}[2][]{
    detach title,before upper={\underline{\textbf{\tcbtitle}}
    
    \vspace{0.2cm}},
    colframe=orange!55!black, colback=orange!15!white,
    coltitle=black, title=$\Lambda$ \tLemma~\thetcbcounter:~{#2},
    before skip=15pt, after skip=15pt, #1
}

\newcommand\lmref[1]{\hyperref[#1]{$\Lambda$ \ref*{#1}}}


\newtcolorbox[]{method}[2][]{
    detach title,before upper={\underline{\textbf{\tcbtitle}}
    
    \vspace{0.2cm}},
    colframe=lime!55!black, colback=lime!15!white,
    coltitle=black, title=$\mu$ \tMethod:~#2,
    before skip=15pt, after skip=15pt, #1
}


\newtcolorbox{proof}[2][]{
    enhanced, breakable, blanker, detach title, before upper={\textbf{\tcbtitle}

    \vspace{0.2cm}},
    borderline west={1.5pt}{0pt}{darkgray}, left=5pt, frame hidden, coltitle=black,
    title=$\Gamma$ \tProof~#2:, before skip=15pt, after skip=15pt, #1
}


\newcommand\qed{
    % finish
    \begin{flushright}
        \begin{tikzpicture}[scale=0.25]
            % semi-circle
            \begin{scope}
                \clip (-1, 0) rectangle (2, -1);
                \draw (0, 0) circle (1); 
            \end{scope}
            \draw (-1, 0) -- (1, 0);

            \draw (-0.4, 0.3) -- (-0.4, 1.4);
            \draw (0.4, 0.3) -- (0.4, 1.4);
        \end{tikzpicture}
    \end{flushright}
}


\newtcbox{\remk}{enhanced,
    before skip=2mm,after skip=3mm,
    boxrule=0.4pt,left=5mm,right=2mm,top=1mm,bottom=1mm,
    colback=yellow!50,
    colframe=yellow!20!black,
    sharp corners=west,
    varwidth upper, % ??? new line problem
    underlay={%
    %   \path[fill=tcbcolback!80!black] ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
    %   \path[draw=tcbcolframe,shorten <=-0.05mm,shorten >=-0.05mm] ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
      \path[fill=yellow!30!black,draw=none] (interior.south west) rectangle node[white]{!} ([xshift=4mm]interior.north west);
      },
    drop fuzzy shadow
}


\newtcolorbox[auto counter, number within=section]{example}[2][]{
    enhanced, breakable, blanker, detach title, before upper={\textbf{\tcbtitle}

    \vspace{0.2cm}},
    borderline west={1.5pt}{0pt}{darkgray}, left=5pt, frame hidden, coltitle=black,
    title=$\sigma$ \tExample~\thetcbcounter:~#2, before skip=15pt, after skip=15pt, #1
}


\newtcolorbox[use counter from=example]{exercise}[2][]{
    enhanced, breakable, blanker, detach title, before upper={\textbf{\tcbtitle}

    \vspace{0.2cm}},
    borderline west={1.5pt}{-5pt}{darkgray}, frame hidden, coltitle=black,
    title=$\Sigma$ \tExercise~\thetcbcounter:~#2, before skip=15pt, after skip=15pt, #1
}

\newtcolorbox[use counter from=example]{hardexercise}[2][]{
    enhanced, breakable, blanker, detach title, before upper={\textbf{\tcbtitle}

    \vspace{0.2cm}},
    borderline west={1.5pt}{-5pt}{darkgray}, frame hidden, coltitle=black,
    title=$\oiint$ \tExercise~\thetcbcounter:~#2, before skip=15pt, after skip=15pt, #1
}


%% Plots
%%%%%%%%

\newcommand{\theplottitle}{}

\newcommand{\plot}[5]{
    \renewcommand{\theplottitle}{}

    \begin{center}
        \begin{tikzpicture}[domain=#1:#2]
            % Graph region
            \draw[very thin, color = gray] (#1, #3) grid (#2, #4);
            \draw[->, very thick] (#1, 0) -- (#2, 0) node[right] {$x$};
            \draw[->, very thick] (0, #3) -- (0, #4) node[right] {$y$};

            % Graphs
            #5
        \end{tikzpicture}

        \theplottitle
    \end{center}
}


\newcommand{\plottitle}[1]{\renewcommand{\theplottitle}{#1}}

% TODO figure out graphs