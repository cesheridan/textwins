" ==============================================================================
"  textwins.vim
" ==============================================================================
" Version:       1.1.0
" Author:        Charles E. Sheridan
" Script:        https://vim.sourceforge.io/scripts/index.php
" Documention:   https://raw.githubusercontent.com/cesheridan/textwins.vim/master/README.md
" License:       GPL (Gnu Public License) version 3


" ==============================================================================
"  PLUGIN MGT
" ==============================================================================
let g:textwins_version                             = '1.1.0'

if  !exists("g:impl_textwins_is_in_dev_mode")
   let       g:impl_textwins_is_in_dev_mode        = 'N'
endif

if  !exists("g:textwins_reload_is_permitted")
   let       g:textwins_reload_is_permitted        = 'N'
endif

if          (g:textwins_reload_is_permitted       == 'N') 
\ && exists("g:impl_textwins_is_loaded") 
\ &&        (g:impl_textwins_is_in_dev_mode       == 'N')
  echomsg 
 \ 'textwins.vim: EXITING from :source command, re-load not permitted.  '   .
 \ 'To enable re-load, set g:textwins_reload_is_permitted to "Y".'  

  finish
endif

" ==============================================================================
function! Window_hash_undefined()
" ==============================================================================
  return {
  \ 'tab_number'    : 'UNDEFINED',
  \ 'window_id'     : 'UNDEFINED',
  \ 'window_number' : 'UNDEFINED',
  \ 'buffer_number' : 'UNDEFINED',
\ }
endfunction
" ==============================================================================
function! Ref_termwin_init()
" ==============================================================================
  let   s:ref_termwin = deepcopy(Window_hash_undefined(), 1)
endfunction
" ==============================================================================
function! Ref_editwin_init()
" ==============================================================================
  let   s:ref_editwin = deepcopy(Window_hash_undefined(), 1)
endfunction
" ==============================================================================
function! Ref_sendwin_init()
" ==============================================================================
  let   s:ref_sendwin = deepcopy(Window_hash_undefined(), 1)
endfunction
" ==============================================================================
function! Ref_recvwin_init()
" ==============================================================================
  let   s:ref_recvwin = deepcopy(Window_hash_undefined(), 1)
endfunction

" ==============================================================================
" CONFIGS - VIM-GLOBAL g: & SCRIPT-LOCAL s:
" ==============================================================================
" --- textwins_ref_termwin
if !exists("s:ref_termwin")
         call Ref_termwin_init()
endif

" --- textwins_REF_TERMWINS_BY_TAB_NUMBER
if !exists("s:REF_TERMWINS_BY_TAB_NUMBER")
  let       s:REF_TERMWINS_BY_TAB_NUMBER = {}
endif
" ------------------------------------------------------------------------------
" --- textwins_ref_editwin
if !exists("s:ref_editwin")
         call Ref_editwin_init()
endif
"  MNEMONICS: editwin: a Window that's a Non-Termwin

" --- textwins_REF_EDITWINS_BY_TAB_NUMBER
if !exists("s:REF_EDITWINS_BY_TAB_NUMBER")
  let       s:REF_EDITWINS_BY_TAB_NUMBER = {}
endif
" ------------------------------------------------------------------------------
" --- textwins_ref_sendwin
if !exists("s:ref_sendwin")
         call Ref_sendwin_init()
endif
"  MNEMONICS: sendwin: a WINdow that SENDs a text

" --- textwins_ref_sendwins_by_tab_number
if !exists("s:REF_SENDWINS_BY_TAB_NUMBER")
  let       s:REF_SENDWINS_BY_TAB_NUMBER = {}
endif
" ------------------------------------------------------------------------------
" --- textwins_ref_recvwin
if !exists("s:ref_recvwin")
         call Ref_recvwin_init()
endif
"  MNEMONICS: recvwin: a WINdow that RECeiVes a text

" --- textwins_ref_recvwins_by_tab_number
if !exists("s:REF_RECVWINS_BY_TAB_NUMBER")
  let       s:REF_RECVWINS_BY_TAB_NUMBER = {}
endif
" ------------------------------------------------------------------------------

" ---         ref_termwin_select_type

if !exists("g:textwins_ref_termwin_select_type_default")
  let       g:textwins_ref_termwin_select_type_default  = 'AUTO_SELECTION'
endif

if !exists("s:ref_termwin_select_type")
  let       s:ref_termwin_select_type    
\ =         g:textwins_ref_termwin_select_type_default
endif

" ---         ref_editwin_select_type

if !exists("g:textwins_ref_editwin_select_type_default")
  let       g:textwins_ref_editwin_select_type_default  = 'AUTO_SELECTION'
endif

if !exists("s:ref_editwin_select_type")
  let       s:ref_editwin_select_type    
\ =         g:textwins_ref_editwin_select_type_default
endif

" ---         textwins_create_ref_wintype_if_none_exists_is_wanted

if !exists("g:textwins_create_ref_wintype_if_none_exists_is_wanted_default")
  let       g:textwins_create_ref_wintype_if_none_exists_is_wanted_default  =  'Y'
endif

if !exists("g:textwins_create_ref_wintype_if_none_exists_is_wanted")
  let       g:textwins_create_ref_wintype_if_none_exists_is_wanted
  \ =       g:textwins_create_ref_wintype_if_none_exists_is_wanted_default    
endif

" ---         textwins_window_creation_cmd_string

if !exists("g:textwins_window_creation_cmd_string_default")
  let       g:textwins_window_creation_cmd_string_default  =  'rightbelow vsplit'
endif

if !exists("g:textwins_window_creation_cmd_string")
  let       g:textwins_window_creation_cmd_string
  \ =       g:textwins_window_creation_cmd_string_default  
endif

" ---         textwins_return2sender_is_wanted

if !exists("g:textwins_return2sender_is_wanted_default")
  let       g:textwins_return2sender_is_wanted_default  =  'Y'
endif

if !exists("g:textwins_return2sender_is_wanted")
  let       g:textwins_return2sender_is_wanted
\ =         g:textwins_return2sender_is_wanted_default  
endif

" ---         alpha_textwins_after_wintype_creation_return_focus_to_origin_window_is_wanted
"
if !exists("g:alpha_textwins_after_wintype_creation_return_focus_to_origin_window_is_wanted_default")
  let       g:alpha_textwins_after_wintype_creation_return_focus_to_origin_window_is_wanted_default  =  'N'
endif

if !exists("g:alpha_textwins_after_wintype_creation_return_focus_to_origin_window_is_wanted")
  let       g:alpha_textwins_after_wintype_creation_return_focus_to_origin_window_is_wanted
\ =         g:alpha_textwins_after_wintype_creation_return_focus_to_origin_window_is_wanted_default  
endif

" ---         textwins_termwin_cmd_string

if !exists("g:textwins_termwin_cmd_string_default")
  let       g:textwins_termwin_cmd_string_default  = 'terminal ++curwin ++close'
  " NOTE-DOC-VIM-termwin: ++close will trigger close of the window when the 
  " termwin job ends, which puts the termwin in 'finsihed' state -- do 
  " this to avoid need to go the termwin WINDOW and manually :q! out of the window.
endif

if !exists("g:textwins_termwin_cmd_string")
  let       g:textwins_termwin_cmd_string
\ =         g:textwins_termwin_cmd_string_default  
endif

" ---         textwins_auto_selection_frequency_in_ms

if !exists("g:textwins_auto_selection_frequency_in_ms_default")
  let       g:textwins_auto_selection_frequency_in_ms_default = 300
endif

if !exists("g:textwins_auto_selection_frequency_in_ms")
  let       g:textwins_auto_selection_frequency_in_ms
\ =         g:textwins_auto_selection_frequency_in_ms_default  
endif

" ---         alpha_textwins_logging_is_wanted_default

if !exists("g:alpha_textwins_logging_is_wanted_default")
  let       g:alpha_textwins_logging_is_wanted_default   = 'N'
endif
if !exists("g:alpha_textwins_logging_is_wanted")
  let       g:alpha_textwins_logging_is_wanted
\ =         g:alpha_textwins_logging_is_wanted_default
endif

" //////////////////////////////////////////////////////////////////////////////
" PSEUDO-CONSTANTS
" //////////////////////////////////////////////////////////////////////////////
let s:WINTYPE_TERMWIN               = 'TERMWIN'
let s:WINTYPE_EDITWIN               = 'EDITWIN'
let s:WINTYPE_SELFWIN               = 'SELFWIN'

let s:TEXTROLE_SENDWIN               = 'SENDWIN'
let s:TEXTROLE_RECVWIN               = 'RECVWIN'

let s:SUCCESS                       =  1
let s:FAIL                          =  0

let g:ZERO_COUNT_PREFIX             =  0
" NOTE-DOC-DESIGN:  It's g:GLOBAL, to enable new 
" code in other files to call Wintype_create()

let s:LOWEST_VALID_WINDOW_IDENTIFIER =  1
let s:NOT_A_WINDOW_IDENTIFIER        = -1
let s:NOT_A_BUFFER_NUMBER            = -1
let s:NO_REF_TERMWIN_DEFINED =  0
" No window has 0 as window_number nor window_id
" why 0 and not a negative int: in case it's desired to use the value in
" as equiv to 0, ie equiv to FALSE, in a condition

" //////////////////////////////////////////////////////////////////////////////
" UTILITIES
" //////////////////////////////////////////////////////////////////////////////

" ==============================================================================
function! Vimvars_search (rcvd_hash)
" ==============================================================================
  let l:rcvd_hash = {}

  " --- Process Args
  if (len(a:rcvd_hash['positional_args']) < 1) echoerr "ERROR: No args received in Vimvars_search() !!"
    return {}
  endif

  let     l:rcvd_hash['search_string']     = ''
  if (len(a:rcvd_hash['positional_args']) >= 1)
    let   l:rcvd_hash['search_string']  
    \   = a:rcvd_hash['positional_args'][0]
  endif

  " --- Write Vim vars to file

  "suppress display of warning W11 re vimvars.vim file
  let      l:autoread_original_value  = &autoread
  if       l:autoread_original_value == 0
    setlocal autoread
  endif 

  let      l:vimvars_filepath = tempname()
  execute 'redir! > ' . l:vimvars_filepath 
  " NOTE-DOC-VIM-execute(): needed, b/c otherewise writes to 'l:vimvars_filepath'
  " wanted to write to the vim temporary dir, set via 'set directory'
  " however, below does not work, so using built-in tempname()
  " which is actually a filepath.
  "   let      g:file_output_dir = &directory
  "   redir! > g:file_output_dir . '/vimvars.vim'
  " NOTE-DOC-VIM: putting :redir into func called w/ 'silent' 
  " suppresses echo to screen
  " NOTE-DOC-VIM: '!' overwrites existing file
  " the ! is superfluous wrt Vim tempname() operation

  let
  " output ALL vars, to screen if no `redir` as above

  redir END

  " restore
  if         l:autoread_original_value == 0
    setlocal noautoread
  endif 

  " --- Search file & display results

  botright copen
  " results from below search in the window at the very BOTTOM OF THE SCREEN
  " b/c some vimvars can have very long values, so want to spread values across
  " the full horizonatal of the screen, rather than crunching display into
  " lines that are too narrow.

  " Want vars at begin of each line  --
  let     g:execute_arg = 'vimgrep /' . l:rcvd_hash['search_string'] . '/j ' . l:vimvars_filepath
  execute g:execute_arg 
  " 'j' assures that the buffer in the window from which command is invoked is 
  " not replaced by l:vimvars_filepath, per Quckfix default behavior -- just need 
  " list of vimvars in quickfix window

 "let     g:execute_arg = 'Ack ' . l:rcvd_hash['search_string'] . ' vimvars.vim'
 "not using Ack b/c it cannot be scoped to look at just one file, and does not
 "have a modifier equivalent to 'j' in :vimgrep
 "also, vimgrep is vim-built-in, Ack is plugin w/ perl dep

  " --- Remove vimgrep output that's cruft in local context
  copen 
  "first, ensure we're at Quckfix window

  let      l:modifiable_original_value  = &modifiable
  if       l:modifiable_original_value == 0
    setlocal modifiable
  endif 

  %s/^.*| // 
  " cruft from line begin to 2nd '|' -- e.g.
  "    vimvars.vim|60 col 1| NERDUsePlaceHolders    1
  sort

  " restore
  if         l:modifiable_original_value == 0
    setlocal nomodifiable
  endif 

  "N.B. Cruft removal for Ack:
  "%s/^.* \d\{1,\}:// 
  " cruft from line begin to ':' -- e.g.
  "    vimvars.vim|69| 1:smarterms_external_terminal_cmd_string_default  Y
  " there will be 1 or more digits in front of the ':' -- almost always 1 or 2
endfunction
" ------------------------------------------------------------------------------
command!  -range -nargs=*     TextwinsGlobals :silent! call Vimvars_search_wrapper ({
         \  'positional_args' : ['^textwins']     
\}) 
nnoremap <silent> twg :TextwinsGlobals<CR>
" ==============================================================================
function! s:report_error(rcvd_hash)
" ==============================================================================
  let l:args = extend({ 
\   'message' : 'ERROR!'},
\             deepcopy(a:rcvd_hash,1)
\)
  echohl  ERROR
  echomsg l:args['message']
  echohl  NONE
endfunction
" ===============================================================
function! Ref_wintype_summary(rcvd_hash)
" ===============================================================
" e.g. for use in the Vim titlestring
" Not really so much for the Vim statusline, b/c the scope here
" is all windows.
  let                       l:rcvd_hash = extend ({
  \  'window_hash' :  Window_hash_undefined(),
  \  'window_type' : 'WINDOW',
  \  'format'      : 'LONG',
  \  },
  \                deepcopy(a:rcvd_hash,1)
  \)

  let     l:window_id =     l:rcvd_hash['window_hash']['window_id']
  if      l:window_id ==? 'UNDEFINED'
