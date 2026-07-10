srcdir=$(pwd)

apply_patch_with_msg() {
  for _patch in "$@"; do
      echo "Applying $_patch"
      patch -Nbp1 -i "${srcdir}/$_patch"
  done
}

tar xvf skia.tar.gz
rm skia.tar.gz

cd skia

apply_patch_with_msg \
    0001-support-freya.patch

patch -R -Nbp1 -i "${srcdir}/0007-Reland-Make-SkPath-immutable-on-GN-build.patch"

cd ..

tar -cvz -f skia-$1.tar.gz skia/
