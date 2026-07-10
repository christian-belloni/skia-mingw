srcdir=$(pwd)

apply_patch_with_msg() {
  for _patch in "$@"; do
      echo "Applying $_patch"
      patch -Nbp1 -i "${srcdir}/$_patch"
  done
}

rm -rf skia
cp -r src/skia .

tar -cvz -f skia-$1.tar.gz skia/