\ ||      l:window_id  <   1001
\ || !count(Window_IDs(), l:window_id)
    if l:rcvd_hash['format'] ==? 'LONG'
      return 'NO REF/'      . l:rcvd_hash['window_type']
    else 
      return l:rcvd_hash['window_type'].'0'
    endif
  endif

  let  l:w
  \ = Window_data_per_window_identifier   ({
  \  'window_identifier_from_function_arg' : l:window_id,
  \ })['hash']

  if l:rcvd_hash['format'] ==? 'LONG'
    return
    \ l:rcvd_hash['window_type']  .' W#'.
    \ l:w['window_number']        .'-B'.
    \ l:w['buffer_number']        .' Wid' .
    \ l:w['window_id']             
  else
    return l:rcvd_hash['window_type'].''.l:w['window_number'] 
  endif
endfunction
" ==============================================================================
function! Ref_windows_summary_short()
" ==============================================================================
  return '['.
\   Ref_wintype_summary({'window_hash' : s:ref_termwin, 'window_type' : 'T', 'format' : 'SHORT' }).''.
\   Ref_wintype_summary({'window_hash' : s:ref_editwin, 'window_type' : 'E', 'format' : 'SHORT' })
\   .'] ['.
\   Ref_wintype_summary({'window_hash' : s:ref_sendwin, 'window_type' : 'S', 'format' : 'SHORT' }).''.
\   Ref_wintype_summary({'window_hash' : s:ref_recvwin, 'window_type' : 'R', 'format' : 'SHORT' }) 
\  .']'
endfunction
" ==============================================================================
function! Ref_termwin_summary()
" ==============================================================================
  return  Ref_wintype_summary({
\   'window_hash' : s:ref_termwin,
\   'window_type' :      'TERMWIN'
\})
endfunction
" ==============================================================================
function! Ref_termwin_summary_braced()
" ==============================================================================
  return '['.Ref_termwin_summary().']'
endfunction
" ==============================================================================
function! Ref_editwin_summary()
" ==============================================================================
  return  Ref_wintype_summary({
\   'window_hash' : s:ref_editwin,
\   'window_type' :      'EDITWIN'
\})
endfunction
" ==============================================================================
function! Ref_editwin_summary_braced()
" ==============================================================================
  return '['.Ref_editwin_summary().']'
endfunction
" ==============================================================================
function! Ref_sendwin_summary()
" ==============================================================================
  return  Ref_wintype_summary({
\   'window_hash' : s:ref_sendwin,
\   'window_type' :      'SENDWIN'
\})
endfunction
" ==============================================================================
function! Ref_sendwin_summary_braced()
" ==============================================================================
  return '['.Ref_sendwin_summary().']'
endfunction
" ==============================================================================
function! Ref_recvwin_summary()
" ==============================================================================
  return  Ref_wintype_summary({
\   'window_hash' : s:ref_recvwin,
\   'window_type' :      'RECVWIN'
\})
endfunction
" ==============================================================================
function! Ref_recvwin_summary_braced()
" ==============================================================================
  return '['.Ref_recvwin_summary().']'
endfunction
" ==============================================================================
function! Ref_windows_summary_line()
" ==============================================================================
  return 
\   '['.Ref_termwin_summary().']' .'   '.
\   '['.Ref_editwin_summary().']' .'   '.
\   '['.Ref_sendwin_summary().']' .'   '.
\   '['.Ref_recvwin_summary().']'
endfunction
" ==============================================================================
function! Ref_windows_summary_lines()
" ==============================================================================
  return 
\   '['.Ref_termwin_summary().']' ."\n".
\   '['.Ref_editwin_summary().']' ."\n".
\   '['.Ref_sendwin_summary().']' ."\n".
\   '['.Ref_recvwin_summary().']'
endfunction
" ==============================================================================
function! Ref_termwin_goto()
" ==============================================================================
  if              s:ref_termwin['window_id'] ==?  'UNDEFINED'
     return { 'result_code' : s:FAIL }
  endif

  call win_gotoid(s:ref_termwin['window_id'])
endfunction
" ==============================================================================
function! Ref_editwin_goto()
" ==============================================================================
  if              s:ref_editwin['window_id'] ==?  'UNDEFINED'
    return { 'result_code' : s:FAIL }
  endif

  call win_gotoid(s:ref_editwin['window_id'])
endfunction
" ==============================================================================
function! Ref_sendwin_goto()
" ==============================================================================
  if              s:ref_sendwin['window_id'] ==?  'UNDEFINED'
    return { 'result_code' : s:FAIL }
  endif

  call win_gotoid(s:ref_sendwin['window_id'])
endfunction
" ==============================================================================
function! Ref_recvwin_goto()
" ==============================================================================
  if              s:ref_recvwin['window_id'] ==?  'UNDEFINED'
    return { 'result_code' : s:FAIL }
  endif

  call win_gotoid(s:ref_recvwin['window_id'])
endfunction

" //////////////////////////////////////////////////////////////////////////////
" CORE
" //////////////////////////////////////////////////////////////////////////////

" ==============================================================================
function! Window_data_per_window_identifier   (rcvd_hash)
" ==============================================================================
" scope: this tab

  let                                        l:rcvd_hash = extend ({
  \  'window_identifier_from_count_prefix' : s:NOT_A_WINDOW_IDENTIFIER,
  \  'window_identifier_from_function_arg' : s:NOT_A_WINDOW_IDENTIFIER
  \  },
  \                                 deepcopy(a:rcvd_hash,1)
  \)

  let      l:screen_returned                            = Window_identifiers_screen ({
  \  'window_identifier_from_count_prefix' : l:rcvd_hash['window_identifier_from_count_prefix'],
  \  'window_identifier_from_function_arg' : l:rcvd_hash['window_identifier_from_function_arg']
 \})

  let               l:w = Window_hash_undefined()

  if       l:screen_returned['window_identifier_type'] == 'UNDEFINED'
  return {
\   'return_code' : s:FAIL,
\   'hash'        : l:w
\ }
  endif
" ------------------------------------------------------------------------------


  " --- Derive from 'window_number' ? --------------------------------
  if     l:screen_returned['window_identifier_type'] ==? 'window_number'
    let  l:w['window_number']  =       l:screen_returned['window_identifier']
    let  l:w['buffer_number']  = winbufnr           (l:w['window_number'])
    let  l:w['window_id']      = win_getid          (l:w['window_number'] )    
    let  l:w['tab_number']     = tabpagenr ()
   "let  l:w['tab_number']     = getwininfo(l:w['window_id'])[0]['tabnr']
   "=> this will trap when window_id == 0, which can happen
   "=> use of tabpagenr () is what makes this func tab-scope -- deeper development
   "   should be able to make this func cross-tab ...

    " NOTE-DOC-VIM: per bufwinid(), if there are multiple windows containing 
    " the buffer, the 1st entry in that list is returned.
    " => AVOID bufwinid() ...., use alts as above win_getid()
    "    ^^^^^^^^^^^^^^^^

  " --- OR, Derive from 'window_id'? ---------------------------------
                                                       "  vvvvvvvvv
  elseif l:screen_returned['window_identifier_type'] ==? 'window_id'
    let  l:w['window_id']      =       l:screen_returned['window_identifier']
    let [l:w['tab_number'], 
  \      l:w['window_number']
  \ ]                          = win_id2tabwin(l:w['window_id'])	
    let  l:w['buffer_number']  = getwininfo(   l:screen_returned['window_identifier'])[0]['bufnr']
  endif

  return {
\   'return_code' : s:SUCCESS,
\   'hash'        : l:w,
\ }
endfunction
" ==============================================================================
function! Window_ids_this_tab()
" ==============================================================================
  return map(
  \  range(1,winnr('$')),  
  \ "win_getid(v:val)" 
 \)
endfunction
" ==============================================================================
function! Editwin_profiles_this_tab()
" ==============================================================================
  let l:buffer_types_this_tab = map(
  \  range(1,winnr('$')),  
  \ "getwinvar(v:val, '&buftype')" 
  \)

  let l:zeros_andor_ones = map(
  \  l:buffer_types_this_tab,  
  \ "empty(v:val)" 
  \)
  " '1' when item is editwin, '0' otherwise

  return {
\   'editwin_count'                      :  count(l:zeros_andor_ones, 1),
\   'lowest_window_number_thats_editwin' : (index(l:zeros_andor_ones, 1) +1)
\ }
endfunction
" ==============================================================================
function! Termwin_profiles_this_tab()
" ==============================================================================
  let l:zeros_andor_ones = map(
  \  range(1,winnr('$')),  
  \ "count([getwinvar(v:val, '&buftype')],'terminal')" 
 \)
  " '1' when item is termwin, '0' otherwise

  return {
\   'termwin_count'                      :  count(l:zeros_andor_ones, 1),
\   'lowest_window_number_thats_termwin' : (index(l:zeros_andor_ones, 1) +1)
\ }
endfunction
" ==============================================================================
function! Ref_termwin_update()
" ==============================================================================
  let l:tps =       Termwin_profiles_this_tab()

  " Potentially update this global per state of windows this tab
  "
  " SEE Ref_editwin_update() for a less-annotated view of this logic; that
  " func is almost the same, but does not have the long comments here.
  "
  " NOTE-DOC:     Textwins termwin identification does NOT require that a termwin 
  "               be created by Textwins code
  "
  " NOTE-DOC-DESIGN: derivation approach here preferable to cycling through 
  " windows via :windo, b/c the latter, a gui-level action, could
  " trigger update to Vim's alternate window value (returned by winnr("#"))
  " and thus identify a relative editwin different than what the user
  " perceives. Likely better perf. also.
  "
  " GUI items of focus: 
  "    current window 
  "    data in current s:ref_termwin 
  "    alternate window


  " --- Reset s:ref_termwin & return if no termwin this tab 

  if    l:tps['termwin_count'] == 0
    return Ref_termwin_init()
  endif


  " --- Do update, from the only termwin in this TAB
  "     that termwin is  THE ref termwin

  if    l:tps['termwin_count'] == 1
    let  s:ref_termwin
    \ = Window_data_per_window_identifier   ({
    \  'window_identifier_from_function_arg' : l:tps['lowest_window_number_thats_termwin'],
    \ })['hash']
 "
 "     Its own alternate window; keeping this value also ensures 
 "     that if a 2nd window appears, its reference termwin will be defined 
 "     at that moment.
    return
  endif 


  " --- Reset if Currently defined s:ref_termwin is no longer a termwin

  let          l:termwin_buffer_numbers = term_list()
  " NOTE-DOC-VIM:  an :enew! on a terminal removes it from 
  " term_list() output

  if count(    l:termwin_buffer_numbers,  
  \        s:ref_termwin['buffer_number']) == 0
    call     Ref_termwin_init()
  endif


  " --- Reset if Currently defined s:ref_termwin is no longer IN THIS TAB.  

  if !count(Window_ids_this_tab(), s:ref_termwin['window_id'])
    call                             Ref_termwin_init()

    " Scenarios include deletion of previous tab, which makes
    " s:REF_TERMWINS_BY_TAB_NUMBER inaccurate
    "     User can restore a ref_termwin in another tab by cmd:
    "       :Lock_ref_termwin_per_window_identifier 
  endif


  " --- Return if BUFFER OF ALTERNATE WINDOW is not a termwin
  "     NOTE-DOC-VIM: "alternate" = previous

  let                  l:alternate_window_number_this_tab       =  winnr("#")
  if getwinvar(l:alternate_window_number_this_tab, '&buftype') != 'terminal'
    return
  endif
  "
  "  NOTE-DOC-SCENARIO:DUPPED-BUFFER-IN-A-TAB
  "  when successive active windows of a tab contain the same buffer, update
  "  of s:ref_termwin tends to delay until the cursor moves within 
  "  the later window.  Does not matter for this plugin, and likely
  "  in general, b/c when 2 windows contain the same buffer,
  "  update of 1 window buffer will sync to update the other wihdow, 
  "  as Vim standard execution.
  "
  "  This scenario seems to be same for both editwins and termwins.
  "
  "  ALSO, this ignorable data inconsistency seems to happen when one or
  "  both of the the successive same-buf windows are in TERMINAL-Job or 
  "  INSERT mode, and the inconsistency corrects on transition to 
  "  TERMINAL-Normal or NORMAL mode -- imnplies an update to handle this
  "  senario in Textwins_bufenter_handler()

  " --- Do update, from alternate window
  "     that termwin is  THE ref termwin

  let s:ref_termwin
\ = Window_data_per_window_identifier   ({
\  'window_identifier_from_function_arg' : l:alternate_window_number_this_tab,
\ })['hash']

  "  Even though most window attributes of interest are now recorded
  "  in this func, call above to avoid local in-line assignments,
  "  which are redundant wrt to the above func, AND anticipate that
  "  future releases may expand the set of recorded attributes, 
  "  thus increasing the redundancy avoided by calling the func.
endfunction
" ==============================================================================
function!  Ref_editwin_update()
" ==============================================================================
  let l:tps =  Editwin_profiles_this_tab()
  " Potentially update this global per state of windows this tab
  " SEE NOTES throughout Ref_termwin_update() -- most of them apply here
  "
  " there's just enough difference between these 2 funcs that it's not 
  " worth refactoring them into a common func

  " --- Reset s:ref_editwin & return if no editwin this tab 

  if    l:tps['editwin_count'] == 0
    return Ref_editwin_init()
  endif


  " --- Do update, from the only  editwin in this TAB
  "     that   editwin is THE ref editwin

  if    l:tps['editwin_count'] == 1
    let  s:ref_editwin
    \ = Window_data_per_window_identifier   ({
    \  'window_identifier_from_function_arg' : l:tps['lowest_window_number_thats_editwin'],
    \ })['hash']

    return
  endif 


  " --- Reset if Currently defined s:ref_editwin is no longer an editwin

  if !empty(getwinvar(s:ref_editwin['window_id'], '&buftype'))
    call                Ref_editwin_init()
     " NOTE-DOC-VIM: editwin is the only only window whose &bufftype
     " is an empty string, so if &buftype type is not empty ...
  endif


  " --- Reset if Currently defined s:ref_editwin is no longer IN THIS TAB.  

  if !count(Window_ids_this_tab(), s:ref_editwin['window_id'])
    call                             Ref_editwin_init()

  endif


  " --- Return if BUFFER OF ALTERNATE WINDOW is not an editwin
  
  let                  l:alternate_window_number_this_tab  =  winnr("#")
  if !(empty(getwinvar(l:alternate_window_number_this_tab , '&buftype')))
    return
  endif

  " --- Do update, from alternate window

  let s:ref_editwin
