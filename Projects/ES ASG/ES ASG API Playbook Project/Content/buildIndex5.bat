SETLOCAL ENABLEDELAYEDEXPANSION

cd "C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content"
echo "<^!-- Index Start -->">"C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\TOC.txt"
echo "<h3>Last Generated: [%date%, %time%]</h3>">>"C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\TOC.txt"
echo "<ul>">>"C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\TOC.txt"

for /r %%i in (.) do (

	if "%%i"=="C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\." (echo pass) else (

  	cd %%i

		call "C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\buildindex5a"

		cd "C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content"
	)

)
echo "</ul>">>"C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\TOC.txt"
echo "<^!-- Index Stop -->">>"C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\TOC.txt"

c:\GitHub\AutoHotkeyU64.exe "C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\ReplaceText.ahk"
