@echo off
title Atualizador

echo Baixando atualizacao...

set ZIP_URL=https://github.com/GeekPfs/PET-FOLDER/archive/refs/heads/main.zip
set ZIP_FILE=update.zip
set TEMP_DIR=update_temp
set REPO_FOLDER=PET-FOLDER-main

:: Limpeza
if exist "%ZIP_FILE%" del "%ZIP_FILE%"
if exist "%TEMP_DIR%" rmdir /s /q "%TEMP_DIR%"

:: Download
powershell -Command "Invoke-WebRequest -Uri '%ZIP_URL%' -OutFile '%ZIP_FILE%'"

echo Extraindo arquivos...

:: Extract
powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%TEMP_DIR%'"

:: Caminho da content no zip
set ZIP_CONTENT=%TEMP_DIR%\%REPO_FOLDER%\content

echo Verificando conteudo no update...

:: Só atualiza se existir content no ZIP
if exist "%ZIP_CONTENT%" (

    echo Content encontrada no update. Aplicando...

    :: Agora sim remove local SE existir
    if exist "content" (
        rmdir /s /q "content"
    )

    :: Copia nova versão
    xcopy "%ZIP_CONTENT%" "content\" /e /i /y

) else (
    echo Nenhuma pasta content encontrada no update. Nada sera alterado.
)

:: Limpeza
del "%ZIP_FILE%"
rmdir /s /q "%TEMP_DIR%"

echo.
echo Atualizacao finalizada!
pause