\ = Window_data_per_window_identifier   ({
\  'window_identifier_from_function_arg' : l:alternate_window_number_this_tab,
\ })['hash']
endfunction
" ==============================================================================
function! Ref_windows_auto_update()
" ==============================================================================
" From a cross-tab pov, manage global reference window vars
" Called from handlers for timer, and for BufEnter event
" the 2 sections below now refactor into a common func,
" but first wait and see if differences emerge
" actually, since these are s:/global, rewards of refactoring
" are less
"
" Note that deletion of a tab #N renders s:REF_TERMWINS_BY_TAB_NUMBER 
" out of sync for tab #s >=N.  Data correction occurs at tab-level, in 
" the Reference_{term/tab}win_update() funcs -- Thus there may be periods
" within a Vim session when s:REF_TERMWINS_BY_TAB_NUMBER is incorrect 
" from a tab #N to the last tab. Since we don't care about tabs that are not 
" active, and since active tabs will always 'know' that old deleted tab 
" data is incorrect, this is not an issue for this plugin. 

  " --- Sendwin & Recvwin ------------------------------------------------------

  call Ref_send_recv_windows_sync_data_per_this_tab()
  " tab-sync only, NOT update of window data
  " DO: really should be called from a more generic level

  let                                       l:this_tab_number = tabpagenr()

  " --- Termwin ----------------------------------------------------------------

  " keep single-tab & cross-tab data in sync
  if !has_key (s:REF_TERMWINS_BY_TAB_NUMBER,l:this_tab_number)
    " 1st entry in this tab
    call         Ref_termwin_init()
           let s:REF_TERMWINS_BY_TAB_NUMBER[l:this_tab_number]
         \ =   s:ref_termwin
    else
    " rather, been in distab b4
           let s:ref_termwin
         \ =   s:REF_TERMWINS_BY_TAB_NUMBER[l:this_tab_number]
  endif

  " update maybe
  if   s:ref_termwin_select_type  != 'LOCKED_SELECTION'
    "    vvvvvvvvvvvvvvvvvv
    call Ref_termwin_update()
    "    ^^^^^^^^^^^^^^^^^^

  " keep single-tab & cross-tab data in sync, again
           let s:REF_TERMWINS_BY_TAB_NUMBER[l:this_tab_number]
  \ = deepcopy(s:ref_termwin)
  endif


  " --- Editwin ----------------------------------------------------------------

  " keep single-tab & cross-tab data in sync
  if !has_key (s:REF_EDITWINS_BY_TAB_NUMBER,l:this_tab_number)
    call         Ref_editwin_init()
    " 1st entry in this tab
           let s:REF_EDITWINS_BY_TAB_NUMBER[l:this_tab_number]
         \ =   s:ref_editwin
    else
    " rather, been in distab b4
           let s:ref_editwin
         \ =   s:REF_EDITWINS_BY_TAB_NUMBER[l:this_tab_number]
  endif

  " update maybe
  if   s:ref_editwin_select_type  != 'LOCKED_SELECTION'
    "    vvvvvvvvvvvvvvvvvv
    call Ref_editwin_update()
    "    ^^^^^^^^^^^^^^^^^^

  " keep single-tab & cross-tab data in sync, again
           let s:REF_EDITWINS_BY_TAB_NUMBER[l:this_tab_number]
  \ = deepcopy(s:ref_editwin)
  endif
endfunction
" ==============================================================================
function! Ref_send_recv_windows_update_data_per_this_tab(rcvd_hash)
" ==============================================================================
  " keep single-tab & cross-tab data in sync
  let                                                  l:rcvd_hash = extend ({
  \  'sendwin_window_id' : s:NOT_A_WINDOW_IDENTIFIER,
  \  'recvwin_window_id' : s:NOT_A_WINDOW_IDENTIFIER,
  \  },
  \                                           deepcopy(a:rcvd_hash,1)
  \)

  let                              l:this_tab_number = tabpagenr()

  let s:ref_recvwin = Window_data_per_window_identifier({
\   'window_identifier_from_function_arg' : l:rcvd_hash['recvwin_window_id']
\ })['hash']
  " record regardless of success/fail of texting

  " keep single-tab & cross-tab recv data in sync
  let s:REF_RECVWINS_BY_TAB_NUMBER[l:this_tab_number] = deepcopy(s:ref_recvwin)

  let s:ref_sendwin = Window_data_per_window_identifier({
\   'window_identifier_from_function_arg' : l:rcvd_hash['sendwin_window_id']
\ })['hash']
  " don't set the s: var until AFTER the send, otherwise textwins will 
  " text to l:window_id_at_function_entry, if the texting is to  s:ref_sendwin 

  " keep single-tab & cross-tab data in sync
  let s:REF_SENDWINS_BY_TAB_NUMBER[l:this_tab_number] = deepcopy(s:ref_sendwin)
endfunction
" ==============================================================================
function! Ref_send_recv_windows_sync_data_per_this_tab()
" ==============================================================================
  " keep single-tab & cross-tab data in sync

  let                                       l:this_tab_number = tabpagenr()

  " --- s:ref_sendwin ----------------------------------------------------------

  if !has_key (s:REF_SENDWINS_BY_TAB_NUMBER,l:this_tab_number) 
    call         Ref_sendwin_init()
    " 1st entry in this tab
           let s:REF_SENDWINS_BY_TAB_NUMBER[l:this_tab_number]
         \ =   s:ref_sendwin
    else
    " been in distab b4
           let s:ref_sendwin
         \ =   s:REF_SENDWINS_BY_TAB_NUMBER[l:this_tab_number]
  endif

  " if 'window_id' no longer exists, reset
  if !count(Window_IDs(), s:ref_sendwin['window_id'])
    call Ref_sendwin_init()

    let s:REF_SENDWINS_BY_TAB_NUMBER[l:this_tab_number]
    \ =   s:ref_sendwin
  endif

  " --- s:ref_termwin ----------------------------------------------------------

  if !has_key (s:REF_RECVWINS_BY_TAB_NUMBER,l:this_tab_number) 
    call         Ref_recvwin_init()
    " 1st entry in this tab
           let s:REF_RECVWINS_BY_TAB_NUMBER[l:this_tab_number]
         \ =   s:ref_recvwin
    else
    " been in distab b4
           let s:ref_recvwin
         \ =   s:REF_RECVWINS_BY_TAB_NUMBER[l:this_tab_number]
  endif

  " if 'window_id' no longer exists, reset
  if !count(Window_IDs(), s:ref_recvwin['window_id'])
    call Ref_recvwin_init()

    let s:REF_RECVWINS_BY_TAB_NUMBER[l:this_tab_number]
    \ =   s:ref_recvwin
  endif
endfunction
" ==============================================================================
function! Textwins_timer_handler(textwins_timer)
" ==============================================================================
  call Ref_windows_auto_update()
endfunction
" ==============================================================================
function! Textwins_bufenter_handler()
" ==============================================================================
" If in NORMAL or TERMINAL-Normal, trigger a mode-change event, SO THAT pending 
" calls to winnr('#') return alternate (previous) window id values more likely 
" to match user perception of current window state, and more timely so.
" If BufEnter into INSERT or TERMINAL-Job mode, triggering to NORMAL does not 
" seem of any benefit, so not doing that here.

  if         &buftype != 'terminal' 
\ &&  !empty(&buftype)
    return
    " the only windows of interest to this plugin are
    " termwins & editwins -- get out on any other type
    " of window. (&buftype=empty-string signals editwin).
    "
    " In particular, if this func runs in a quickfix window, 
    " vim exits from the window, and the quickfix window 
    " cannot be re-entered, even via :wincmd from user.
    "
   "if count(['terminal', empty()], &buftype) == 0
    " NOTE-DOC-VIM:  above approach fails b/c empty()
    " needs an arg
  endif

  if mode() == 'n'
    " 1st, if in NORMAL, get into INSERT mode
    silent! normal i

    " 2nd, back to NORMAL
    if &buftype == 'terminal'
      silent! <C-W>N
      " NOTE-DOC-VIM:  w/o 'silent!' these cmds error out !
    else
      silent! <ESC>
      " normalizing syntax for any buftype other than terminal
    endif
  endif

  call Ref_windows_auto_update()

endfunction
" " ==============================================================================
" NOTE-DOC: NOT IMPLEMENTED b/c there are too many :tabclose* variations -- if 
" all tabcloses were simple :tabclose, the current tab# after the TabClosed event 
" is a +1 increment of the tab index to be deleted from the refwin arrays.
" But that's not the only scenario ...
" Instead rely on periodic checks of reference window ids vs
" windows in current tab
"
" function! Textwins_tabclosed_handler(rcvd_hash)
" " ==============================================================================
"   let                                       l:this_tab_number = tabpagenr()
"   if has_key (s:REF_TERMWINS_BY_TAB_NUMBER, l:this_tab_number)
"               s:REF_TERMWINS_BY_TAB_NUMBER['l:this_tab_number']
"   " ....
"   endif
" endfunction
" autocmd TabClosed * call Textwins_tabclosed_handler()
" ==============================================================================
autocmd WinEnter  * call Textwins_bufenter_handler()
" ==============================================================================
function! Handler_after_wintype_creation  (rcvd_hash)
" ==============================================================================
  let l:rcvd_hash =             deepcopy(a:rcvd_hash,1)

  " --------------------------------------------------------
  " --- Logging ? -- potential later addition
  if(exists  ("g:terminal_logger_is_loaded") 
\ &&          (g:terminal_logger_is_loaded == 'Y')
\ &&                              &buftype == 'terminal'
\ && ! exists("b:log_filepath")
\ )
    call add(            l:rcvd_hash['callbacks_return_values'], 
    \ Term_buffer_config(l:rcvd_hash)
   \)  
  endif

  if l:rcvd_hash['after_wintype_creation_return_focus_to_origin_window_is_wanted'] == 'Y'   
     wincmd p
  endif

  return      { 'return_code'  :  s:SUCCESS }
endfunction
" ==============================================================================
function! Window_identifiers_screen (rcvd_hash)
" ==============================================================================
" Screen validity of window identifiers -- does NOT screen on buffer 
" type or any other window attribute, screens only on whether the 
" selected identifier(s) map to an existent window, in any tab.
"
  let                              l:rcvd_hash = extend ({
  \  'window_identifier_from_count_prefix' : s:NOT_A_WINDOW_IDENTIFIER,
  \  'window_identifier_from_function_arg' : s:NOT_A_WINDOW_IDENTIFIER
  \  },
  \                       deepcopy(a:rcvd_hash,1)
  \)
  " ---------------------------------------------------------------------------
  " If all received window_identifiers have default values, there's nothing
  " to screen -- the caller decides how to handle that.
  " ---------------------------------------------------------------------------
  if    (l:rcvd_hash['window_identifier_from_count_prefix'] == g:ZERO_COUNT_PREFIX)
\ &&    (l:rcvd_hash['window_identifier_from_function_arg'] <  s:LOWEST_VALID_WINDOW_IDENTIFIER)
  " vvvvvv
    return { 
    \ 'window_identifier'      : s:NOT_A_WINDOW_IDENTIFIER,
    \ 'window_identifier_type' : 'UNDEFINED',
   \}
 endif
  " NOTE-DOC: 's:LOWEST_VALID_WINDOW_IDENTIFIER' -- that's 1, for a window number.
  " During development of this plugin, may(!) have seen Vim use 0 for window number
  " when the window does not yet exist, and textwins internally uses -1 for default
  " window identifier -- thus any value < 1 will NOT be a window identifier
  " and is considered a placeholder init that is not screened as erroneous.
  " ---------------------------------------------------------------------------
  " priority to 'window_identifier_from_count_prefix' since it's the window 
  " identifier most recently specified.
  " ---------------------------------------------------------------------------
  let l:window_identifier        = s:NOT_A_WINDOW_IDENTIFIER
  let l:window_identifier_source = 'UNDEFINED'
  " NOTE-DOC: textwins 'window_identifier' can be Vim window number OR Vim window id

  if   ((type (               l:rcvd_hash['window_identifier_from_count_prefix']) == v:t_number              )
\ &&                         (l:rcvd_hash['window_identifier_from_count_prefix']  != g:ZERO_COUNT_PREFIX      ))
    let l:window_identifier = l:rcvd_hash['window_identifier_from_count_prefix']
    let l:window_identifier_source                             = 'count_prefix'
  endif

 if((type (                   l:rcvd_hash['window_identifier_from_function_arg']) == v:t_number               )
\ &&                         (l:rcvd_hash['window_identifier_from_function_arg']  != s:NOT_A_WINDOW_IDENTIFIER))
    let l:window_identifier = l:rcvd_hash['window_identifier_from_function_arg']
    let l:window_identifier_source                             = 'function_arg'
  endif
  " it's possible that l:window_identifier was not assigned to

  " --------------------------------------------------------
  " throw if not l:is_positive_number
  " --------------------------------------------------------
  let l:is_positive_number = 0 
  try
    if (type ( l:window_identifier ) == v:t_number) 
    \  &&      l:window_identifier   != s:NOT_A_WINDOW_IDENTIFIER
           let l:is_positive_number   = 1 
    endif
  finally
    let        l:window_identifier_source_info = ''
    "          vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if         l:is_positive_number           == 0
      "        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      let      l:window_identifier_info        = ''
      if       l:window_identifier            != ''
         let   l:window_identifier_source_info = 'USING THE VALUE IN THE ' . 
         \     l:window_identifier_source
      endif
     
      call <SID>report_error({'message' : 
      \        l:window_identifier . ' IS NOT A VALID WINDOW IDENTIFIER, WHICH NEEDS ' .
      \        ' TO BE AN INTEGER > 0.  ' . 
      \        l:window_identifier_source_info
     \})
     "vvvvv
      throw ''
     "^^^^^
    endif
  endtry  
  " ---------------------------------------------------------------------------
  " Is l:window_identifier within the range of Vim window numbers this tab ?
  " throw (IF NOT, & NOT using window ids)
  " ---------------------------------------------------------------------------
    " vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if  l:window_identifier  <= winnr("$") 
      " ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  " vvvvvv                 " winnr("$") : highest window_number THIS tab
    return { 
    \ 'window_identifier'      : l:window_identifier,
    \ 'window_identifier_type' : 'window_number',
    \}
  endif
  " ---------------------------------------------------------------------------
  " Is l:window_identifier within the range of Vim window ids across all tabs ?
  " throw IF NOT
  " ---------------------------------------------------------------------------
    " vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if  count(Window_IDs(),         l:window_identifier) >= 1
  "   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  " vvvvvv
    return { 
    \  'window_identifier'      : l:window_identifier,
    \  'window_identifier_type' :  'window_id',
    \}
  else
    call <SID>report_error({'message' : 'HALTING EXECUTION -- ' .
    \ l:window_identifier . ' IS NOT A WINDOW NUMBER IN THIS TAB,'. 
    \                       ' NOR A WINDOW ID IN THIS VIM SESSION.'
    \ })
   "vvvvv
    throw ''
   "^^^^^
  endif
