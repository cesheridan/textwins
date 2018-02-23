_A text space that encompasses terminal & editing windows_ / Charles Sheridan


# _textwins.vim_

         IT'S ALL TEXT
 
          Windows TEXT Terminals
        Terminals TEXT Windows 
         Windows  TEXT Other Windows 
       Terminals  TEXT Other Terminals 
          Windows TEXT Themselves  
        Terminals TEXT Themselves

[3termwins]: ./doc/gif/3termwins_text_editwin.gif?raw=true  "3termwins"
![alt text][3termwins]


The Vim8 introduction of :terminal implies the **use case of pasting text from an editing window to a terminal window.**

This is the base for the concept of editing and terminal **windows that text to each other as peers**.  

_textwins.vim_ offers the developer navigation through this dynamic network of text windows, making it just as easy to text from a terminal window to an editing window as it is to text from an editing window to a terminal.

In addition to the texting concept, _**textwins.vim commands and functions will interest developers who want to make more effective use of Vim terminals**_, especially when coupled with _**tabwins.vim**_, as exemplified in _**txtmux.vim**._

_sequence above: the editwin on far left receives texts from 3 successive termwins._

## TEXTING & REFERENCE WINDOWS
Within a Vim tab of at least one editing window and one terminal window, there is one text window and one terminal window _**selected**_ to receive texts to its respective window type -- there is an editing window to which all editing and terminal windows can text, and a terminal window to which all editing and terminal windows can text.

Among the peer windows, these are the REFERENCE WINTYPES -- the **REFERENCE EDITWIN** and the **REFERENCE TERMWIN**, or REFWINS/REFWINTYPES.

All editwins and termwins are **TEXTWINS**.

A _textwins.vim_ **texting event** triggers identification of 2 additional reference windows: a wintype that sends a text becomes a **REFERENCE SENDWIN**, and the receiving wintype becomes a **REFERENCE RECVWIN**.

Reference send/recvwins are window _**roles, not wintypes**_: any editwin can alternately and simultaneously be a **REFERENCE SENDWIN** and a **REFERENCE RECVWIN**; the same holds for any termwin.  

A window that texts itself  -- a **SELFWIN** -- has both send & recv roles.

A **REFERENCE WINDOW** is any of these 4 kinds of windows -- i.e. a reference termwin, editwin, sendwin, or recvwin.

Reference windows scope to their local tabs -- **each tab in a Vim session has its own reference windows**, e.g. a reference editwin in tab 2 has no visibility to potential reference editwins in tab 4 of the same Vim session.

The DEFINITIONS section towards the end of this page summarizes the nomenclature.


# USE CASES

##### _BOTH EDITWINS AND TERMWINS ORIGINATE:_
* Creation of termwins & editwins, in new or existing windows

* Texting of Ex Line-entered text to a reference window, w/ autocreation if the window and/or wintype does not exist.  

* Texting of yanked text and textlines to a reference window; includes autocreation

* Filepath texting from an editwin -- e.g. from the current editwin, text the filepath of its bufer to a termwin, there optionallly sourced or executed; includes autocreation

* Texting of carriage returns and other control characters to termwins

* Texting to selfwins -- _thus a termwin can text portions of its earlier output to its current command line_



##### _SIMILARLY FOR REFERENCE SENDWIN & RECVWIN ROLES:_
* send/recv windows are addressable just like wintypes, meaning that windows can text to both reference sendwins and reference recvwins, and each can text to the other.


##### _THE DEVELOPER INITIATES:_
* Alternating reference window selection, via: 
 
  * Auto-selection
  * Locked selection
  * Per-command selection

* Texting of developer-defined text objects, via _textwins.vim_ commands and functions 
* Queries on reference windows


# COMMANDS

## Termwin Creation

These **complete execution in the new termwin.**

