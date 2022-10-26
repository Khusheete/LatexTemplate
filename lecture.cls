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

\newboolean{comments}\setboolean{comments}{false}
\newboolean{code}\setboolean{code}{false}


%% Options

\DeclareOption{10pt}{\PassOptionsToClass{10pt}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{article}}


% TODO: modif
\DeclareOption{large}{
    \PassOptionsToPackage{paperwidth=195mm,paperheight=265mm,twoside,
    inner=2.2cm,outer=2.2cm,top=2.25cm,bottom=2.25cm}{geometry}
}

\DeclareOption{compact}{
    \PassOptionsToPackage{paperwidth=160mm,paperheight=240mm,twoside,
    inner=1.7cm,outer=1.7cm,top=2.25cm,bottom=2.25cm}{geometry}
}

\DeclareOption{a4}{
    \PassOptionsToPackage{paperwidth=210mm,paperheight=297mm,twoside,
    inner=2.2cm,outer=2.2cm,top=2.25cm,bottom=2.25cm}{geometry}
}

\DeclareOption{a5}{
    \PassOptionsToPackage{paperwidth=148mm,paperheight=210mm,twoside,
    inner=1.7cm,outer=1.7cm,top=2.25cm,bottom=2.25cm}{geometry}
}


\DeclareOption{comments}{\setboolean{comments}{true}}
\DeclareOption{code}{\setboolean{code}{true}}


%% Defaults

\ExecuteOptions{compact,10pt}
\ProcessOptions\relax
\LoadClass{article}


%% Packets
%%%%%%%%%%

\RequirePackage{xcolor}             % Colors !!!
\RequirePackage{tcolorbox}          % BOXES !!!
\tcbuselibrary{skins}
\RequirePackage{titling}            % redefine title
\RequirePackage{fancyhdr}           % great headers
\RequirePackage{etoolbox}           % get title names
\RequirePackage{lastpage}           % total page count
\RequirePackage{amsmath,amssymb}    % math stuff
\RequirePackage{ifthen}             % conditionals

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

\newcommand\tdefinition{definition}
\newcommand\tDefinition{Definition}

\newcommand\tproof{Proof of}


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