endfunction
" ==============================================================================
function! Window_go_per_textwins_window_identifier(rcvd_hash)
" ==============================================================================
" a textwins_window_identifier is either a Vim window id or a Vim 
" window number
  let                                            l:rcvd_hash = extend ({
  \    'window_identifier'      : s:NOT_A_WINDOW_IDENTIFIER,
  \    'window_identifier_type' : 'undefined',
  \  },
  \                                     deepcopy(a:rcvd_hash,1)
  \)

  let l:return_code = s:FAIL
  if l:rcvd_hash['window_identifier'] ==  s:NOT_A_WINDOW_IDENTIFIER
    return {
    \  'return_code'             : l:return_code,
    \  'return_code_reason'      : s:NOT_A_WINDOW_IDENTIFIER,
    \  'return_code_reason_type' : 'BAD_IDENTIFIER',
   \}
    " NOT a fail -- failure relates to fail of :wincmd or win_gotoid() below,
    " not to recieving a non-window_identifier 
  endif

  try
    if              l:rcvd_hash['window_identifier_type']     ==? 'window_number'
                                                                 " vvvvvvvvv
      execute       l:rcvd_hash['window_identifier']            . 'wincmd  w'
      let l:return_code = s:SUCCESS
 
    elseif          l:rcvd_hash['window_identifier_type']     ==? 'window_id'
         " vvvvvvvvvv
      call win_gotoid(rcvd_hash['window_identifier'])
         " ^^^^^^^^^^
      let l:return_code = s:SUCCESS
    " l:result will be 0 if 'window_identifier_type' is not recognized, and
    " thus will trigger error below.
    else
      call <SID>report_error({'message' : 'UNRECOGNIZED  window_identifier_type' .
      \                                   l:rcvd_hash['window_identifier_type'] })
      " should not get here -- if we do, it's a code error, not a  real-time 
      " window_identifier spec error.
       throw ''
      let l:return_code = s:FAIL
    endif
  finally
    if    l:return_code == s:FAIL
     " EITHER of the attempted goto window cmds failed
     call <SID>report_error({'message' : 'VIM COULD NOT GO TO THE SPECIFIED WINDOW ' .
     \                                    l:rcvd_hash['window_identifier']      })
     " don't know why failure when it's not due to window_number being too large
     "throw '' " commented out b/c it suppresses Vim diagnostic info 
    endif
  endtry

  return  { 'return_code' : l:return_code }
endfunction
" ==============================================================================
function! Window_identifiers_screen_and_go (rcvd_hash)
" ==============================================================================
" Screen on window existence only, NOT on wintype, ie don't care whether 
" termwin or editwin
                                                        " vvvvvvvvvvvvvvvvvvvvvvvvv
  let      l:screen_returned                            = Window_identifiers_screen ({
  \  'window_identifier_from_count_prefix' : a:rcvd_hash['window_identifier_from_count_prefix'],
  \  'window_identifier_from_function_arg' : a:rcvd_hash['window_identifier_from_function_arg']
 \})

  if       l:screen_returned['window_identifier_type'] == 'UNDEFINED'
    let    l:screen_returned['return_code']             = s:FAIL
    return l:screen_returned   
  endif

  return Window_go_per_textwins_window_identifier({
  \  'window_identifier'      : l:screen_returned['window_identifier'],
  \  'window_identifier_type' : l:screen_returned['window_identifier_type'],
 \})
endfunction
" ==============================================================================
function! Select_ref_termwin_per_lock                  (rcvd_hash)
" ==============================================================================
" Lock a reference termwin, overriding auto-select
  let     l:rcvd_hash =                      deepcopy(a:rcvd_hash,1)

  " interpret prefix count of 0, the default, as the caller not 
  " specifying a window, & meaning intent is for CURRENT WINDOW TO be 
  " locked -- provided it's a termwin
  if      l:rcvd_hash['window_identifier_from_count_prefix'] == g:ZERO_COUNT_PREFIX
\ &&  &buftype                                               == 'terminal'
      let l:rcvd_hash['window_identifier_from_function_arg']  = win_getid(winnr())
  endif

  let l:returned = Window_data_per_window_identifier (l:rcvd_hash)
  if  l:returned['return_code'] ==? s:FAIL
    return    {  'return_code'  :   s:FAIL }
  endif

  let s:ref_termwin_select_type = 'LOCKED_SELECTION'
  call  Ref_termwin_init()

  let s:ref_termwin =                              deepcopy(l:returned['hash'])
  let s:REF_TERMWINS_BY_TAB_NUMBER[s:ref_termwin['tab_number']] = s:ref_termwin

  return      {  'return_code'  :  s:SUCCESS }
endfunction
" ==============================================================================
function! Select_ref_termwin_per_auto_selection ()
" ==============================================================================
  let          s:ref_termwin_select_type = 'AUTO_SELECTION'  
endfunction
" ==============================================================================
function! Select_ref_editwin_per_lock                  (rcvd_hash)
" ==============================================================================
" Lock a reference editwin, overriding auto-select
  let     l:rcvd_hash =                      deepcopy(a:rcvd_hash,1)

  " interpret prefix count of 0, the default, as the caller not 
  " specifying a window, & meaning intent is for CURRENT WINDOW TO be 
  " locked -- provided it's an editwin
  if      l:rcvd_hash['window_identifier_from_count_prefix'] == g:ZERO_COUNT_PREFIX
\ &&  empty(&buftype)
      let l:rcvd_hash['window_identifier_from_function_arg']  = win_getid(winnr())
  endif

  let l:returned = Window_data_per_window_identifier (a:rcvd_hash)
  if  l:returned['return_code'] ==? s:FAIL
    return     { 'return_code'  :   s:FAIL }
  endif

  let s:ref_editwin_select_type = 'LOCKED_SELECTION'
  call  Ref_editwin_init()

  let s:ref_editwin                              = deepcopy(l:returned['hash'])
  let s:REF_EDITWINS_BY_TAB_NUMBER[s:ref_editwin['tab_number']] = s:ref_editwin

  return      { 'return_code'  :  s:SUCCESS }
endfunction
" ==============================================================================
function! Select_ref_editwin_per_auto_selection ()
" ==============================================================================
  let          s:ref_editwin_select_type = 'AUTO_SELECTION'  
endfunction
" ==============================================================================
function! Window_identifiers_screen_go_confirm (rcvd_hash)
" ==============================================================================
  let                                       l:rcvd_hash = extend ({
  \    'winattr_wanted'                      : s:WINTYPE_TERMWIN,
  \    'window_identifier_from_count_prefix' : s:NOT_A_WINDOW_IDENTIFIER,
  \    'window_identifier_from_function_arg' : s:NOT_A_WINDOW_IDENTIFIER,
  \  },
  \  deepcopy(                              a:rcvd_hash,1)
  \)
  let      l:rtrn_hash                       = {}
  let      l:rtrn_hash['return_code']        = s:FAIL
  let      l:rtrn_hash['return_code_reason'] = 'UNDEFINED'

  let l:window_id_at_function_entry = win_getid(winnr())
                                                          " vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  let      l:returned =                                     Window_identifiers_screen_and_go ({
  \  'winattr_wanted'                        : l:rcvd_hash['winattr_wanted'],
  \  'window_identifier_from_count_prefix'   : l:rcvd_hash['window_identifier_from_count_prefix'],
  \  'window_identifier_from_function_arg'   : l:rcvd_hash['window_identifier_from_function_arg'],
 \})
  if       l:returned['return_code']        ==  s:FAIL
    return l:returned
  endif

  " BUT is this window the 'winattr_wanted' ?
  if ( (      &buftype == 'terminal' && l:rcvd_hash['winattr_wanted'] ==? s:WINTYPE_TERMWIN)
\ ||   (empty(&buftype)              && l:rcvd_hash['winattr_wanted'] ==? s:WINTYPE_EDITWIN) 
\ ||                                   (l:rcvd_hash['winattr_wanted'] ==? s:TEXTROLE_SENDWIN)
\ ||                                   (l:rcvd_hash['winattr_wanted'] ==? s:TEXTROLE_RECVWIN))
    let l:rtrn_hash['return_code']           = s:SUCCESS
    " NOTE-DOC-DESIGN: better to instead query Vim funcs for gui 
    " data, but for now check after-the-fact
    "
    " Not screening on s:TEXTROLEs
  else
    " go back where we were
    call win_gotoid(l:window_id_at_function_entry)
    let  l:rtrn_hash['return_code_reason']   = 'IS_WINDOW_BUT_NOT_WINTYPE_WANTED'
  endif

  return l:rtrn_hash
endfunction
" ==============================================================================
function! Wintype_create (count_prefix, rcvd_hash)
" ==============================================================================
" Can be called either as explicit request for new window, or in auto-creation
" scenario where caller is texting to a window that does not yet exist.
" In scope of current tab only 
"
" Create a 'winattr_wanted' in either 1) the current window,
" 2) the window whose window_identifier is specified by the caller, or 3) in the 
" default location.
"
" Execution goes to the window before instantiating the 'winattr_wanted'.  

" ------------------------------------------------------------------------------
  let l:window_identifier_from_count_prefix   = a:count_prefix
  let                                 l:rcvd_hash = extend ({
  \ 'winattr_wanted'                         : s:WINTYPE_TERMWIN,
  \ 'wintype_creation_in_curwin_is_wanted'   : 'N', 
  \ 'window_identifier'                      : s:NOT_A_WINDOW_IDENTIFIER, 
  \ 'window_creation_cmd_string'             : g:textwins_window_creation_cmd_string,
  \ 'termwin_cmd_string'                     : g:textwins_termwin_cmd_string,
  \ 'after_wintype_creation_return_focus_to_origin_window_is_wanted' : g:alpha_textwins_after_wintype_creation_return_focus_to_origin_window_is_wanted,
  \
  \ 'logging_is_wanted'                      : g:alpha_textwins_logging_is_wanted,
  \ 'content_type'                           : 'termwin',
  \ 'syntax_type'                            : 'shell',
  \ 'callbacks_return_values'                : []
  \  },
  \                          deepcopy(a:rcvd_hash,1)
  \)
  " NOTE-DOC: textwins 'window_identifier' can be Vim window number OR Vim window id
  " NOTE-DOC: the key-value pairs after 'logging_is_wanted' are for termwin 
  " logging, not implemented currently.

  let l:rtrn_hash                = {}
  let l:rtrn_hash['return_code'] = s:FAIL
" ------------------------------------------------------------------------------
  " Being at the intended window for the wintype precedes its creation.
  " Does not matter whether Vim goes to another window or not, so long as the 
  " window identifiers don't trigger errors.
" ------------------------------------------------------------------------------
  let l:window_number_at_function_entry = winnr()
  let l:window_id_at_function_entry     = win_getid(l:window_number_at_function_entry)
  let l:buffer_number_at_function_entry = bufnr("%")

  let l:returned 
  \=    Window_identifiers_screen_and_go ({
  \    'window_identifier_from_count_prefix' : l:window_identifier_from_count_prefix,
  \    'window_identifier_from_function_arg' : l:rcvd_hash['window_identifier'],
 \})
  let l:window_number_at_mid_function = winnr()

  " --- SCENARIO: we're in same window before & after call to ------------------
  " Window_identifiers_screen_and_go(), yet 
  " 'wintype_creation_in_curwin_is_wanted' is 'N'

  if((      l:window_number_at_function_entry             ==  l:window_number_at_mid_function  
 \&& l:rcvd_hash['wintype_creation_in_curwin_is_wanted']  ==? 'N'))

    " Is being in the same window also contrary to caller's spec
    " from the count prefix in a:count ?
    if count( [  l:window_number_at_function_entry,
            \    l:window_id_at_function_entry 
            \ ],
            \    l:window_identifier_from_count_prefix)   == 0

      " yes, so get out of this same window, and into a new one !
    " vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
      execute l:rcvd_hash['window_creation_cmd_string']   
    " ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    " NOTE-DOC-VIM: the NEW WINDOW WILL HAVE SAME BUFFER AS PREV WINDOW, 
    " unless 'window_creation_cmd_string' is overridden to something else...
    " thus, a termwin(editwin) produces a dup terminal(text) buffer in new window
    " even when intended window is an editwin(termwin) -- have to convert in
    " subsequent code.
    endif
  endif


  " --- SCENARIO: *EXISTING* WINDOW DETERMINED, & IT'S THE  SAME TYPE AS 
  "     'winattr_wanted', & POSSIBLY CONTAINS SAME BUFFER AS ORIGIN WINDOW

  if ( (      &buftype == 'terminal' && l:rcvd_hash['winattr_wanted'] ==? s:WINTYPE_TERMWIN)
\ ||   (empty(&buftype)              && l:rcvd_hash['winattr_wanted'] ==? s:WINTYPE_EDITWIN) )
     " Caveot is that when both origin window and 'winattr_wanted' are termwins,
     " the new window may contain the same terminal buffer as contained in 
     " the origin window.  So exclude on that.
     "

     if l:buffer_number_at_function_entry != bufnr("%")
       call <SID>report_error({'message' : 'SKIPPING EXECUTION --' .
     \ ' Window ' . l:window_number_at_mid_function . ','        .
     \ ' targetted for termwin creation, is already'            . 
     \ ' a ' . l:rcvd_hash['winattr_wanted']
     \})
      " Message written for contexts that include one command triggering 
      " creation of multiple 'winattr_wanted'. Failure of one does not halt 
      " creation of the others.
     else
       " 2 windows w/ SAME BUFFER -- change the buffer in the new window, 
       " but don't get rid of the replaced buffer
       set hidden 
       enew
       " NOTE-DOC-VIM-hidden|enew: see docu elsewhere in this plugin w/ same tag
     endif

     if l:rcvd_hash['winattr_wanted'] ==? s:WINTYPE_EDITWIN
       return l:rtrn_hash
    endif
  endif


  " WANT EDITWIN  ?  -----------------------------------------------------------

  if    l:rcvd_hash['winattr_wanted'] ==? s:WINTYPE_EDITWIN

    if (&buftype == 'terminal') 
      " EDITWIN IN AN EXISTING TERMWIN IS WANTED -- banish the terminal buffer 
      " from the window and replace it with an editwin, but don't get ride of 
      " the terminal buffer.
      set hidden 
      enew
      " see above note introduced w/ 'ODD'
       " NOTE-DOC-VIM-hidden|enew: see docu elsewhere in this plugin w/ same tag
    endif

    return Handler_after_wintype_creation (l:rcvd_hash)
  endif

