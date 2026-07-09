srcdir=$(pwd)

apply_patch_with_msg() {
  for _patch in "$@"; do
      echo "Applying $_patch"
      patch -Nbp1 -i "${srcdir}/$_patch"
  done
}

tar xvf skia.tar.gz
rm skia.tar.gz

mv skia-da51f0d60ea2b14e845a823dc11b405dbeef42d8 skia

cd skia

apply_patch_with_msg \
    0001-add-pkgconfig-support.patch \
    0002-add-mingw-toolchain-skia.patch \
    0003-fix-dwrite-function-mingw.patch \
    0004-misc-mingw-fixes.patch \
    0005-external-packages-update.patch \
    0006-integrates-svg-into-skia-lib.patch \
    0008-dwrite.patch \
    0009-allow-opengl-aarch64.patch \
    0010-support-vulkan.patch

patch -R -Nbp1 -i "${srcdir}/0007-Reland-Make-SkPath-immutable-on-GN-build.patch"

cd ..

tar -cvz -f skia.tar.gz skia/
