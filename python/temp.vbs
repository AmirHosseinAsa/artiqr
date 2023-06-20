Set oShell = CreateObject("WScript.Shell") 
oShell.Run "cmd /c python -m flask run -p 7169", 0, False 
Set oShell = Nothing 