" WANT TERMWIN: Run 'termwin_cmd_string' -----------------------------------

  set hidden 
  enew
  " NOTE-DOC-VIM-hidden|enew: see docu elsewhere in this plugin w/ same tag
  execute l:rcvd_hash['termwin_cmd_string']   
      let l:rcvd_hash['window_id_after_wintype_creation'] = win_getid(winnr())
  return                 Handler_after_wintype_creation (l:rcvd_hash)
endfunction
" ==============================================================================
function! Termwin_buffer_numbers_this_tab()
" ==============================================================================
                                                   " vvvvvvvvvvvvvvvv
  let          g:buffer_numbers_this_tab           = tabpagebuflist()	
                                                   " ^^^^^^^^^^^^^^^^       
  let          l:termwin_buffer_numbers_this_tab  = []                      " vvvvvvvvvvv
  for                                             l:termwin_buffer_number in term_list()
    " intersection ?                                                       " ^^^^^^^^^^^^
    if count(  g:buffer_numbers_this_tab,         l:termwin_buffer_number) > 0
      call add(l:termwin_buffer_numbers_this_tab, l:termwin_buffer_number)
    endif
  endfor
  return  sort(l:termwin_buffer_numbers_this_tab)
endfunction
" ==============================================================================
function! Termwin_buffer_numbers_other_tabs()
" ==============================================================================
  let          l:termwin_buffer_numbers_other_tabs  = [] 
                                                    " vvvvvvvvvvvvvvvv
  let          l:buffer_numbers_other_tabs          = tabpagebuflist()	
                                                    " ^^^^^^^^^^^^^^^^       vvvvvvvvvvv
  for                                             l:termwin_buffer_number in term_list()
    " intersection ?                                                         ^^^^^^^^^^^
    if  count( l:buffer_numbers_other_tabs,          l:termwin_buffer_number) == 0
      call add(l:termwin_buffer_numbers_other_tabs, l:termwin_buffer_number)
    endif
  endfor
  return  sort(l:termwin_buffer_numbers_other_tabs)
endfunction
" ==============================================================================
function! Buffer_is_termwin    (rcvd_hash)
" ==============================================================================
  if(count(term_list(), bufnr(a:rcvd_hash['buffer_number']))) > 0 
    return 'Y' 
  else 
    return 'N' 
  endif
endfunction
" ==============================================================================
function! Window_IDs()
" ==============================================================================
   return sort(map(
  \              map(getwininfo(),"v:val"),
  \             "v:val['winid']"
  \))
" NOTE-DOC-VIM-getwininfo(): returns a dictionary for EVERY window in sesssion
" return sort(map (map(getwininfo(),"v:val"), "v:val['winid']"))
endfunction
" ==============================================================================
function! Build_textstring(rcvd_hash) 
" ==============================================================================
  let                        l:rcvd_hash = extend ({ 
  \ 'string'                  : '',
  \ 'string_type'             : 'UNDEFINED',
  \ 'string_prefix'           : '',
  \ 'string_suffix'           : '',
  \ },
  \                 deepcopy(a:rcvd_hash,1)
\ ) 

  let l:func_hash = { 
  \ 'textstring' : '',
\ }
  let l:rtrn_hash = { 
  \ 'return_code'               : s:FAIL,
\ }

  " -------------------------------------------------------
  if l:rcvd_hash['string_type']            ==? 'this_filepath'
    let         l:returned = This_filepath_screen_for_texting({})

    if(          l:returned['return_code']) ==  s:FAIL
      return    l:rtrn_hash['return_code']
    endif

    let         l:rcvd_hash['string'] = l:returned['this_filepath']
  endif
  " -------------------------------------------------------

  let l:func_hash['textstring'] = 
  \
  \   l:rcvd_hash['string_prefix']           . 
  \   l:rcvd_hash['string']                  .
  \   l:rcvd_hash['string_suffix']

  return {
  \'return_code' : s:SUCCESS,
  \'textstring'  : l:func_hash['textstring']
 \}
endfunction
" ==============================================================================
function! Text_a_wintype       (rcvd_hash)
" ==============================================================================
" Text to current cursor location in the current window
" Return to SendWin if configured to do so

  let  l:rcvd_hash = deepcopy(a:rcvd_hash,1)

  let l:buffer_number =  bufnr("%")

  " --- TEXTING IS EITHER FEEDING A TERMWIN ------------------------------------

  if                   &buftype        == 'terminal' 
    if term_getstatus(l:buffer_number) =~ 'normal'
      silent! normal i
    " If TERMINAL-Normal or NORMAL mode, get into TERMINAL-Job or 
    " INSERT mode
    endif 

    " for feedkeys(), Need to escape any double-quotes
    let          l:rcvd_hash['textstring'] 
  \ = substitute(l:rcvd_hash['textstring'], '\"', '\\\"', 'g')


    " --- Append CR ?
    if    l:rcvd_hash['append_cr_is_wanted'] ==? 'Y'   
      let l:rcvd_hash['textstring']          .=  '\<CR>'
      " NOTE-DOC: regardless of caller spec, this syntax 
      " will not work unless receiver is termwin
    endif 

    " --- Append Vim <C-W>p ? -- MUST be implemented AFTER CR append
    if    l:rcvd_hash['return2sender_is_wanted'] ==? 'Y'
  \ &&    l:rcvd_hash['receiver_winattr']        !=  s:WINTYPE_SELFWIN
      let l:rcvd_hash['textstring']              .= '\<C-W>p'
    endif 
    " NOT! SelfWin, i.e. if texting to self, don't go to prev window ...
    " NOTE-DOC-VIM: if receiver_winattr is a termwin,
    " embedding \<C-W>p in arg to be submitted to 
    " feedkeys() WORKS, for returning execution to the previous
    " window, unlike approach of following a:recvd_hash['textstring']
    " feedkeys() texting w/ a separate:
    "     call win_gotoid(l:window_id_at_function_entry), 
    " which at run-time will execute BEFORE feedkeys() 
    " completes, resulting in having text sent to 
    " l:window_id_at_function_entry !!
    "
    " this approach does NOT work if receiver_winattr is an editwin --
    " that scenario is handled at end of Texter() 

    " syntax of this feedkeys() arg assumes execution from termwin-Job mode
    let          l:eval_arg     = 'feedkeys("' . l:rcvd_hash['textstring'] . '")'

   "let l:xt_opt = ",'tx'"
   "let          l:eval_arg     = 'feedkeys("' . l:rcvd_hash['textstring'] . '"'.l:xt_opt .')'
   " x & t opts for handling the fed keys, not used, for now

    execute eval(l:eval_arg)

  " --- OR NORMAL-MODE PASTING TO AN EDITWIN ----------------------------------------

  elseif empty(&buftype)
    "  in an editwin
    let    @0=l:rcvd_hash['textstring']
    normal "0p
    "  feedkeys() for paste into an editwin fails (there may be ways
    "  to make it work, but this is what is known to work now ...)
    "  also, works even for editwin in INSERT mode

    normal `]
    " after the normal `p` paste, put cursor at the END of the pasted text, so that 
    " later pastes to the same window append to the end of this text.  W/o the 
    " `], a normal `p` paste will leave the cursor at the same location as 
    " BEFORE the paste, preventing sequential pastes from appending to each other. 
    " :normal `] works if mode is currently INSERT.

    " Return to sender approach for when receiver is editwin
    " is not embedded in text content
    if l:rcvd_hash['return2sender_is_wanted'] ==? 'Y'
  \ && l:rcvd_hash['receiver_winattr']        !=  s:WINTYPE_SELFWIN
      wincmd p
    endif

  else
    return { 'return_code' :  s:FAIL }
    " receiver_winattr is Neither termwin nor editwin
  endif

  return   { 'return_code' :  s:SUCCESS }
