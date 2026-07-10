srcdir=$(pwd)

apply_patch_with_msg() {
  for _patch in "$@"; do
      echo "Applying $_patch"
      patch -Nbp1 -i "${srcdir}/$_patch"
  done
}

cd skia

apply_patch_with_msg \
    0001-support-freya.patch

cd ..

tar -cvz -f skia-$1.tar.gz skia/
