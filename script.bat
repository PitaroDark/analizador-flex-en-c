@echo off
flex src/main.l
echo "FLEX Compilo la especificacion lexica del archivo 'main.l' (Se creo un archivo lex.yy.c)"
pause
gcc lex.yy.c -o compilado.exe
echo "Finalizo la ejecucion del compilador de C sobre el archivo lex.yy.c (Se creo el archivo compilado.exe)"
pause
compilado.exe archives/main.C
del lex.yy.c
del compilado.exe
echo "Se han borrado los archivos generados, finalizando..."
pause
cls