endfunction
" ==============================================================================
function! Window_identify_goto_text(count_prefix, rcvd_hash)
" ==============================================================================
  let                                           l:rcvd_hash = extend ({
 \    'receiver_winattr'                                    : s:WINTYPE_TERMWIN,
  \   'window_identifier_from_function_arg'                 : s:NOT_A_WINDOW_IDENTIFIER,
  \             'create_ref_wintype_if_none_exists_is_wanted':
  \   g:textwins_create_ref_wintype_if_none_exists_is_wanted, 
  \             'after_wintype_creation_return_focus_to_origin_window_is_wanted' : 
  \   g:alpha_textwins_after_wintype_creation_return_focus_to_origin_window_is_wanted,
  \  },
  \  deepcopy(                                  a:rcvd_hash,1),
  \)
  let l:func_hash                                                                   =  {}
  let l:func_hash['return_code']                                                    =  s:FAIL
  let l:func_hash['window_id_at_function_entry']                                    =  win_getid(winnr())
  let l:func_hash['after_wintype_creation_return_focus_to_origin_window_is_wanted'] = 'UNDEFINED'
  let l:func_hash['execution_created_a_new_window']                                 = 'N'
  " becomes relevant only if a:count_prefix specs an existing window 
  " that is not a termwin

  let l:window_id_at_function_entry              = winnr()


  if  l:rcvd_hash['receiver_winattr']           ==? s:WINTYPE_SELFWIN
  " no target screening screening needed ...

    call Ref_send_recv_windows_update_data_per_this_tab({
  \   'sendwin_window_id'   : l:window_id_at_function_entry,
  \   'recvwin_window_id'   : l:window_id_at_function_entry,
  \ })
    " 2Self, thus same win is BOTH ref_send and ref_rcvr window
    " record regardless of success/fail of texting

    return Text_a_wintype({
    \ 'textstring'              : l:rcvd_hash['textstring'],
    \ 'receiver_winattr'        : l:rcvd_hash['receiver_winattr'],
    \ 'append_cr_is_wanted'     : l:rcvd_hash['append_cr_is_wanted'],
    \ 'return2sender_is_wanted' : l:rcvd_hash['return2sender_is_wanted'],
    \ })
  endif

  " --- now at what will BECOME text sender window once text is 
  "     sent in code that follows


  " Priority for Targeted Windows: " ------------------------------------
  "   1) function arg + count_prefix  
  "   2) reference window of same wintype  
  "   3) function_arg w/ window location


  " IF CALLER HAS SPECED a non-default window, via a textwins window identifier, 
  " and an associated window does NOT EXIST, logic in call below will throw 
  let l:tisag_returned = Window_identifiers_screen_go_confirm ({
  \  'winattr_wanted'                      : l:rcvd_hash['receiver_winattr'],
  \  'window_identifier_from_count_prefix' : a:count_prefix,
  \  'window_identifier_from_function_arg' : l:rcvd_hash['window_identifier_from_function_arg']
 \})

  " ///////////////////////////////////////////////////////
  " WINDOW EXISTS  ...
  " --- but did not go to a window ?
  if l:tisag_returned['return_code'] ==? s:FAIL 

    let l:stc_returned = {}
    let l:func_hash['after_wintype_creation_return_focus_to_origin_window_is_wanted'] = 'N'
    " After Wintype_create() finishes below, it may make current
    " the window of the new termwin.  BUT within execution
    " of this caller of Wintype_create(), processing needs to 
    " continue at the new window. But that req ends w/ this func,
    " so above var later permits relocation to the window that
    " originates func invocation.
   
    " -- NEW termwin PER FUNC ARG + USABLE a:count_prefix ? --------------------

    if l:rcvd_hash['create_ref_wintype_if_none_exists_is_wanted'] ==? 'Y'
  \ && a:count_prefix                                             != g:ZERO_COUNT_PREFIX      

      let l:stc_returned = Wintype_create(a:count_prefix, extend(
      \ deepcopy(l:rcvd_hash,1),
      \            {'after_wintype_creation_return_focus_to_origin_window_is_wanted' :
      \ l:func_hash['after_wintype_creation_return_focus_to_origin_window_is_wanted'],
      \ 'winattr_wanted'                             : l:rcvd_hash['receiver_winattr']},
     \))
      " a:count_prefix is not the dummy default, and
      " screening has already confirmed the specified window exists,
      " and config supports this,
      " so a new termwin will be created there.

      let l:func_hash['execution_created_a_new_window'] = 'Y'


    " -- HALT ON WINDOW-VALID :count_prefix NEVERTHELESS IN VIOLATION OF FUNC ARG ? --------

    elseif l:rcvd_hash['create_ref_wintype_if_none_exists_is_wanted'] ==? 'N'
  \ && a:count_prefix != g:ZERO_COUNT_PREFIX      

      call <SID>report_error({'message' : 'HALTING EXECUTION -- ' .
     \  'There is NO REFERENCE termwin at window ' . a:count_prefix . 
     \  ', and this command does not auto-create wintypes.' .
     \  ' To run this command again, you should first create a'.
     \  ' termwin in this window.'
     \})
      throw ''


    " -- GO TO A REFERENCE TERMWIN ? -------------------------------------------
 
    elseif l:rcvd_hash['receiver_winattr']       == s:WINTYPE_TERMWIN
  \ &&                s:ref_termwin['window_id'] != 'UNDEFINED'
      call win_gotoid(s:ref_termwin['window_id'])
         " ^^^^^^^^^^   


    " -- GO TO A REFERENCE EDITWIN ?
 
    elseif l:rcvd_hash['receiver_winattr']       == s:WINTYPE_EDITWIN
  \ &&                s:ref_editwin['window_id'] != 'UNDEFINED'
      call win_gotoid(s:ref_editwin['window_id'])
         " ^^^^^^^^^^   


    " -- GO TO A REFERENCE SENDWIN ?
 
    elseif l:rcvd_hash['receiver_winattr']       == s:TEXTROLE_SENDWIN
  \ &&                s:ref_sendwin['window_id'] != 'UNDEFINED'
      call win_gotoid(s:ref_sendwin['window_id'])
         " ^^^^^^^^^^   


    " -- GO TO A REFERENCE RECVWIN ?
 
    elseif l:rcvd_hash['receiver_winattr']       == s:TEXTROLE_RECVWIN
  \ &&                s:ref_recvwin['window_id'] != 'UNDEFINED'
      call win_gotoid(s:ref_recvwin['window_id'])
         " ^^^^^^^^^^   
   

    " -- NEW WINTYPE PER FUNC ARG ? --------------------------------------------
    "    ^^^

    elseif l:rcvd_hash['create_ref_wintype_if_none_exists_is_wanted'] ==? 'Y'

      let  l:stc_returned = Wintype_create(a:count_prefix, extend(
      \    deepcopy(l:rcvd_hash,1),
      \               {'after_wintype_creation_return_focus_to_origin_window_is_wanted' :
      \    l:func_hash['after_wintype_creation_return_focus_to_origin_window_is_wanted'],
      \ 'winattr_wanted'                             : l:rcvd_hash['receiver_winattr']},
     \))
      " Even if there are other existent termwins, i.e. non-reference termwins,
      " it assumes too much to try to decide which of those to target.  So,
      " instead create a new reference termwin, if directed per 
      " 'create_ref_wintype_if_none_exists_is_wanted'

      let  l:func_hash['execution_created_a_new_window'] = 'Y'


    " -- NO ENTRY, MUST EXIT ...  ----------------------------------------------

    else 
      call <SID>report_error({'message' : 'HALTING EXECUTION -- ' .
     \  'There is NO REFERENCE textwin known to Textwins -- '      . 
     \  ' no termwin, editwin, sendwin, or recvwin'               . 
     \  ' and this command does not auto-create textwins.'      .
     \  ' If there is an existing textwin where you want your'  .
     \  ' command to run: 1) visit its window; 2) return to'    .
     \  ' the current window;'                                  .
     \  ' 3) re-submit your command.  Steps 1 & 2 should make'  .
     \  ' Textwins see your intended textwin as a REFERENCE.' .
     \  ' textwin.'
     \})
      throw ''
    endif
  endif
  " ///////////////////////////////////////////////////////

  " --- now at the text receiver window ----------------------------------------

  " Can now make this update w/o trampling over the data that was needed 
  " to get to the receiver window.
  " record regardless of success/fail of texting
  call Ref_send_recv_windows_update_data_per_this_tab({
\   'sendwin_window_id' : l:window_id_at_function_entry,
\   'recvwin_window_id' : winnr()
\ })

  " --- text the wintype, and potentially return2sender 
                          " vvvvvvvvvvvvv
  let       l:wf_returned = Text_a_wintype({
  \  'textstring'             : l:rcvd_hash['textstring'],
  \ 'receiver_winattr'        : l:rcvd_hash['receiver_winattr'],
  \ 'append_cr_is_wanted'     : l:rcvd_hash['append_cr_is_wanted'],
  \ 'return2sender_is_wanted' : l:rcvd_hash['return2sender_is_wanted'],
  \ })

  if         l:wf_returned['return_code'] ==? s:FAIL 
     return  l:func_hash
  endif


  let          l:func_hash['return_code']  =  s:SUCCESS
  return       l:func_hash
endfunction
 
" //////////////////////////////////////////////////////////////////////////////
" Wintype CREATION COMMANDS & MAPS
" //////////////////////////////////////////////////////////////////////////////

" ==============================================================================
"  --- Create a Termwin
command! -count=0 TermwinCreate :call Wintype_create(<count>, {}) 
noremap <silent> tcr :<C-U>      call Wintype_create(v:count, {})<CR>
" MNEMONICS: t:Termwin, cr:CReate,
" NOTE-DOC: does NOT default to current window
" ==============================================================================
" RE '<C-U>' NOTE-DOC-VIM-v:count: in a map, this is needed when invocation
"
" if caller does not specify a target window, default is to NOT create
" termwin in the local (this) window (Vim 'curwin') invokeing the cmd.
" BUT, by intent, a non-0  count prefix override the 
" 'wintype_creation_in_curwin_is_wanted' of N spec.
" Default config or caller spec determines whether execution ends in the new 
" termwin, or in invocation window.
"
" Also see extensive comments in func Wintype_create()
" has a count prefix -- otherwise, you get an error.

" ------------------------------------------------------------------------------
"  --- Create a Termwin in CURRENT WINDOW
command! -nargs=* -complete=command TermwinCreateSelfwin :call Wintype_create(g:ZERO_COUNT_PREFIX,{
\ 'wintype_creation_in_curwin_is_wanted' : 'Y'
\})
noremap <silent>               tcs :TermwinCreateSelfwin<CR>
" MNEMONICS: t:Termwin, c:Create, c:Current window
" 0 v:count placeholder for window_number arg in called func b/c this cmd creates
" a termwin ONLY in the local (current -- "++curwin") window, there is no 
" dynamic spec from caller

" ------------------------------------------------------------------------------
"  --- Create a VERTICAL Termwin 
command! TermwinCreateVertical         :call Wintype_create(g:ZERO_COUNT_PREFIX, {
\ 'window_creation_cmd_string' : 'rightbelow vsplit'
\}) 
noremap <silent> tcv :TermwinCreateVertical<CR>

" ------------------------------------------------------------------------------
"  --- Create a Vertical Termwin at IMMEDIATE LEFT of Vim Screen
command! TermwinCreateImmediateLeft    :call Wintype_create(g:ZERO_COUNT_PREFIX, {
\ 'window_creation_cmd_string' : 'leftabove vsplit'
\}) 
noremap <silent> tcil :TermwinCreateImmediateLeft<CR>

" ------------------------------------------------------------------------------
"  --- Create a Vertical Termwin at FAR LEFT of Vim Screen
command! TermwinCreateFarLeft          :call Wintype_create(g:ZERO_COUNT_PREFIX, {
\ 'window_creation_cmd_string' : 'topleft vsplit'
\}) 
noremap <silent> tcfl :TermwinCreateFarLeft<CR>

" ------------------------------------------------------------------------------
"  --- Create a Vertical Termwin at IMMEDIATE RIGHT of Vim Screen
command! TermwinCreateImmediateRight   :call Wintype_create(g:ZERO_COUNT_PREFIX, {
\ 'window_creation_cmd_string' : 'rightbelow vsplit'
\}) 
noremap <silent> tcir :TermwinCreateImmediateRight<CR>

" ------------------------------------------------------------------------------
"  --- Create a Vertical Termwin at FAR RIGHT of Vim Screen
command! TermwinCreateFarRight         :call Wintype_create(g:ZERO_COUNT_PREFIX, {
\ 'window_creation_cmd_string' : 'botright vsplit'
\}) 
noremap <silent> tcfr :TermwinCreateFarRight<CR>

" ------------------------------------------------------------------------------
"  --- Create a HORIZONTAL Termwin
command! TermwinCreateHorizontal       :call Wintype_create(g:ZERO_COUNT_PREFIX, {
\ 'window_creation_cmd_string' : 'split'
\}) 
noremap <silent> tch  :TermwinCreateHorizontal<CR>

" ------------------------------------------------------------------------------
"  --- Create a Horizontal Termwin IMMEDIATELY ABOVE
command! TermwinCreateImmediatelyAbove :call Wintype_create(g:ZERO_COUNT_PREFIX, {
\ 'window_creation_cmd_string' : 'aboveleft split'
\}) 
noremap <silent> tcia :TermwinCreateImmediatelyAbove<CR>

" ------------------------------------------------------------------------------
"  --- Create a Horizontal Termwin at TOP of Vim Screen
command! TermwinCreateTop              :call Wintype_create(g:ZERO_COUNT_PREFIX, {
\ 'window_creation_cmd_string' : 'topleft split'
\}) 
noremap <silent> tct  :TermwinCreateTop<CR>

" ------------------------------------------------------------------------------
"  --- Create a Horizontal Termwin IMMEDIATELY BELOW
command! TermwinCreateImmediatelyBelow :call Wintype_create(g:ZERO_COUNT_PREFIX, {
\ 'window_creation_cmd_string' : 'belowright split'
\}) 
noremap <silent> tcib :TermwinCreateImmediatelyBelow<CR>

" ------------------------------------------------------------------------------
"  --- Create a Horizontal Termwin at BOTTOM of Vim Screen
command! TermwinCreateBottom           :call Wintype_create(g:ZERO_COUNT_PREFIX, {
\ 'window_creation_cmd_string' : 'botright split'
\}) 
noremap <silent> tcb  :TermwinCreateBottom<CR>

" //////////////////////////////////////////////////////////////////////////////
" INTERACTION WITH EXISTING Textwins
" //////////////////////////////////////////////////////////////////////////////

" ==============================================================================
"  --- Select a Reference Termwin
" ==============================================================================
command! -count=0      RefTermwinLock :call                Select_ref_termwin_per_lock({
\ 'window_identifier_from_count_prefix' : <count>
\})
nnoremap <silent> ltt :<C-U> call                          Select_ref_termwin_per_lock({
\ 'window_identifier_from_count_prefix' : v:count
\})<CR>

command!               RefTermwinSelectPerAutoSelect :call Select_ref_termwin_per_auto_selection() 
noremap <silent>  ast :RefTermwinSelectPerAutoSelect<CR> 

" ==============================================================================
"  --- Select a Reference Editwin
" ==============================================================================
command! -count=0      RefEditwinLock :call                Select_ref_editwin_per_lock({
\ 'window_identifier_from_count_prefix' : <count>
\})
nnoremap <silent> lee :<C-U> call                          Select_ref_editwin_per_lock({
\ 'window_identifier_from_count_prefix' : v:count
\})<CR>

command!               RefEditwinSelectPerAutoSelect :call Select_ref_editwin_per_auto_selection() 
noremap <silent>  ase :RefEditwinSelectPerAutoSelect<CR> 

" ==============================================================================
function! This_filepath_screen_for_texting(rcvd_hash) 
" ==============================================================================
  let                                    l:rcvd_hash = extend ({ 
  \ 'return_code'            :  s:FAIL,
  \ 'shell_evaluable_string' :  '',
  \ },
  \                             deepcopy(a:rcvd_hash,1)
\ )

  if &buftype == 'terminal' 
    echo <SID>report_error({'message' :  'HALTING EXECUTION --' . 
     \  ' You want to run a command on the filepath associated with this buffer,' .
     \  ' but THIS BUFFER IS A termwin. termwins DO NOT HAVE FILEPATHS.' .
     \  ' So cannot run a filepath command for this buffer.'
     \})
     throw ''
     return { 'result_code' : s:FAIL }
  endif

  let        l:rtrn_hash                  = {}
  let        l:rtrn_hash['this_filepath'] = expand('%:p')
  let        l:rtrn_hash['return_code']   = s:SUCCESS
  return     l:rtrn_hash

  " per std use case, let the OS shell handle file permission 
  " and existence errors.
endfunction
" ==============================================================================
function! Texter(count_prefix, rcvd_hash) 
" ==============================================================================
  let                        l:rcvd_hash = extend ({ 
  \ 'string'                    : '',
  \ 'string_type'               : '',
  \ 'string_prefix'             : '',
  \ 'string_suffix'             : '',
  \                             
  \ 'receiver_winattr'          : s:WINTYPE_TERMWIN,
  \                             
  \ 'append_cr_is_wanted'       : 'N',
  \ 'return2sender_is_wanted'   : g:textwins_return2sender_is_wanted,
  \ },
  \                 deepcopy(a:rcvd_hash,1)
\ ) 

  let l:rtrn_hash = { 
  \ 'return_code'               : s:FAIL,
  \ 'feedkeys_returned'         : '',
\ }

  let l:returned = Build_textstring({
  \   'string'        : l:rcvd_hash['string'],
  \   'string_type'   : l:rcvd_hash['string_type'],
  \   'string_prefix' : l:rcvd_hash['string_prefix'],
  \   'string_suffix' : l:rcvd_hash['string_suffix'],
\ })
  if        l:returned['return_code'] == s:FAIL
     return l:rtrn_hash
  endif

  " NOTE-DOC:  below CR processing disabled for now
        " ...
        " Remove superfluous carriage returns at begin & end line(s)
        " WHEN TEXTING TO A TERMWIN. This preserves CRs that separate 
        " lines in-between.
        " If there are string_prefix/suffixes, interpret this to mean 
        " that the caller does not want this kind of CR removal.
        "
        " AND, note the 'run' cmds explicitly add a CR, so this 
        " removal operation here will not preclude that necessary CR.
      "      let          l:returned['textstring'] 
      "    \ = substitute(l:returned['textstring'], '^[\r\n]*,  '', 'g')
      " 
      "      let          l:returned['textstring'] 
      "    \ = substitute(l:returned['textstring'], ' [\r\n]\{2,}$', "\n", 'g')
      "      i.e. if 2 or more CRs at end of string, reduce them to 1 CR

                                       " vvvvvvvvvvvvvvvvvvvvvvvvvv
  let l:rtrn_hash['feedkeys_returned'] = Window_identify_goto_text(
\   a:count_prefix,
\   extend({
\     'textstring'                     : l:returned['textstring'],
\     'append_cr_is_wanted'            : l:rcvd_hash['append_cr_is_wanted'],
\     'receiver_winattr'               : l:rcvd_hash['receiver_winattr'],
\     },
\     deepcopy(l:rcvd_hash,1)
\   )
\ ) 

  let    l:rtrn_hash['return_code'] 
