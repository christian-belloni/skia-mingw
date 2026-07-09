for arch in 'mingw64' 'ucrt64' 'clang64' 'clangarm64';
do
	MINGW_ARCH=$arch makepkg-mingw --cleanbuild --syncdeps --force --noconfirm
done