rem   this is some real galaxy brained shit and i'm VERY sorry
rem   this script will detect if mpv is running & if it is, queue up the youtube video you've given it and if it's not running it'll open a new instance with the right pipe name.
rem   due to me not wanting to have to quote urls i have a check in here to reconstruct broken youtube links because equal signs break arguments

tasklist /fi "ImageName eq mpv.exe" /fo csv 2>NUL | find /I "mpv.exe">NUL

if "%ERRORLEVEL%"=="0" (set runningflag=1 && echo "Instance of MPV running") else (set runningflag=0 && echo "No instance of MPV running")

if %1 equ https://youtube.com/watch?v (set url=%1=%2) ELSE (if %1 equ https://www.youtube.com/watch?v (set url=%1=%2) ELSE (set url=%1))

echo Running Flag %runningflag%

echo %url%

if %runningflag% equ 1 (echo "Appending!" && echo loadfile %url% append-play > \\.\pipe\mpvsocket ) else ( echo "Fresh Instance" && start "" "C:\Program Files\MPV\mpv.exe"  --input-ipc-server=\\.\pipe\mpvsocket  %url% )