| FORM | :Ex Command |  nmap | Description | 
| :--- |  :--- | --- | --- | --- |
| **:TermwinCreate{}** |:[N]TermwinCreate  |**[N]tcr** | **Create Term**win in a new window w/ location per **g:textwins_window_creation_cmd_string_default,** or in an existing window per **[N]**, a window# or id|
|  |:TermwinCreate**Selfwin**  |tc**s**  |   **Create Term**win in **self**win, i.e. in the current window |
|  |:TermwinCreate**Vertical**          |tc**v**  |   **Create Term**win in new vertical window|
|  |:TermwinCreate**ImmediateLeft**     |tc**il**  | [same, in location specified]  |
|  |:TermwinCreate**FarLeft**           |tc**fl**  | [same]  |
|  |:TermwinCreate**ImmediateRight**    |tc**ir**  |  [same] |
|  |:TermwinCreate**FarRight**          |tc**fr**  |  [same] |
|  |:TermwinCreate**Horizontal**        |tc**h**  |  [same] |
|  |:TermwinCreate**ImmediatelyAbove**  |tc**ia**  |  [same] |
|  |:TermwinCreate**Top**               |tc**t**  |  [same] |
|  |:TermwinCreate**ImmediatelyBelow**  |tc**ib**  |  [same] |
|  |:TermwinCreate**Bottom**            |tc**b**  |    [same]|

**Overridable defaults** in termwin creation are listed in 'GLOBAL VARS' further below.  On a per-command basis, these can be overridden via 'args_hash' in calls to function **Wintype_create(args_hash)**,  invoked from all termwin create commands. 

Note that if a session creates a large number of Vim terminals, approximately 60 or more, new Vim terminals might not be functional -- there seems to be a limit to the number of open terminals that Vim8 supports.

## Motion
| FORM | :Ex Command |  nmap  |  Description |
| :--- |  :--- | ---  |--- |
| **:GoRef{....}win** |:GoRef**Term**win  | g**rt**  |Go to **Reference Term**win| 
|  |:GoRef**Edit**win  | g**re**  |Go to **Reference Edit**win| 
|  |:GoRef**Send**win  | g**rs**  |Go to **Reference Send**win|  
|  |:GoRef**Recv**win  | g**rr**  |Go to **Reference Recv**win| 


## Texting to Windows
Commands that text to a reference window or window specified by its number or id, whether the window is in (TERMINAL)NORMAL or (TERMINAL-Job)INSERT mode. 

Texting adds carriage returns only when a text is intended as an executable command sent to a termwin, e.g. `ll` of a file.

**Overridable defaults** in termwin creation are listed in 'GLOBAL VARS' further below.  On a per-command basis, these can be overridden via 'args_hash' in calls to function **Texter(args_hash)**,  invoked from all texting commands.

#### [N] Args & Receiver Windows
The optional [N] args below are Vim count prefixes.  In _textwins.vim_,  they **specify windows**, via either window #s within a tab, or window ids, which cross tabs.

[N] args **override the text-receiving window that a command would otherwise use,** even when the override is a window whose wintype is different than the wintype associated with the command -- e.g. for `5tfre` execution goes to window #5, even if it's a termwin, vs. the reference editwin ('re') implied by the command name.

An [N] that does not identify an existing window **fails** the command.

[N] args are available to both :Ex Line commands and maps.


#### AUTOCREATION of Wintype
**If [N] identifies a wintype that does not match the wintype of the associated command** -- i.e. if [N] ids an existing editwin(termwin) whereas the command targets a reference termwin(editwin), execution will **convert** window [N]  to an editwin(termwin). 

Implementation is via ':set hidden | enew' -- i.e. replaced buffers remain in the buffer list.

Autocreation is **conditioned on g:extwins_create_ref_wintype_if_none_exists_is_wanted = 'Y'**

After a window is auto-created, _textwins.vim_ returns Vim to the window which invoked the command.


#### AUTOCREATION of Window + Wintype
This scenario is similar to 'AUTOCREATION of Wintype' except here invocation omits [N] and a reference wintype (termwin or editwin) does not exist -- textwins will create a new window with location per global var **g:textwins_window_creation_cmd_string_default.** 

This is also **conditioned on g:extwins_create_ref_wintype_if_none_exists_is_wanted = 'Y'**


#### Text Copied Text to Reference Windows
| FORM | :Ex Command |  nmap | vmap | Description |
| :--- |  :--- | --- | --- | --- |
| **:[N]Text{}2Ref{....}win** |:[N]Text2Ref**Term**win | [N]t**rt** | [N]t**rt** |Text yank register or visual selection | 
|  |:[N]Text2Ref**Edit**win | [N]t**re** | [N]t**re** |[same] | 
|  |:[N]Text2Ref**Send**win | [N]t**rs** | [N]t**rs** |[same] | 
|  |:[N]Text2Ref**Recv**win | [N]t**rr** | [N]t**rr** |[same] | 
|  |:[N]Text**ll**2Ref**Term**win | [N]t**ll** | [N]t**ll** |Text & **`ll`** yank register or visual selection | 
|  |:[N]Text**Source**2Ref**Term**win | [N]t**so** | [N]t**so** |Text & **`source`** yank register or visual selection | 
|  |:[N]Text**Run**2Ref**Term**win | [N]t**ru** | [N]t**ru** |Text & **run** yank register or visual selection | 

