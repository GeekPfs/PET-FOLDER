@echo off
title Atualizador

echo Baixando atualizacao...

:: URL do ZIP do repositorio
set ZIP_URL=https://github.com/GeekPfs/regpast/archive/refs/heads/main.zip

:: Arquivos temporarios
set ZIP_FILE=update.zip
set TEMP_DIR=update_temp

:: Limpa temporarios antigos
if exist %ZIP_FILE% del %ZIP_FILE%
if exist %TEMP_DIR% rmdir /s /q %TEMP_DIR%

:: Baixa ZIP
powershell -Command "Invoke-WebRequest -Uri '%ZIP_URL%' -OutFile '%ZIP_FILE%'"

echo Extraindo arquivos...

:: Extrai ZIP
powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%TEMP_DIR%'"

echo Atualizando pasta content...

:: Remove content antiga
if exist content rmdir /s /q content

:: Copia nova content
xcopy "%TEMP_DIR%\regpast-main\content" "content" /e /i /y

:: Limpeza
del %ZIP_FILE%
rmdir /s /q %TEMP_DIR%

echo.
echo Atualizacao concluida!
pause