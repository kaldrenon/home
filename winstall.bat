del %HOMEDRIVE%%HOMEPATH%\_vimrc
del %HOMEDRIVE%%HOMEPATH%\_gvimrc
rmdir /S /Q %HOMEDRIVE%%HOMEPATH%\vimfiles

xcopy /S /E /C .vim\*.* %HOMEDRIVE%%HOMEPATH%\vimfiles\*.*
copy .vimrc %HOMEDRIVE%%HOMEPATH%\_vimrc
copy .gvimrc %HOMEDRIVE%%HOMEPATH%\_gvimrc