_SEE: [N] Args & AUTOCREATION documentation, further above_


#### Text Current Line
| FORM | :Ex Command |  nmap |  vmap | Description |
| :--- |  :--- | --- | --- | --- |
| **:[N]Textyy2Ref{....}win** |:[N]Textyy2Ref**Term**win | [N]tyy**t**  | [N]tyy**t** |Text current line | 
|  |:[N]Textyy2Ref**Edit**win | [N]tyy**e** | [N]tyy**e** |[same] | 
|  |:[N]Textyy2Ref**Send**win | [N]tyy**s** | [N]tyy**s** |[same] | 
|  |:[N]Textyy2Ref**Recv**win | [N]tyy**r** | [N]tyy**r** |[same] | 

[N] for self overridden by other.

_SEE: [N] Args & AUTOCREATION documentation, further above_


#### Text Copied Text to Selfwin
In termwins, this enables copy of text from earlier shell interaction to the current command line in the same termwin.

| FORM | :Ex Command |  nmap | vmap | tmap| Description |
| :--- |  :--- | --- | --- | --- |
| **:[N]Text{...}** |:[N]Text**Self**win | [N]t**se** | [N]t**se** | [N]t**se**|Text yank register or visual selection to **self** window, i.e. to the current window 


_SEE: [N] Args & AUTOCREATION documentation, further above_


#### Text Filepath of Current Editwin to Reference Windows
Texting of the filepath, as well as its sourcing and execution.

| FORM | :Ex Command |  nmap  |  vmap | Description |
| :--- |  :--- | --- | --- | --- |
| **:[N]TextFilepath{}2Ref{....}win** |:[N]TextFilepath2Ref**Term**win | [N]tf**rt** | [N]tf**rt** |Text **Filepath** of buffer of current editwin 
|  |:[N]TextFilepath2Ref**Edit**win | [N]tf**re**| [N]tf**re**| [same]  
|  |:[N]TextFilepath2Ref**Send**win | [N]tf**rs**| [N]tf**rs** |[same]  
|  |:[N]TextFilepath2Ref**Recv**win | [N]tf**rr**| [N]tf**rr**| [same]  
|  |:[N]TextFilepath**ll**2Ref**Term**win | [N]tf**l** | [N]tf**l**|Text & `ll` **Filepath** of buffer of current editwin
|  |:[N]TextFilepath**Source**2Ref**Term**win | [N]tf**s**| [N]tf**s**|Text & **`source` Filepath** of buffer of current editwin 
|  |:[N]TextFilepath**Run**2Ref**Term**win | [N]tf**r**| [N]tf**r**|Text & **Run Filepath** of buffer of current editwin 

#### Text `make` to Termwin
Simple but used often-enough to include.  Implementation can be a prototype for locally-defined commands in the _textwins.vim_ framework.

| FORM | :Ex Command |  nmap | Description |
| :--- |  :--- | --- | --- | --- |
| **:[N]TextMake2Ref{....}win** |:[N]TextMake2Ref**Term**win | [N]t**ma** |Text & run **make** cmd | 

_SEE: [N] Args & AUTOCREATION documentation, further above_


### Text Ex Line Args to Textwins
Send free-form text to textwins.

| FORM | :Ex Command | Description |
| :--- |  :--- | --- | --- | --- |
| **:[N]TextExArgs{}2Ref{....}win** |:[N]TextExArgs2Ref**Term**win |Text **Ex Line** Args  |  
|  |:[N]TextExArgs2Ref**Edit**win |[same] |
|  |:[N]TextExArgs2Ref**Send**win | [same]|  
|  |:[N]TextExArgs2Ref**Recv**win | [same]|  
|  |:[N]TextExArgs**Run**2Ref**Term**win |Text & **Run Ex Line Args** | 

_SEE: [N] & AUTOCREATION documentation, further above_


## Queries on Reference Windows & Globals

[queries]: ./doc/gif/queries.gif?raw=true  "queries"
![alt text][queries]

Summary commands for **a 'read' on reference window state** in the current tab.

