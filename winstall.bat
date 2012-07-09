rm %HOMEDRIVE%%HOMEPATH%\_vimrc
rm %HOMEDRIVE%%HOMEPATH%\_gvimrc
rm -R %HOMEDRIVE%%HOMEPATH%\vimfiles
rm -R %HOMEDRIVE%%HOMEPATH%\vimfiles

cp -R .vim %HOMEDRIVE%%HOMEPATH%\vimfiles
cp .vimrc %HOMEDRIVE%%HOMEPATH%\_vimrc
cp .gvimrc %HOMEDRIVE%%HOMEPATH%\_gvimrc

