#SingleInstance force

;Declare Class
Class gentoo_copy{
	Get(){
		WinGetTitle, title_var, ahk_exe VirtualBox.exe
		This.Title := title_var
	}
	Activate(){
		IfWinExist, % This.Title
			WinActivate
		else
			msgbox, % "This win isnt detected. Title : " This.Title
	}
	Copy_Paste(){
		If WinActive(This.Title)
			Send, {RAW}%clipboard%
	}
	Clear(){
		clipboard =
	}
}


;Declare Instance
copy_inst := New gentoo_copy
Return

;Hotkeys to Run Instance Method
^F5::
copy_inst.Get()
IF copy_inst.title{
	copy_inst.Activate()
	copy_inst.Copy_Paste()
	Return
} else
msgbox, % "This aint working. id is : " copy_inst.title
Return

F8::
copy_inst.Get()
copy_inst.Activate()
Return