| :Ex Command |  nmap  |  Description |
| :--- |  :--- | --- | --- | --- |
| :RefWindows**Summary** | rw**s**   |Win#-Buf#-Wid Data for each refwin, in 1 line, **output to Ex Line** | 
| :RefWindows**SummaryLines** | rw**sl**   |Win#-Buf#-Wid Data for each refwin, in 4 lines, **output to Ex Line** | 
| :RefWindows**SummaryShort** | rw**ss**   |Win# of each refwin in concise form, **output to Ex Line.  {t,e,s,r}:{Termwin,Editwin,Sendwin,Recvwin}**.  Prints **'0' for undefined refwins**.  _Recommended **for titlestring**, but not for statusline_, via call to Ref_windows_summary_short().| 
| **:TextwinsGlobals** | twg   |**Global vars** in a new window at bottom of tab | 

## Reference Wintype Selection
**Use case**: developer alternates between periods of lock-selected and auto-selected wintypes.

**SEE:** _'3 WAYS TO SELECT REFERENCE WINTYPES'_ further below.

| FORM| :Ex Command  |  nmap | Description |
| :--- |  :--- | --- | --- | --- |
|**:{N}Ref{....}winLock**| :{N}Ref**Term**winLock |[N]l**tt**| **Lock**-select window# or id 'N' as the reference **termwin**, default to current window when 'N' not specified| 
|| :{N}Ref**Edit**winLock |[N]l**ee**|   **Lock**-select window# or id 'N' as the reference **editwin**, default to current window when 'N' not specified|   
|**:Ref{....}winSelectPerAutoSelect** | :Ref**Term**winSelectPerAutoSelect |as**t**| Turn on **Auto-Selection** for **termwins** |  
|| :Ref**Edit**winSelectPerAutoSelect  |as**e**|  Turn on **Auto-Selection** for **editwins**  | 


## Termwin Control 
'clean-up' a termwin command line before texting commands to it.  Accordingly, these commands end by returning to the originating window. They do _**not auto-create**_ termwins.

| FORM | :Ex Command |  nmap  | Description |
| :--- |  :--- | --- | --- | --- |
| **:[N]Text{..}2Ref{....}win** |:[N]Text**CR**2Ref**Term**win  |t**CR**  |  Text a **Carriage Return** | 
|  |:[N]Text**SP**2Ref**Term**win  |t**SP**    |Text a **SPace** Char | 
|  |:[N]Text**CC**2Ref**Term**win  |t**CC**    |Text **Cntl-C** | 
|  |:[N]Text**CU**2Ref**Term**win  |t**CU**    |Text **Cntl-U**  to **delete chars to left** of cursor| 
| **:[N]Text{}2{...}{....}win{}** |:[N]Text**Normal**2Ref**Term**win  |t**no**   |Text **NOrmal** mode to Ref termwin| 
|  |:[N]Text**Job**2Ref**Term**win  |t**jo**   |Text **Terminal JOb** mode to Ref termwin| 

## Text Wintype Exit
:quit of a Vim8 :terminal prompts for confirmation.  **termwin quits use :quit! to bypass confirmation**.

| FORM | :Ex Command |  nmap  |  Description | 
| :--- |  :--- | --- | --- | --- |
| **:[N]Quit{...}{....}win{}** |:[N]Quit**RefTerm**win  |[N]q**tt**  |   **:quit!** reference termwin, or the one specified in N, a window# or id | 
| **:[N]Text{}2RefTermwin** |:[N]Text**KillJob**2RefTermwin  |**ktj**  |   **Kill terminal Job**|


# MNEMONICS
* **maps** have 3-4 character acronyms on the associated Ex command names. 
* **Leaders** are not used, on the premiss that 3 strictly AZ/09 alphanumeric non-special chars should not trample over existing maps.  In cases where the core of an Ex command name is 2 words, the map adds a 3rd character which, for simpler fingernomics, duplicates the 2nd character.   
* **Texting maps** generally follow the pattern

    1. t:Text 
    1. x:content-type, e.g. f:Filepath
    1. r:Reference
    1. {t,e,s,r} for receiving {Termwin,Editwin,Sendwin,Recvwin} 

  * If the map reaches 5 chars, the r:Reference char is omitted
  * When the receiving window can only be a termwin, the window identifier at the end is omitted, e.g. `tll`

