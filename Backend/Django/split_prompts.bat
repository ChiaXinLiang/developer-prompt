@echo off
setlocal enabledelayedexpansion

chcp 65001 > nul

set "file=prompts.txt"
set "current_file="
set "line_count=0"
set "total_lines=0"
set "index="
set "title="

if not exist "%file%" (
    echo Error: %file% not found.
    goto :eof
)

for /f "usebackq delims=" %%a in ("%file%") do (
    set /a "total_lines+=1"
    set "line=%%a"
    if "!line:~0,1!" geq "1" if "!line:~0,1!" leq "9" (
        if defined current_file (
            echo Saving !current_file! with !line_count! lines.
            (echo !content!) > "!current_file!"
        )
        set "index=!line:~0,1!"
        set "title=!line:~3!"
        set "current_file=_!index!_!title!"
        set "current_file=!current_file:?=!"
        set "current_file=!current_file::=!"
        set "current_file=!current_file:"=!"
        set "current_file=!current_file:'=!"
        set "current_file=!current_file:<=!"
        set "current_file=!current_file:>=!"
        set "current_file=!current_file:|=!"
        set "current_file=!current_file:\=!"
        set "current_file=!current_file:/=!"
        set "current_file=!current_file: =_!"
        set "current_file=!current_file!.txt"
        echo Creating new file: !current_file!
        set "content="
        set "line_count=0"
    ) else (
        set /a "line_count+=1"
        if !line_count! gtr 1 (
            set "content=!content!!line!^

"
        )
    )
)

if defined current_file (
    echo Saving last file !current_file! with !line_count! lines.
    (echo !content!) > "!current_file!"
)

echo Splitting complete. Processed !total_lines! lines.