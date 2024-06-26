;;                                                                    
;; An autohotkey script that provides emacs-like keybinding on Windows
;;                                                                    
#InstallKeybdHook                                                     
#UseHook                                                              
#NoTrayIcon                                                                      
; Ripped from http://www49.atwiki.jp/ntemacs/pages/20.html            
; Thanks a lot!                                                       
SetKeyDelay 0                                                         
SetTitleMatchMode RegEx ; 设置用regex匹配窗口标题，vs2010以上需要
                                                                      
; turns to be 1 when ctrl-x is pressed                                
is_pre_x = 0                                                          
; turns to be 1 when ctrl-space is pressed                            
is_pre_spc = 0                                                        
                                                                      
; Applications you want to disable emacs-like keybindings             
; (Please comment out applications you don't use)                     
is_target()                                                           
{
    IfWinActive, ahk_exe Code.exe ; visual code窗口也是 Chrome_WidgetWin_1
    Return 0    
    ;  IfWinActive,ahk_class ConsoleWindowClass ; Cygwin! sorry but I can't live without far manager                 
    ;    Return 1                                                          
    IfWinActive,ahk_class MEADOW ; Meadow                               
    Return 1                                                          
  IfWinActive,ahk_class cygwin/x X rl-xterm-XTerm-0                   
    Return 1                                                          
  IfWinActive,ahk_class MozillaUIWindowClass ; keysnail on Firefox    
    Return 1                                                          
  ; Avoid VMwareUnity with AutoHotkey                                 
  IfWinActive,ahk_class VMwareUnityHostWndClass                       
    Return 1                                                          
  IfWinActive,ahk_class Vim ; GVIM                                    
    Return 1                                                          
;  IfWinActive,ahk_class SWT_Window0 ; Eclipse                        
;    Return 1                                                         
;   IfWinActive,ahk_class Xming X                                     
;     Return 1                                                        
;   IfWinActive,ahk_class SunAwtFrame                                 
;     Return 1                                                        
   IfWinActive,ahk_class Emacs ; NTEmacs                              
     Return 1                                                         
;   IfWinActive,ahk_class XEmacs ; XEmacs on Cygwin                   
;     Return 1                                                        
; IfWinActive,ahk_class TXGuiFoundation ; QQ注意这个注释符号，前面必须有个空格        
     ; Return 1                                                        
   IfWinActive,ahk_class Chrome_WidgetWin_1 ;                         
      Return 1                                                  
   IfWinActive, ahk_class 360se5_Frame
	  Return 1 
   IfWinActive, ahk_class Chrome_WidgetWin_0
      Return 1      
   IfWinActive, ahk_class fengyue ; ollydbg with StrongOD plugin
      Return 1
   IfWinActive, ahk_class OllyDbg
      Return 1
   IfWinActive, ahk_exe doublecmd.exe
      Return 1
   IfWinActive, ahk_class UnityContainerWndClass
      Return 1
   IfWinActive, ahk_exe hexin.exe
      Return 1
   IfWinActive, ahk_exe DZHTool.exe
      Return 1
   IfWinActive, ahk_exe dzh2.exe
      Return 1
   IfWinActive, ahk_exe TdxW.exe
      Return 1
   IfWinActive, ahk_exe x32dbg.exe
      Return 1      
   IfWinActive, ahk_exe x64dbg.exe
      Return 1
   IfWinActive, ahk_exe firefox.exe
      Return 1
   IfWinActive, ahk_exe Photoshop.exe
      Return 1
   IfWinActive, ahk_exe cheatengine-i386.exe
      Return 1
   IfWinActive, ahk_exe cheatengine-x86_64.exe
      Return 1
   IfWinActive, ahk_exe cheatengine-x86_64-SSE4-AVX2.exe
      Return 1              
   IfWinActive, ahk_exe emacs.exe
      Return 1
   IfWinActive, ahk_exe AfterFX.exe
      Return 1
   IfWinActive, ahk_exe Animate.exe
      Return 1
   IfWinActive, ahk_exe Illustrator.exe
      Return 1      
   IfWinActive, ahk_exe powershell.exe
      Return 1
   IfWinActive, ahk_exe blender.exe
      Return 1
   IfWinActive, ahk_exe CartoonAnimator.exe
      Return 1
   IfWinActive, ahk_exe Photoshop.exe
      Return 1   
;   IfWinActive, ahk_exe idaq64.exe
;      Return 1 
Return 0                                                            
}
is_qtCreator()
{
  IfWinActive, ahk_class Qt5QWindowIcon
   Return 1
  IfWinActive, ahk_class SWT_Window0 ; eclipse
      Return 1
  IfWinActive, ahk_class Chrome_WidgetWin_1 ; visual code
      Return 1          
  Return 0
}
is_vs()
{
  IfWinActive, ahk_class wndclass_desked_gsk ; vs2008
   Return 1
  IfWinActive, ahk_class HwndWrapper\[DefaultDomain.*
   Return 1
  Return 0   
}

is_explorer()
{
  IfWinActive, ahk_class CabinetWClass
   Return 1
  IfWinActive,ahk_class TXGuiFoundation ; QQ注意这个注释符号，前面必须有个空格        
   Return 1  
  Return 0   
}
                                                                     
delete_char()                                                         
{                                                                     
  Send {Del}                                                          
  global is_pre_spc = 0                                               
  Return                                                              
}   
kill_word()
{
  Send ^{Del}
  global is_pre_spc = 0                                               
  Return  
}                                                                  
delete_backward_char()                                                
{                                                                     
  Send {BS}                                                           
  global is_pre_spc = 0                                               
  Return                                                              
}    
backward_kill_word()                                                
{                                                                     
  Send ^{BS}                                                           
  global is_pre_spc = 0                                               
  Return                                                              
}                                                                    
kill_line()                                                           
{
  global is_pre_spc = 0
  If is_vs()
  {
    Send +{END}^x
   }
   else if is_qtCreator()
    Send +{END}^x
   Else
   {
     ClipBoard = ;
     Send, +{Right}^c
     Sleep, 100
     if (Clipboard = "`r`n")
     {
       Send ^x
      }
     Else
      Send +{END}^x
   }
   Return                                                           
}                                                                     
open_line()                                                           
{                                                                     
  Send {END}{Enter}{Up}                                               
  global is_pre_spc = 0                                               
  Return                                                              
}                                                                     
quit()                                                                
{                                                                     
  Send {ESC}                                                          
  global is_pre_spc = 0                                               
  Return                                                              
}                                                                     
newline()                                                             
{                                                                     
  Send {Enter}                                                        
  global is_pre_spc = 0                                               
  Return                                                              
}                                                                     
indent_for_tab_command()                                              
{                                                                     
  Send {Tab}                                                          
  global is_pre_spc = 0                                               
  Return                                                              
}                                                                     
newline_and_indent()                                                  
{                                                                     
  Send {Enter}{Tab}                                                   
  global is_pre_spc = 0                                               
  Return                                                              
}                                                                     
isearch_forward()                                                     
{
    Send ^f
    global is_pre_spc = 0                                               
    Return                                                              
}                                                                     
isearch_backward()                                                    
{                                                                     
  Send ^f                                                             
  global is_pre_spc = 0                                               
  Return                                                              
}                                                                     
kill_region()                                                         
{
  global is_pre_spc = 0
  If is_vs()
    Send ^x
  else if is_qtCreator()
     Send +{DEL}
  Else ; if not select any words, cut the line
   {
     ClipBoard = ;
     Send ^c
     Sleep, 100
     if (Clipboard = "")
     {
       Send, {Home}+{Left}^c
       Sleep, 100
       if (Clipboard = "`r`n")
        Send, {Right}+{End}+{Right}^x
       Else
        {
	if is_explorer()
	 Send ^w
	Else
	 Send, {Home 2}+{End}+{Right}^x
	}
      }
     Else
      Send ^x
   }
   Return
}                                                                     
kill_ring_save()
{
  Send ^c                                                             
  global is_pre_spc = 0                                               
  Return                                                              
}                                                                     
yank()
{
  Send ^v
  global is_pre_spc = 0                                               
  Return
}
yank_pop()
{
  If is_vs()
    Send ^+{Insert}
  if is_qtCreator()
    send ^+V
  Else
    Send ^v
  global is_pre_spc = 0
  global is_pre_x = 0                                               
  Return
}                                                                    
undo()                                                                
{                                                                     
  Send ^z                                                             
  global is_pre_spc = 0                                               
  Return                                                              
}            
redo() ; in most editor
{
  Send ^y 
  global is_pre_spc = 0   
  Return
}                                                         
find_file()                                                           
{                                                                     
  Send ^o                                                             
  global is_pre_x = 0                                                 
  Return                                                              
}                                                                     
save_buffer()                                                         
{                                                                     
  Send ^s                                                            
  global is_pre_x = 0                                                 
  Return                                                              
}
mark_whole_buffer()
{
  Send ^a                                              
  global is_pre_x = 0
  Return
}  
mark_page()
{
  Send ^a                                              
  global is_pre_x = 0
  Return
}                                                              
kill_emacs()                                                          
{                                                                     
  Send !{F4}                                                          
  global is_pre_x = 0                                                 
  Return                                                              
}
move_beginning_of_line()                                              
{                                                                     
  global                                                              
  if is_pre_spc                                                       
    Send +{HOME}                                                      
  Else                                                                
    Send {HOME}                                                       
  Return                                                              
}                                                                     
move_end_of_line()                                                    
{                                                                     
  global                                                              
  if is_pre_spc                                                       
    Send +{END}                                                       
  Else                                                                
    Send {END}                                                        
  Return                                                              
}                                                                     
previous_line()                                                       
{                                                                     
  global                                                              
  if is_pre_spc                                                       
    Send +{Up}                                                        
  Else                                                                
    Send {Up}                                                         
  Return                                                              
}                                                                     
next_line()                                                           
{                                                                     
  global                                                              
  if is_pre_spc                                                       
    Send +{Down}                                                      
  Else                                                                
    Send {Down}                                                       
  Return                                                              
}                                                                     
forward_char()                                                        
{                                                                     
  global                                                              
  if is_pre_spc                                                       
    Send +{Right}                                                     
  Else                                                                
    Send {Right}                                                      
  Return                                                              
}                                                                     
forward_word()                                                        
{                                                                     
  global                                                              
  if is_pre_spc                                                       
    Send ^+{Right}                                                    
  Else                                                                
    Send ^{Right}
  Return                                                              
}                                                                     
backward_char()                                                       
{                                                                     
  global                                                              
  if is_pre_spc                                                       
    Send +{Left}                                                      
  Else                                                                
    Send {Left}
  Return                                                              
}                                                                     
backward_word()                                                       
{                                                                     
  global                                                              
  if is_pre_spc                                                       
    Send ^+{Left}                                                      
  Else                                                                
    Send ^{Left}                                                       
  Return                                                              
}                                                                     
scroll_up()                                                           
{                                                                     
  global                                                              
  if is_pre_spc                                                       
    Send +{PgUp}                                                      
  Else                                                                
    Send {PgUp}                                                       
  Return                                                              
}                                                                     
scroll_down()                                                         
{                                                                     
  global                                                              
  if is_pre_spc                                                       
    Send +{PgDn}                                                      
  Else                                                                
    Send {PgDn}                                                       
  Return                                                              
}
go_back()
{
  If is_vs()
    Send ^{vkBDsc00C} ;; C--
  else if is_qtCreator()
     Send !{Left}
}
go_forward()
{
  If is_vs()
    Send ^+{vkBDsc00C} ;;C-S--
  else if is_qtCreator()
     Send !{Right}
}
                                                                      
^x::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
    is_pre_x = 1                                                      
  Return                                                              
^f::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
  {                                                                   
    If is_pre_x                                                       
      find_file()                                                     
    Else                                                              
      forward_char()                                                  
  }                                                                   
  Return                                                              
!f::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
    forward_word()                                                    
  Return                                                              

^h::
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else
  {
      delete_backward_char()
  }
  Return
!h::
  If is_target()
    Send %A_ThisHotkey%
  Else
    backward_kill_word()
  Return
^d::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
    delete_char()                                                     
  Return   
!d::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
    kill_word()                                                     
  Return                                                              

^k::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
    kill_line()                                                       
  Return                                                              
;; ^o::                                                               
;;   If is_target()                                                   
;;     Send %A_ThisHotkey%                                            
;;   Else                                                             
;;     open_line()                                                    
;;   Return                                                           
^g::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
    quit()                                                            
  Return                                                              
;; ^j::                                                               
;;   If is_target()                                                   
;;     Send %A_ThisHotkey%                                            
;;   Else                                                             
;;     newline_and_indent()                                           
;;   Return                                                           
; ^m::                                                                  
;   If is_target()                                                      
;     Send %A_ThisHotkey%                                               
;   Else                                                                
;     newline()                                                         
;   Return                                                              
; ^i::                                                                  
;   If is_target()                                                      
;     Send %A_ThisHotkey%                                               
;   Else                                                                
;     indent_for_tab_command()                                          
;   Return                                                              
^s::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
  {                                                                   
    If is_pre_x                                                       
      save_buffer()                                                   
    Else                                                              
      isearch_forward()                                               
  }                                                                   
  Return                                                              
;^r::                                                                  
  ;  If is_target()                                                      
  ;    Send %A_ThisHotkey%                                               
  ;  Else                                                                
  ;    isearch_backward()                                                
  ;  Return                                                              
^w::                                                                  
If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
    kill_region()                                                     
  Return                                                              
!w::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
    kill_ring_save()                                                  
  Return                                                              
^y::
  If is_target()                                                      
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      yank_pop() ; !y don't work
    Else
      yank()
  }
  Return
^/::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
    undo()                                                            
  Return                                                              
^u::                                                                  
  If is_target()                                                      
      Send %A_ThisHotkey%                                               
  Else                                                                
      redo()                                                            
  Return 
                                                                        
^a::                                                                  
If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
    move_beginning_of_line()                                          
  Return                                                           
^e::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
    move_end_of_line()                                                
  Return                                                              
^p::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else
  {
    If is_pre_x
      mark_page()
    Else
      previous_line()
  }
  Return                                                              
^n::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
    next_line()                                                       
  Return                                                              
^b::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
    backward_char()                                                   
  Return
^vk6D:: ;; numpadsub
  If is_target()                                                      
    Send %A_ThisHotkey%
  Else
    go_back()
  Return
^vk6B:: ;; numpadadd
  If is_target()                                                      
    Send %A_ThisHotkey%
  Else
    go_forward()
  Return
!b::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
    backward_word()                                                   
  Return                                                           
; ^v::                                                                
;   If is_target()                                                    
;     Send %A_ThisHotkey%                                             
;   Else                                                              
;     scroll_down()                                                   
;   Return                                                            
!v::                                                                  
  If is_target()                                                      
    Send %A_ThisHotkey%                                               
  Else                                                                
    scroll_up()                                                       
  Return                                                              
                                                                      
                                                                      