* **Cardinality conflicts** resolve with the larger scope being in caps -- e.g. `qtt` quits the current termwin, while `qTt` quits all current-tab termwins, and `qTT` quits the entire TAB
* When 2 different Ex Line commands imply the same map name, the more commonly-used map has priority in getting a map name that is relatively more "intuitive" 
* For wintype creation, mnemonics follows the Vim convention of referencing window/buffer
* For wintype exits, mnemonics follows the Vim convention of not naming the window 

# **3 WAYS TO SELECT REFERENCE WINTYPES** 

_See the **'Reference Wintype Selection'** Command section for a summary._

To text to a wintype, a window of that type must be selected. 


The **1ST** way, **AUTO-SELECTION, POTENTIALLY** occurs WHEN THE ACTIVE VIM WINDOW CHANGES. The window departed from becomes the reference window for its window type, IF the destination window is the same wintype as the one departed from.  When the developer moves from a termwin to another termwin, a new reference termwin auto-selects, and a move from an editwin to another editwin auto-selects a new reference editwin.   Moving from a termwin to an editwin does NOT trigger an auto-select, nor does moving from an editwin to a termwin.  

Thus for example, once an editwin is selected, the developer can move across all the termwins and text back to the same editwin from all of them. At the same time, a new reference termwin identifies on each move from one termwin to another.

Auto-selection is a configurable default selection type.

**2ND** is **LOCKED SELECTION**, where the developer selects a window whose wintype reference status persists while the developer moves from window to window. 

Thus for example the developer can select a reference editwin and then move across BOTH editwins and termwins, while texting from any of these back to the same reference editwin.

To _effect locked selection_, run the relevant command(s) below, where the **{N}** count prefix is relevant window# or id: 

    :2RefTermwinLock

    :2RefEditwinLock 

To **REVERT BACK TO AUTO-SELECTION**, run the relevant command(s) below:

    :RefTermwinSelectPerAutoSelect 

    :RefEditwinSelectPerAutoSelect 

The **3RD WAY** to select a reference wintype is on a **PER-COMMAND** basis, where the developer texts to the wintype that he/she specifies via a **Vim COUNT PREFIX**, e.g. 

    :3Text2RefTermwin  

which texts to the termwin whose window id is 3.  The window from which the text originates becomes a reference termwin(editwin), _unless_ another termwin(editwin) is already lock-selected as a reference window. 

Alternatively, the developer can specify a window id, e.g. 

    :1021Text2RefTermwin 
   
which texts to the same termwin, here identified via window id 1021.  Using a window id permits the developer to _text windows in other tabs._

Also, for most _textwins.vim_ Ex Line texting commands, there are associated map commands which also support count prefixes, e.g. the maps for the example Ex Line command above are: 
 
         3tt 
    & 1021tt 

There is also a 4TH WAY to select a reference wintype: move to another wintype window and return to the initial window.  The moved-to window is now a reference wintype.  This action may be useful in the relatively infrequent occasions when _textwins.vim_ does not identify a reference wintype in a tab.


# [N], Faster Window ID, & the Statusline
When using [N]-identification, rather than contextual identification from reference windows, the faster that a developer can identify windows within a multi-window tab, the faster the initation of texting, or _go_, to a window.

As a number in a sequence from 1 to the last window in a tab, [N] is an absolute identification, unlike Vim's relative window identifiers jkl;, etc.  The developer needs to quickly know the number of each window in a tab.  _But in a complex window structure, Vim window numbering may be non-intuitive._

To make [N]-identification faster, the most direct way is to locate every window's number in the same prominent location, e.g. in the bottom left of every window. That is the convention in _**streamline.vim**, recommended as a statusline for textwins.vim_, and visible in the demos on this page.


# CONFIGURATION
### GLOBAL VARS
The **g: global 'default' vars** bind only during the first source of this plugin during a Vim session.  

For **intra-sesssion changes**, update the associated non-default global, or use the associated Ex Line command described.

To see textwins global var settings, run **:TextwinsGlobals**


