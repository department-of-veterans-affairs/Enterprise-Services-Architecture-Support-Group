rem gets current directory folder name
set aFolder=%CD:~69%

rem Dependencies
rem pandoc (converts .docx to .mediawiki)
rem magick (converts images extracted from pandoc into .png)
rem Repo department-of-veterans-affairs/ES-ASG must be located at C:\GitHub\ES-ASG
rem Repo department-of-veterans-affairs/ES-ASG.wiki must be located at C:\GitHub\ES-ASG.wiki
rem GitHub Desktop will install git command line

rem Recommend to synch Repo's before starting

rem Get the URL from GitHub using a browser.  This is in the /media folder of each Section.  Replace /blob/ with /raw/ and replace all %%20 with %%20 (for Powershell below)
rem set aImage="https://github.com/department-of-veterans-affairs/ES-ASG/raw/master/Projects/ES%%20ASG/ES%%20ASG%%20API%%20Playbook%%20Project/Content/01.00%%20ASG_API%%20Playbook_Introduction_Section/media/"

set aRoot=https://github.com/department-of-veterans-affairs/ES-ASG/raw/master/Projects/ES%%20ASG/ES%%20ASG%%20API%%20Playbook%%20Project/Content/
SETLOCAL ENABLEDELAYEDEXPANSION
set aRepo=%aRoot%!aFolder: =%%20!
set aImage="%aRepo%/media/"

rmdir media

rem get the last .docx file
for /R %%f in (*.docx) do set aFile=%%~nf

rem convert .docx to .mediawiki and extract images
pandoc --extract-media ./ -t mediawiki -o "%aFile%.mediawiki" "%aFile%.docx"

rem Add TOC to the beginning of the file
powershell -Command "'__TOC__' + (13 -as [char]) + (10 -as [char]) + (gc '%aFile%.mediawiki' -encoding UTF8 | Out-String) | Out-File '%aFile%.mediawiki'" -encoding UTF8

rem Insert URL of content source
powershell -Command "'<a href=' + (39 -as [char]) + '%aRepo%' + (39 -as [char]) + '>Wiki source content can be found here.</a>' + (13 -as [char]) + (10 -as [char]) + (gc '%aFile%.mediawiki' -encoding UTF8 | Out-String) | Out-File '%aFile%.mediawiki'" -encoding UTF8

rem Fix up image URLs: replacing image types .emf, .jpeg, .jpg, .gif, .tmp with .png; replace File: URL with current section set as aImage above
powershell -Command "(gc '%aFile%.mediawiki' -encoding UTF8) -replace '.emf', '.png' -replace '.jpeg', '.png' -replace '.jpg', '.png' -replace '.gif', '.png' -replace '.tmp', '.png' -replace 'File:.//media/', '%aImage%' | Out-File '%aFile%.mediawiki'" -encoding UTF8

rem housekeeping and move Wiki for publishing
del *.bak
copy "%aFile%.mediawiki" "C:\GitHub\ES-ASG.wiki"

rem convert all image files to .png
cd media
for /R %%f in (*.emf) do (
	magick %%~nf.emf %%~nf.png
)

for /R %%f in (*.jpeg) do (
	magick %%~nf.jpeg %%~nf.png
)

for /R %%f in (*.jpg) do (
	magick %%~nf.jpg %%~nf.png
)

for /R %%f in (*.tmp) do (
	magick %%~nf.tmp %%~nf.png
)

for /R %%f in (*.gif) do (
	magick %%~nf.gif %%~nf.png
)

rem push to GitHub Repo

git add -f --all
git commit -m "Publish"
git push --all

cd "C:\GitHub\ES-ASG.wiki"

git add -f --all
git commit -m "Publish"
git push --all