\ =      l:rtrn_hash['feedkeys_returned']['return_code']
  return l:rtrn_hash
endfunction

" ==============================================================================
" TEXT/RUN DYNAMIC STRINGS FROM VIM EX LINE TO A WINDOW
" ==============================================================================

" --- :TextExArgs{2RefWindow}   Text from Vim Ex Line to Termwin ----------

" 2RefTermwin      
command! -count=0 -nargs=* TextExArgs2RefTermwin    :call Texter(<count>, {
\ 'string'                                                    : '<args>',
\})

" 2RefEditwin
command! -count=0 -nargs=* TextExArgs2RefEditwin    :call Texter(<count>, {
\ 'string'                                                    : '<args>',
\ 'receiver_winattr'                                          : s:WINTYPE_EDITWIN,
\})

" 2RefSendwin
command! -count=0 -nargs=* TextExArgs2RefSendwin    :call Texter(<count>, {
\ 'string'                                                    : '<args>',
\ 'receiver_winattr'                                          : s:TEXTROLE_SENDWIN,
\})

" 2RefRecvWin
command! -count=0 -nargs=* TextExArgs2RefRecvwin    :call Texter(<count>, {
\ 'string'                                                    : '<args>',
\ 'receiver_winattr'                                          : s:TEXTROLE_RECVWIN,
\})


" --- :TextRunExArgs2RefTermwin      Text run from Vim Ex Line to Termwin ------
"          ^^^

command! -count=0 -nargs=* TextExArgsRun2RefTermwin :call Texter(<count>, {
\ 'string'                                                    : '<args>',
\ 'append_cr_is_wanted'                                       : 'Y',
\})
"
" NOTE-DOC: the purpose of these commands is to effect the text of a string 
" entered in real-time, to a Vim window. Anticipating the many possible
" contexts of invocation; the Vim, OS, shell, and other software interpetations 
" of the string; & computer system actions following submit of this command,
" is outside the scope of this plugin.
"\ 'string'                                                   : '<args>' . "\\<CR\>",
"\ 'string'                                                   : '<args><CR>',

" ==============================================================================
" TERMWIN CONTROL 
" ==============================================================================
" Context: texting commands from an editwin to termwin, and the CLI has 
" character debris that needs to be cleaned up before the texting can start.
"
" Accordingly, after the clean-up, VIM RETURNS FROM THE TERMWIN TO THE 
" EDITWIN, so that the editwin can now text the intended command to the 
" termwin -- thus the (escaped) <C-W>p sequences to go back to previous window.
"
" Syntax: Escapes in double-quote strings need to be escaped
"
" Control char texter commands do NOT trigger winterm creation, as:
"   1) That is an unusual use of control chars -- e.g. creating a termwin 
"      and immediately texting CNTL-C.
"   2) There are alternate ways of doing this, with varying degrees of
"      automation.  e.g. including control chars in an override of 
"      g:textwins_termwin_cmd_string_default.
"   3) Effecting such a key sequence in Vim8 VimL is problematic, and 
"      currently outside the scope of this plugin.

" ------------------------------------------------------------------------------
" --- :TextCR2RefTermwin Text Carriage Return

command! -count=0 -nargs=* TextCR2RefTermwin    :call Texter(<count>, {
\ 'string'              : "\\<CR\>",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})
" NOTE-DOC-VIM:  double quote w/ doubled escapes, as above -- this works w/
" subsequent string concats for strings destined to feedkeys(); single quotes 
" w/ single escapes, e.g.
"    '\<CR>' 
" do NOT work in this context of calls to funcs .... unlike later different
" context in the func that builds the 'textstring' fed to feedkeys()

nnoremap <silent> tCR   :<C-U> call Texter(v:count, { 
\ 'string'              : "\\<CR\>",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})<CR>
"MNEMONICS: t:Text, cr:Carriage Return

" ------------------------------------------------------------------------------
" --- :TextSpace2RefTermwin Text Space Key (3 space keys ?)
"  NOTE-DOC:  in testing, it seems that 3 chars emit

command! -count=0 -nargs=* TextSpace2RefTermwin    :call Texter(<count>, {
\ 'string'              : " ",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})

nnoremap <silent> tSP    :<C-U> call Texter(v:count, { 
\ 'string'              : " ",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})<CR>
"MNEMONICS: t:Text, sp:SPace

" ------------------------------------------------------------------------------
" --- :TextCC2RefTermwin Text CONTROL-C

command! -count=0 -nargs=* TextCC2RefTermwin    :call Texter(<count>, {
\ 'string'              : "\\<C-C\>\\<C-C\>",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})

nnoremap <silent> tCC     :<C-U> call Texter(v:count, { 
\ 'string'              : "\\<C-C\>\\<C-C\>",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})<CR>
"MNEMONICS: t:Text, CC:CNTL-C

" ------------------------------------------------------------------------------
" --- :TextCU2RefTermwin Text CONTROL-U

command! -count=0 -nargs=* TextCU2RefTermwin    :call Texter(<count>, {
\ 'string'              : "\\<C-U\>",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})

nnoremap <silent> tCU   :<C-U> call Texter(v:count, { 
\ 'string'              : "\\<C-U\>",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})<CR>
"MNEMONICS: t:Text, cu:CNTL-U Vim & shell cmd

" ------------------------------------------------------------------------------
" --- :TextNormal2RefTermwin  Text Keys to Effect Termwin Normal Mode

command! -count=0 -nargs=* TextNormal2RefTermwin :call Texter(<count>, {
\ 'string'              : "\\<C-W\>N",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})

nnoremap <silent>  tno   :<C-U>   call Texter(v:count, { 
\ 'string'               : "\\<C-W\>N",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})<CR>
" MNEMONICS: t:Text, no:NOrmal

" ------------------------------------------------------------------------------

" --- :TerminalJob2RefTermwin Text Keys to Effect Terminal Job Mode
"
"  NOTE-DOC: this clears the current command line of the 
"  termwin, from the cursor to the left 
"  (without that clearance, the 'A' may remain on the line)

command! -count=0 -nargs=* TextTerminalJob2RefTermwin    :call Texter(<count>, {
\ 'string'                  : "A\\<C-U\>",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})

nnoremap <silent> tjo :<C-U> call Texter(v:count, { 
\ 'string'                  : "A\\<C-U\>",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})<CR>
" MNEMONICS: t:Termwin, jo:terminal-JOb

" ==============================================================================
" QUIT WINTYPES
" ==============================================================================

" ------------------------------------------------------------------------------
" --- Quit termwins
" ------------------------------------------------------------------------------

" --- quit self termwin
command!               QuitSelfTermwin :call Termwin_quit_forcefully()
"nnoremap <silent> qst :QuitSelfTermwin <CR>
"tnoremap <silent> qst <C-W>:quit!<CR>
" => since the associated Ex Line cmd is not publicly declared in README.md, 
"    dont define a map for it!
" since a tmap executes only from termwin (job) mode, don't 
" need to call the func, can quit! immediately 
" MNEMONICS: q:Quit, tw:TermWin

" ------------------------------------------------------------------------------
"
" --- quit reference termwin, w/ prefix count override possible
command! -count=0 -nargs=* QuitRefTermwin :call Texter(<count>, {
\ 'string'              : "\\<C-W\>:quit!\\<CR\>",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})

nnoremap <silent> qtt  :<C-U> call Texter(v:count, { 
\ 'string'              : "\\<C-W\>:quit!\\<CR\>",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})<CR>
" ------------------------------------------------------------------------------
" --- :KillJob2RefTermwin: Text CNTL-W CNTL-C to kill the termwin job

command! -count=0 -nargs=* TextKillJob2RefTermwin    :call Texter(<count>, {
\ 'string'              : "\\<C-W\>\\<C-C\>",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})

nnoremap <silent> ktj   :<C-U> call Texter(v:count, { 
\ 'string'              : "\\<C-W\>\\<C-C\>",
\ 'create_ref_wintype_if_none_exists_is_wanted' : 'N',
\})<CR>
" MNEMONICS: k:Kill, t:Terminal, j:Job
" If the term instantiated w/ the ++close option, vim closes the term window 
" & returns to the cmd invocation window.


" ==============================================================================
" TEXT: BASIC CORE CMDS
" ==============================================================================

" ------------------------------------------------------------------------------
" --- :Textyy{2RefWindow}  Text current line

" 2RefTermwin      
command! -count=0 -nargs=* Textyy2RefTermwin :call Texter(<count>, {
\ 'string'         : getline('.'),
\})

nnoremap <silent> tyyt :<C-U> call Texter(v:count, { 
\ 'string'         : getline('.'),
\})<CR>

vnoremap <silent> tyyt :<C-U> call Texter(v:count, { 
\ 'string'         : getline('.'),
\})<CR>
"MNEMONICS: t:Text, yy:`yy` vim normal cmd, t:ref Termwin

" 2RefEditwin      
      " command! -count=0 -nargs=* Textyy2RefEditwin :normal yy | call Texter(<count>, {
      " \ 'receiver_winattr'     : s:WINTYPE_EDITWIN,
      " \ 'string'               : @0
      " \})
nnoremap <silent> tyye yy:<C-U> call Texter(v:count, { 
\ 'receiver_winattr'     : 'EDITWIN',
\ 'string'               : @0,
\})<CR>

vnoremap <silent> tyye yy:<C-U> call Texter(v:count, { 
\ 'receiver_winattr'     : 'EDITWIN',
\ 'string'               : @0,
\})<CR>
" NOTE-DOC: use normal `yy` rather than func getline('.') b/c the latter
" returns an empty string if the line is a comment, at least in a vim file
"\ 'string'               : getline('.')
"
" NOTE-DOC-VIM: ? why does the `tyye` map fail w/ E121 on s:WINTYPE_EDITWIN, 
" which has no problem on same call from :Textyy2RefEditwin  ??
" Have to use the actual string for the map, it seems.
"\ 'receiver_winattr'     : s:WINTYPE_EDITWIN,

command! -count=0 -nargs=* Textyy2RefEditwin :normal tyye<CR>
" NOTE-DOC-VIM: unlike all other Ex commands in this plugin, this one calls
" a map which is the 'real' cmd interface: b/c, so far, there is not an 
" apparent way to run a `yy` or equiv from a command spec -- the attempt 
" above that's commented out dumps that data to the origin window, not to
" the intended window, and that data is confused.

" 2RefSendwin      
nnoremap <silent> tyys yy:<C-U> call Texter(v:count, { 
\ 'receiver_winattr'     : 'SENDWIN',
\ 'string'               : @0,
\})<CR>

vnoremap <silent> tyys yy:<C-U> call Texter(v:count, { 
\ 'receiver_winattr'     : 'SENDWIN',
\ 'string'               : @0,
\})<CR>
command! -count=0 -nargs=* Textyy2RefSendwin :normal tyys<CR>
"MNEMONICS: t:Text, yy:`yy` vim normal cmd, s:ref Sendwin

" 2RefRecvwin      
nnoremap <silent> tyyr yy:<C-U> call Texter(v:count, { 
\ 'receiver_winattr'     : 'RECVWIN',
\ 'string'               : @0,
\})<CR>
vnoremap <silent> tyyr yy:<C-U> call Texter(v:count, { 
\ 'receiver_winattr'     : 'RECVWIN',
\ 'string'               : @0,
\})<CR>
command! -count=0 -nargs=* Textyy2RefRecvwin :normal tyyr<CR>
"MNEMONICS: t:Text, yy:`yy` vim normal cmd, r:ref Recvwin

" ------------------------------------------------------------------------------
" --- :TextmakeTermwin  

command! -count=0 -nargs=* Textmake2RefTermwin :call Texter(<count>, {
\ 'string'         : 'make',
\})

nnoremap <silent> tma :<C-U> call Texter(v:count, { 
\ 'string'         : 'make',
\})<CR>
"MNEMONICS: t:Text, ma:MAke cmd

" ==============================================================================
" TEXT THIS FILEPATH: COMMANDS & MAPS
" ==============================================================================

" ------------------------------------------------------------------------------
" --- :TextFilepath{2RefWindow}   Text Filepath of current Editwin 
"          ^^^^^^^^

" 2RefTermwin      
command! -count=0 -nargs=* TextFilepath2RefTermwin  :call Texter(<count>, {
\ 'string_type'         : 'this_filepath',
\})

nnoremap <silent> tfrt :<C-U>          call Texter(v:count, { 
\ 'string_type'         : 'this_filepath',
\})<CR>
vnoremap <silent> tfrt :<C-U>          call Texter(v:count, { 
\ 'string_type'         : 'this_filepath',
\})<CR>
"MNEMONICS: t:Text, f:Filepath, rt:Ref Termwin


" 2RefEditwin      
command! -count=0 -nargs=* TextFilepath2RefEditwin  :call Texter(<count>, {
\ 'string_type'         : 'this_filepath',
\ 'receiver_winattr'    : s:WINTYPE_EDITWIN,
\})

