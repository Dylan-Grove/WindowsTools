@echo off

set citrix=C:\Users\%username%\AppData\Local\Citrix
set reportq=C:\Users\%username%\AppData\Local\Microsoft\Windows\WER\ReportQueue


REM check for Citrix folder, delete it if it does
if exist %citrix% (
	rmdir %citrix% /S/Q
	echo Citrix folder deleted.
) else (
	echo Citrix folder not found.
)


REM check for ReportQueue folder, change directory to it if it does exist
if exist %reportq% (
	cd /d %reportq%
	echo Changed directory to ReportQueue folder.
) Else (
	echo ReportQueue folder not found.
        pause
)
	

REM doublecheck that system is not currently in ReportQueue folder.
if %cd%==%reportq% (
	for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /S/Q || del "%%i" /S/Q)
	echo ReportQueue folder cleared.

) Else (
	echo Current directory is not ReportQueue folder.
)