%% Generate title page
%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\maketitlepage}{
    \begin{titlepage}
        \begin{center}
            \Huge
            \textbf{\thetitle}

            \vspace{0.2cm}
            \LARGE
            \thesubtitle

            \vspace{0.4cm}
            \noindent\rule{80pt}{0.1pt}
            \vspace{0.8cm}

            \Large
            \theauthor \hspace{1pt} (\textit{\thecontact})
            
            \vspace{0.2cm}
            \large
            \textit{\thecoauthors}

            \vspace{0.2cm}
            \noindent\rule{80pt}{0.1pt}
            \vspace{0.3cm}

            \theinstitution\\
            \thedate
        \end{center}

        \vspace{2cm}

        \begin{tcolorbox}[arc=0pt,title=\contentstitle]
            \normalsize
            \tableofcontents
        \end{tcolorbox}
    \end{titlepage}
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

\newcommand\defsection[1]{\def\sectiontitle{#1}\section{#1}}
\newcommand\defsubsection[1]{\def\subsectiontitle{#1}\subsection{#1}}
\newcommand\defsubsubsection[1]{\def\subsubsectiontitle{#1}\subsubsection{#1}}


\pagestyle{fancy}

% Header
\fancyhead{}
\setlength{\headheight}{14pt}
\fancyhead[L]{\textbf{\thetitle}}
\fancyhead[R]{\thesection \hspace{5px} \sectiontitle}

% Footer
\fancyfoot{}
\renewcommand{\footrulewidth}{0.4pt}
\fancyfoot[L]{\textit{\theauthor}}
\fancyfoot[C]{\thepage/\pageref*{LastPage}}
\fancyfoot[R]{\textit{\thecontact}}



%% Mathemaical symbol declaration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Sets

\newcommand{\N}{\mathbb{N}} % entiers positifs
\newcommand{\Z}{\mathbb{Z}} % entiers relatifs
\newcommand{\Q}{\mathbb{Q}} % rationels
\newcommand{\R}{\mathbb{R}} % reals
\newcommand{\C}{\mathbb{C}} % complex

\newcommand{\K}{\mathbb{K}}

\newcommand{\Primes}{\mathbb{P}} % primes

\newcommand{\M}[2]{\mathcal{M}_#1(#2)} % matrices


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
        \ifthenelse{\equal{#1}{}}
            {\cdot}
            {#1}
    \right\|
}


\newcommand{\inner}[2]{
    \left(
        \ifthenelse{\equal{#1}{}}
            {\cdot}
            {#1}
        \,|\,
        \ifthenelse{\equal{#2}{}}
            {\cdot}
            {#2}
    \right)
}


% Analisys

\DeclareMathOperator{\diver}{div}                       % divergence
\DeclareMathOperator{\curl}{curl}                       % curl
\DeclareMathOperator{\vcurl}{\overrightarrow{curl}}

\newcommand{\deriv}[2]{\dfrac{d #1}{d #2}}                  % derivative
\newcommand{\partder}[2]{\dfrac{\partial #1}{\partial #2}}  % partial derivative


% Sets
\DeclareMathOperator{\Card}{\#}             % cardinal
\DeclareMathOperator{\pset}{\mathcal{P}}    % power set


% Others

\newcommand{\conj}[1]{\overline{#1}}        % conjugate



%% Abbreviations

\renewcommand{\epsilon}{\varepsilon}
% \renewcommand{\emptyset}{\varnothing}

\newcommand{\sset}{\subset}
\newcommand{\sseteq}{\subseteq}

\newcommand{\tand}{\quad\text{and}\quad}
\newcommand{\tor}{\quad\text{or}\quad}
\newcommand{\iif}{\quad\text{if and only if}\quad}

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


% delimiters

\newcommand{\lop}{\left(}
\newcommand{\lcp}{\left)}
\newcommand{\rop}{\left(}
\newcommand{\rcp}{\left)}

\newcommand{\lob}{\left[}
\newcommand{\lcb}{\left]}
\newcommand{\rob}{\right[}
\newcommand{\rcb}{\right]}

\newcommand{\loc}{\left\{}
\newcommand{\lcc}{\left\}}
\newcommand{\roc}{\right\{}
\newcommand{\rcc}{\right\}}

% intervals
\newcommand{\open}[1]{\lop#1\rcp}
\newcommand{\openl}[1]{\lop#1\rcb}
\newcommand{\openr}[1]{\lob#1\rcp}
\newcommand{\close}[1]{\lob#1\rcb}


% functions

\newcommand{\function}[5]{
    {\setlength{\arraycolsep}{2pt}
    \begin{array}{r@{\,}ccl}
        #1\colon & #2 \longrightarrow & #3\\
                 & #4 \longmapsto     & #5
    \end{array}
    }
}

\newcommand{\func}[3]{
    #1\colon #2 \mapsto #3
}

\newcommand{\funcset}[3]{
    #1\colon #2 \rightarrow #3
}


% sequences

\newcommand{\seq}[3]{
    \left( #1 \right)_{#2 \in \ifthenelse{\equal{#3}{}}{\N}{#3}}
}


% limiting processes

\newcommand{\limit}[2]{
    \ifthenelse{\equal{#2}{}}
        {\longrightarrow}
        {\underset{
            \ifthenelse{\equal{#1}{}}
                {#2}
                {#1 \rightarrow #2}
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



%% Theorem, properties, proofs...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\newtcolorbox[auto counter, number within=section]{definition}[2][]{
    detach title,before upper={\underline{\textbf{\tcbtitle}}
    
    \vspace{0.2cm}},
    colframe=violet!80!black, colback=violet!10!white,
    coltitle=black, title=$\Delta$ \tDefinition~\thetcbcounter: #2,
    before skip=15pt, after skip=15pt, #1
}


\newtcolorbox[use counter from=definition]{theorem}[2][]{
    detach title,before upper={\underline{\textbf{\tcbtitle}}
    
    \vspace{0.2cm}},
    colframe=cyan!60!black, colback=blue!10!white,
    coltitle=black, title=$\tau$ \tTheorem~\thetcbcounter: #2,
    before skip=15pt, after skip=15pt, #1
}


\newcommand\thref[1]{\hyperref[#1]{$\tau$ \ref*{#1}}}


\newtcolorbox[use counter from=definition]{property}[2][]{
    detach title,before upper={\underline{\textbf{\tcbtitle}}
    
    \vspace{0.2cm}},
    colframe=orange!55!black, colback=orange!15!white,
    coltitle=black, title=$\Xi$ \tProperty~\thetcbcounter: #2,
    before skip=15pt, after skip=15pt, #1
}


\newcommand\prref[1]{\hyperref[#1]{$\Xi$ \ref*{#1}}}


\newtcolorbox{proof}[2][]{
    enhanced, blanker, detach title, before upper={\textbf{\tcbtitle}
    
    \vspace{0.2cm}},
    borderline west={1.5pt}{-5pt}{darkgray}, frame hidden, coltitle=black,
    title=\tproof~#2:, before skip=15pt, after skip=15pt, #1
}


\newtcbox{\remk}{enhanced,
    before skip=2mm,after skip=3mm,
    boxrule=0.4pt,left=5mm,right=2mm,top=1mm,bottom=1mm,
    colback=yellow!50,
    colframe=yellow!20!black,
    sharp corners=west,
    underlay={%
    %   \path[fill=tcbcolback!80!black] ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
    %   \path[draw=tcbcolframe,shorten <=-0.05mm,shorten >=-0.05mm] ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
      \path[fill=yellow!30!black,draw=none] (interior.south west) rectangle node[white]{!} ([xshift=4mm]interior.north west);
      },
    drop fuzzy shadow
}


% TODO figure out graphs