nnoremap <silent> tfre :<C-U>          call Texter(v:count, { 
\ 'string_type'         : 'this_filepath',
\ 'receiver_winattr'    : 'EDITWIN',
\})<CR>
vnoremap <silent> tfre :<C-U>          call Texter(v:count, { 
\ 'string_type'         : 'this_filepath',
\ 'receiver_winattr'    : 'EDITWIN',
\})<CR>
"MNEMONICS: t:Text, f:Filepath, rt:Ref Editwin


" 2RefSendwin
command! -count=0 -nargs=* TextFilepath2RefSendwin  :call Texter(<count>, {
\ 'string_type'         : 'this_filepath',
\ 'receiver_winattr'    : s:TEXTROLE_SENDWIN,
\})

nnoremap <silent> tfrs :<C-U>          call Texter(v:count, { 
\ 'string_type'         : 'this_filepath',
\ 'receiver_winattr'    : 'SENDWIN',
\})<CR>
vnoremap <silent> tfrs :<C-U>          call Texter(v:count, { 
\ 'string_type'         : 'this_filepath',
\ 'receiver_winattr'    : 'SENDWIN',
\})<CR>
"MNEMONICS: t:Text, f:Filepath, rs:Ref Sendwin


" 2RefRecvwin
command! -count=0 -nargs=* TextFilepath2RefRecvwin  :call Texter(<count>, {
\ 'string_type'         : 'this_filepath',
\ 'receiver_winattr'    : s:TEXTROLE_RECVWIN,
\})

nnoremap <silent> tfrr :<C-U>          call Texter(v:count, { 
\ 'string_type'         : 'this_filepath',
\ 'receiver_winattr'    : 'RECVWIN',
\})<CR>
vnoremap <silent> tfrr :<C-U>          call Texter(v:count, { 
\ 'string_type'         : 'this_filepath',
\ 'receiver_winattr'    : 'RECVWIN',
\})<CR>
"MNEMONICS: t:Text, f:Filepath, rr:Ref Recvwin

" ------------------------------------------------------------------------------
" --- :TextFilepathll{2RefWindow}    Text & `ll` Filepath of current Editwin 
"                  ^^

" 2RefTermwin      
command! -count=0 -nargs=* TextFilepathll2RefTermwin  :call Texter(<count>, {
\ 'string_prefix'       : 'll ',
\ 'string_type'         : 'this_filepath',
\ 'append_cr_is_wanted' : 'Y',
\})

nnoremap <silent> tfl :<C-U>          call Texter(v:count, { 
\ 'string_prefix'       : 'll ',
\ 'string_type'         : 'this_filepath',
\ 'append_cr_is_wanted' : 'Y',
\})<CR>
vnoremap <silent> tfl :<C-U>          call Texter(v:count, { 
\ 'string_prefix'       : 'll ',
\ 'string_type'         : 'this_filepath',
\ 'append_cr_is_wanted' : 'Y',
\})<CR>
"MNEMONICS: t:Text, f:Filepath, l:`ll`

" ------------------------------------------------------------------------------
" --- :TextFilepathSource{2RefWindow}  `source` Filepath of current Editwin
"                  ^^^^^^

" 2RefTermwin      
command! -count=0 -nargs=* TextFilepathSource2RefTermwin  :call Texter(<count>, {
\ 'string_type'         : 'this_filepath',
\ 'string_prefix'       : 'source ',
\ 'append_cr_is_wanted' : 'Y',
\})

nnoremap <silent> tfs :<C-U>          call Texter(v:count, { 
\ 'string_type'         : 'this_filepath',
\ 'string_prefix'       : 'source ',
\ 'append_cr_is_wanted' : 'Y',
\})<CR>
vnoremap <silent> tfs :<C-U>          call Texter(v:count, { 
\ 'string_type'         : 'this_filepath',
\ 'string_prefix'       : 'source ',
\ 'append_cr_is_wanted' : 'Y',
\})<CR>
"MNEMONICS: t:Text, f:Filepath, S:Source

" ------------------------------------------------------------------------------
" --- :TextFilepathRun{2RefWindow}   run (execute) Filepath of current Editwin
"                  ^^^

" 2RefTermwin      
command! -count=0 -nargs=* TextFilepathRun2RefTermwin :call Texter(<count>, {
\ 'string_type'         : 'this_filepath',
\ 'append_cr_is_wanted' : 'Y',
\})

nnoremap <silent> tfr  :<C-U>          call Texter(v:count, { 
\ 'string_type'         : 'this_filepath',
\ 'append_cr_is_wanted' : 'Y',
\})<CR>
vnoremap <silent> tfr  :<C-U>          call Texter(v:count, { 
\ 'string_type'         : 'this_filepath',
\ 'append_cr_is_wanted' : 'Y',
\})<CR>
"MNEMONICS: t:Text, f:Filepath, r:Run

" ==============================================================================
" TEXT @0 YANK-REGISTER & @v REGISTER: COMMANDS & MAPS
" ==============================================================================
"
"  Text the most recently-copied text
"
"  NOTE-DOC: for each of the normal/visual map pairs below, THE ONLY 
"  DIFFERENCE is that the visual map run a "vy yank command whereas the 
"  normal map uses the yank register @0 value at the time of invocation.
"
"  NOTE-DOC: for filepath run commands, there is screening for file 
"  readability and executability.  This does not occur for strings
"  entered free-form in the Vim Ex Line, as a string can identify 
"  a file anywhere in the filesytem.  A deeper implementation could use 
"  $CDPATH, currently out-of-scope for this plugin.

"  NOTE-DOC-VIM: for normal-mode yanked text, use @0 rather than @" b/c the 
"  latter is subject to clobber, per Drew Neil at
"     http://vimcasts.org/episodes/meet-the-yank-register/
"
" ------------------------------------------------------------------------------
" --- :Text{2RefWindow} Text copied text

" 2RefTermwin
command! -count=0 -nargs=* Text2RefTermwin   :call Texter(<count>, {
\ 'string'              : @0,
\})

nnoremap <silent> trt  :<C-U>   call Texter(v:count, { 
\ 'string'              : @0,
\})<CR>
vnoremap <silent> trt "vy:<C-U> call Texter(v:count, { 
\ 'string'              : @v,
\})<CR>
"MNEMONICS: t:Text, rt:Ref Termwin,

" 2RefEditwin
command! -count=0 -nargs=*  Text2RefEditwin   :call Texter(<count>, {
\ 'receiver_winattr'    : s:WINTYPE_EDITWIN,
\ 'string'              : @0,
\})

nnoremap <silent> tre :<C-U>   call Texter(v:count, { 
\ 'receiver_winattr'    : 'EDITWIN',
\ 'string'              : @0,
\})<CR>
vnoremap <silent> tre "vy:<C-U> call Texter(v:count, { 
\ 'receiver_winattr'    : 'EDITWIN',
\ 'string'              : @v,
\})<CR>
"MNEMONICS: t:Text, re:Ref Editwin,

" 2RefSendwin
command! -count=0 -nargs=*  Text2RefSendwin   :call Texter(<count>, {
\ 'receiver_winattr'    : s:TEXTROLE_SENDWIN,
\ 'string'              : @0,
\})

nnoremap <silent> trs :<C-U>   call Texter(v:count, { 
\ 'receiver_winattr'    : 'SENDWIN',
\ 'string'              : @0,
\})<CR>
vnoremap <silent> trs "vy:<C-U> call Texter(v:count, { 
\ 'receiver_winattr'    : 'SENDWIN',
\ 'string'              : @v,
\})<CR>
"MNEMONICS: t:Text, rs:Ref Sendwin,

" 2RefRecvwin
command! -count=0 -nargs=*  Text2RefRecvwin   :call Texter(<count>, {
\ 'receiver_winattr'    : s:TEXTROLE_RECVWIN,
\ 'string'              : @0,
\})

nnoremap <silent> trr :<C-U>   call Texter(v:count, { 
\ 'receiver_winattr'    : 'RECVWIN',
\ 'string'              : @0,
\})<CR>
vnoremap <silent> trr "vy:<C-U> call Texter(v:count, { 
\ 'receiver_winattr'    : 'RECVWIN',
\ 'string'              : @v,
\})<CR>
"MNEMONICS: t:Text, re:Ref Recvwin

" ------------------------------------------------------------------------------
" --- :Textll{2RefWindow} Text & `ll` copied text to a termwin

" 2RefTermwin     
command! -count=0 -nargs=*  Textll2RefTermwin     :call Texter(<count>, {
\ 'string_prefix'       : 'll ',
\ 'string'              : @0,
\ 'append_cr_is_wanted' : 'Y',
\})

nnoremap <silent> tll :<C-U>    call Texter(v:count, { 
\ 'string_prefix'       : 'll ',
\ 'string'              : @0,
\ 'append_cr_is_wanted' : 'Y',
\})<CR>
vnoremap <silent> tll "vy:<C-U> call Texter(v:count, { 
\ 'string_prefix'       : 'll ',
\ 'string'              : @v,
\ 'append_cr_is_wanted' : 'Y',
\})<CR>
"MNEMONICS: t:Text, ll:`ll` unix cmd

" ------------------------------------------------------------------------------
" --- :TextSource2RefTermwin 

command! -count=0 -nargs=*  TextSource2RefTermwin  :call Texter(<count>, {
\ 'string_prefix'       : 'source ',
\ 'is_read_string'      : 'Y',
\ 'string'              : @0,
\ 'append_cr_is_wanted' : 'Y',
\})

nnoremap <silent> tso :<C-U>    call Texter(v:count, { 
\ 'string_prefix'       : 'source ',
\ 'is_read_string'      : 'Y',
\ 'string'              : @0,
\ 'append_cr_is_wanted' : 'Y',
\})<CR>
vnoremap <silent> tso "vy:<C-U> call Texter(v:count, { 
\ 'string_prefix'       : 'source ',
\ 'is_read_string'      : 'Y',
\ 'string'              : @v,
\ 'append_cr_is_wanted' : 'Y',
\})<CR>
"MNEMONICS: t:Text, so:SOurce unix cmd

" ------------------------------------------------------------------------------
" --- :TextRun2RefTermwin    

command! -count=0 -nargs=*  TextRun2RefTermwin    :call Texter(<count>, {
\ 'string'              : @0,
\ 'append_cr_is_wanted' : 'Y',
\})

nnoremap <silent> tru :<C-U>    call Texter(v:count, { 
\ 'string'              : @0,
\ 'append_cr_is_wanted' : 'Y',
\})<CR>
vnoremap <silent> tru "vy:<C-U> call Texter(v:count, { 
\ 'string'              : @v,
\ 'append_cr_is_wanted' : 'Y',
\})<CR>
"MNEMONICS: t:Text, ru:RUn
"
" ==============================================================================
" TEXT 2 SELF @0 YANK-REGISTER & @v REGISTER: COMMANDS & MAPS
" ==============================================================================
" Rather than texting to a reference window, a window texts to itself

" ------------------------------------------------------------------------------
" --- :TextSelfwin   

command! -count=0 -nargs=* TextSelfwin   :call Texter(<count>, {
\ 'receiver_winattr'    : s:WINTYPE_SELFWIN,
\ 'string'              : @0,
\})

nnoremap <silent> tse :<C-U>   call Texter(v:count, { 
\ 'receiver_winattr'    : 'SELFWIN',
\ 'string'              : @0,
\})<CR>
vnoremap <silent> tse "vy:<C-U> call Texter(v:count, { 
\ 'receiver_winattr'    : 'SELFWIN',
\ 'string'              : @v,
\})<CR>

tnoremap <silent> tse <C-W>:call Texter(v:count, { 
\ 'receiver_winattr'    : 'SELFWIN',
\ 'string'              : @0,
\})<CR>
"MNEMONICS: t:Text, se:Selfwin


" ==============================================================================
" --- Window Summaries
" ==============================================================================
" Context is current tab (at least as of textwins.vim 2018-02-06)
command! RefTermwinSummary     :echo Ref_termwin_summary() 
command! RefEditwinSummary     :echo Ref_editwin_summary() 
command! RefSendwinSummary     :echo Ref_sendwin_summary() 
command! RefRecvwinSummary     :echo Ref_recvwin_summary() 

command!                RefWindowsSummary       :echo Ref_windows_summary_line()
nnoremap <silent> rws  :RefWindowsSummary<CR>

command!                RefWindowsSummaryLines  :echo Ref_windows_summary_lines()
nnoremap <silent> rwsl :RefWindowsSummaryLines<CR>

command!                RefWindowsSummaryShort  :echo Ref_windows_summary_short()
nnoremap <silent> rwss :RefWindowsSummaryShort<CR>

" ==============================================================================
" --- Window GoTos
" ==============================================================================
command!               GoRefTermwin :call Ref_termwin_goto() 
nnoremap <silent> grt :GoRefTermwin<CR>
"vnoremap <silent> grt :GoRefTermwin<CR>

command!               GoRefEditwin :call Ref_editwin_goto() 
nnoremap <silent> gre :GoRefEditwin<CR>
"vnoremap <silent> gre :GoRefEditwin<CR>

command!               GoRefSendwin :call Ref_sendwin_goto() 
nnoremap <silent> grs :GoRefSendwin<CR>
"vnoremap <silent> grs :GoRefSendwin<CR>

command!               GoRefRecvwin :call Ref_recvwin_goto() 
nnoremap <silent> grr :GoRefRecvwin<CR>
"vnoremap <silent> grr :GoRefRecvwin<CR>

" ==============================================================================
" --- Textwins_timer
" ==============================================================================
let Textwins_timer = timer_start(
\  g:textwins_auto_selection_frequency_in_ms, 
\  'Textwins_timer_handler',
\  {'repeat': -1}
\)

" //////////////////////////////////////////////////////////////////////////////
let g:impl_textwins_is_loaded = 'Y'
" //////////////////////////////////////////////////////////////////////////////
" below of interest only during Textwins development
if   g:impl_textwins_is_in_dev_mode == 'Y' 
\ && $USER                          == 'chas'
   source $stw
endif

"                        __
" | of T   Terminates at 
"      T : Terminal
"