| Global | Default |  Description | 
| :--- |  :--- | :--- | 
|g:textwins_ref_termwin_select_type_default  | 'AUTO_SELECTION' | Use **:RefTermwinLock** to turn auto-selection on ('LOCKED_SELECTION'),  & **:RefTermwinSelectPerAutoSelect**  to revert to 'AUTO_SELECTION' |
|g:textwins_ref_editwin_select_type_default  | 'AUTO_SELECTION' | Use **:RefEditwinLock** to turn auto-selection on ('LOCKED_SELECTION'),  & **:RefEditwinSelectPerAutoSelect to** revert to 'AUTO_SELECTION' |
| g:textwins_auto_selection_frequency_in_ms_default | 300 | Implemented with a Vim8 timer| 
| g:textwins_auto_selection_frequency_in_ms | per associated 'default' global || 
| g:textwins_termwin_cmd_string_default  | 'terminal ++curwin ++close' | **++curwin is overridden if** run-time execution determines that wintype is to be created in another window -- e.g. per g:textwins_window_creation_cmd_string.  **This is the default.** |
|g:textwins_termwin_cmd_string | per associated 'default' global | |
| g:textwins_window_creation_cmd_string_default  |  'rightbelow vsplit' | **Default wintype creation is in another window**, i.e. NOT in Selfwin |
| g:textwins_window_creation_cmd_string | per associated 'default' global ||
| g:textwins_create_ref_wintype_if_none_exists_is_wanted_default  |  'Y' |If a texting command requires a wintype that does not exist in the current tab,  and if no window is specified at texting :command invocation, _textwins.vim_ will **auto-create** a wintype using defaults, if this global = 'Y'|
| g:textwins_create_ref_wintype_if_none_exists_is_wanted| per associated 'default' global || 
| g:textwins_return2sender_is_wanted_default|'Y'  | texting commands: does execution end in the sending window ?|
| g:textwins_return2sender_is_wanted| per associated 'default' global | ||


# DEFINITIONS
A WINTYPE is an EDITWIN or a TERMWIN.  


An EDITWIN is a Vim window which permits text editing, _thus excluding_ QuickFix, Help, and any other window whose &buftype is not an empty string. 

A TERMWIN is a Vim window whose &buftype is terminal.  Termwins that contain the same terminal buffer are nevertheless distinct, as the windows are distinct, per the windows having unique window ids.

Both editwins and termwins are TEXTWINS.

A REFERENCE WINTYPE is the most recent window of either wintype from which the developer has exited in a move to another window of the same wintype. When a tab has only 1 window of either wintype, that window is automatically a reference wintype.

Thus REFERENCE EDITWINS identify on sequential moves across editwins, and REFERENCE TERMWINS identify on sequential moves across termwins.

The most recent window to receive a _textwins.vim_ text is a REFERENCE RECVWIN, and the window that sends that text is a REFERENCE SENDWIN.  

A REFERENCE WINDOW is any of these 4 kinds of windows -- i.e. a reference termwin, reference editwin, reference sendwin, or reference recvwin.

Reference windows scope to their local tabs -- **each tab in a Vim session has its own reference windows**, e.g. a reference editwin in tab 2 has no visibility to potential reference editwins in tab 4 of the same Vim session.

# _textwins.vim_ & Vim

_This plugin:_
* Requires Vim8, the first Vim release with terminals & timers
* Adds a WinEnter autocmd which temporarily sets TERMINAL-Normal and NORMAL windows to TERMINAL-Job and INSERT mode, respectively
* Runs a timer to check window state
* Neither writes to Vim global vars nor changes Vim configurations

# RELATED PLUGINS
_These enhance textwins.vim_:

* _**txtmux.vim** ( tabwins x textwins ) multiplexer_
  https://raw.githubusercontent.com/cesheridan/txtmux.vim/master/README.md

* _**tabwins.vim**  1 command for custom window structures that persist_
  https://raw.githubusercontent.com/cesheridan/tabwins.vim/master/README.md

* _**streamline.vim** Essential wares, for getting there_
  https://raw.githubusercontent.com/cesheridan/streamline.vim/master/README.md

# DISTRIBUTION
* https://vim.sourceforge.io/scripts/script.php?script_id=5661

# DOCUMENTATION
* https://raw.githubusercontent.com/cesheridan/textwins.vim/master/README.md

# DEPLOYMENT
* This plugin, in its default configuration, has no dependencies on other plugins and should load for any established Vim package manager, provided the package manager does not require special hooks in plugin code.  

# LICENSE 
License: GPL (Gnu Public License) version 3
Copyright (c) 2018 Charles E. Sheridan


# ... ... ...
````vim
     Texting    is Addressing
     Addressing is KNOWing 

           Windows KNOW Terminals
         Terminals KNOW Windows 
          Windows  KNOW Other Windows 
        Terminals  KNOW Other Terminals 
           Windows KNOW Themselves  
         Terminals KNOW Themselves

Vim ...  just  ... KNOWS  
```
