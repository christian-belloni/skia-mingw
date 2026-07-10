# Maintainer: Naveen M K <naveen521kk at gmail.com>
# Contributor: Raed Rizqie <raed.rizqie@gmail.com>


_realname=skia
pkgbase=mingw-w64-${_realname}
pkgname="${MINGW_PACKAGE_PREFIX}-${_realname}"
pkgver=148.r78869.3f465e40
pkgrel=1
pkgdesc="Skia is a complete 2D graphic library for drawing Text, Geometries, and Images (mingw-w64)"
arch=('any')
mingw_arch=('mingw64' 'ucrt64' 'clang64' 'clangarm64')
url="https://skia.org"
msys2_repository_url="https://skia.googlesource.com/skia"
msys2_documentation_url="https://skia.org/docs"
license=("spdx:BSD-3-Clause")
depends=("${MINGW_PACKAGE_PREFIX}-cc-libs"
         "${MINGW_PACKAGE_PREFIX}-expat"
         "${MINGW_PACKAGE_PREFIX}-harfbuzz"
         "${MINGW_PACKAGE_PREFIX}-icu"
         "${MINGW_PACKAGE_PREFIX}-libpng"
         "${MINGW_PACKAGE_PREFIX}-libjpeg-turbo"
         "${MINGW_PACKAGE_PREFIX}-libwebp"
         "${MINGW_PACKAGE_PREFIX}-zlib")
makedepends=("${MINGW_PACKAGE_PREFIX}-cc"
             "${MINGW_PACKAGE_PREFIX}-gn"
             "${MINGW_PACKAGE_PREFIX}-ninja"
             "${MINGW_PACKAGE_PREFIX}-pkgconf"
             "${MINGW_PACKAGE_PREFIX}-python"
             "git")
_commit="3f465e408337f13a543849ec70c767b2c5e6eeb3"
source=("${_realname}::git+https://github.com/rust-skia/skia.git#commit=3f465e408337f13a543849ec70c767b2c5e6eeb3"
        "bare-clones/zlib::git+https://chromium.googlesource.com/chromium/src/third_party/zlib.git#commit=646b7f569718921d7d4b5b8e22572ff6c76f2596"
	"bare-clones/vulkanmemoryallocator::git+https://chromium.googlesource.com/external/github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator.git#commit=a6bfc237255a6bac1513f7c1ebde6d8aed6b5191"
	"bare-clones/icu::git+https://chromium.googlesource.com/chromium/deps/icu.git#commit=364118a1d9da24bb5b770ac3d762ac144d6da5a4"
        "0001-support-freya.patch"
	      "extract_defines.sh"
        "skia.pc")
sha256sums=('d286c8e6b126bb05e41a396f6a4ff05f482bdf6301e08fc468c50e3b00630e54'
            '967acb8025f9af3f1a5d4d4e9ab671a65fd9b1a52e93081683f84167077c979b'
            'dcf53889391c422d673ebfebec2d3183841463ea8a3b88941e83ecb541c87c8c'
            '357b71c5341d247d2a68dbd800de31d912f47aeb5b94dc484ca9833eb02dafbc'
            '5cba819d79d9e84fbb44daf2d756843acd2acade8ec5e977514e265719818363'
            '1f9ee59ed091317af894be45a0e669068f0816d623ecfe46dfe4ed2301a2abe7'
            'f0b20d04cee41207a6f974d468e05be63dc3f7ed02992e118660b5bf279e757b')

apply_patch_with_msg() {
  for _patch in "$@"; do
      msg2 "Applying $_patch"
      patch -Nbp1 -i "${srcdir}/$_patch"
  done
}

pkgver() {
  git clone --filter=blob:none --revision "${_commit}" https://github.com/rust-skia/skia.git skia_temp
  cd skia_temp
  local _milestone=$(grep -Eo "Milestone ([0-9]+)" RELEASE_NOTES.md | head -1 | cut -f 2 -d ' ')
  printf "%s.r%s.%s" "${_milestone}" "$(git rev-list --count HEAD)" "$(git rev-parse --short=8 "${_commit}")"
  cd ..
  rm -Rf skia_temp
}

prepare() {
  # mv "${_realname}-${_commit}" "${_realname}"
  cd ${_realname}
  apply_patch_with_msg \
    0001-support-freya.patch


  mkdir -p third_party/externals/zlib
  cp -r "${srcdir}"/zlib/* third_party/externals/zlib/

  mkdir -p third_party/externals/
  cp -r "${srcdir}"/vulkan* third_party/externals/
  cp -r "${srcdir}"/icu third_party/externals/

  # gn is expected to be in skia/bin
  cp ${MINGW_PREFIX}/bin/gn.exe bin/gn.exe

  sed -e "s|@PREFIX@|${MINGW_PREFIX}|g" \
      -e "s|@VERSION@|${pkgver}|g" -i "${srcdir}"/skia.pc
}

build() {
  local _buildtype=Release
  local _debug=false
  local _official=true
  if check_option "debug" "y"; then
      _buildtype=Debug
      _debug=true
      _official=false
  fi

  local _arch=x64
  if [[ ${CARCH} == aarch64 ]]; then
      _arch=arm64
  fi


  cd ${_realname}
  gn gen out/${_buildtype}-${MSYSTEM} --args="
    target_cpu=\"${_arch}\"
    cc=\"${CC}\"
    cxx=\"${CXX}\"
    is_debug=${_debug}
    is_official_build=${_official}
    is_component_build=false
    skia_use_dng_sdk=false
    skia_use_wuffs=false
    skia_use_xps=false
    skia_enable_skshaper=true
    skia_use_icu=true
    skia_use_harfbuzz=true
    skia_enable_skparagraph=true
    skia_enable_svg=true
    skia_use_vulkan=true
    skia_enable_spirv_validation=false
    skia_use_gl=true
    skia_use_libwebp_encode=true
    skia_use_libwebp_decode=true"

  "${srcdir}"/extract_defines.sh
  mkdir -p out/${_buildtype}-${MSYSTEM}
  mv skia_defines.txt out/${_buildtype}-${MSYSTEM}/
  ninja -C out/${_buildtype}-${MSYSTEM}
}

package() {
  cd ${_realname}

  local _buildtype=Release
  if check_option "debug" "y"; then
    _buildtype=Debug
  fi

  current_dir=$(pwd)
  cd "${srcdir}"
  tar -cz -f skia.tar.gz skia/*
  cd "${current_dir}"

  cp "${srcdir}"/skia.tar.gz .

  install -d "${pkgdir}"/${MINGW_PREFIX}/lib
  install -Dm755 out/${_buildtype}-${MSYSTEM}/*.a "${pkgdir}"/${MINGW_PREFIX}/lib/
  install -Dm755 out/${_buildtype}-${MSYSTEM}/skia_defines.txt "${pkgdir}"/${MINGW_PREFIX}/lib/
  install -Dm755 "${srcdir}"/icu/common/icudtl.dat "${pkgdir}"/${MINGW_PREFIX}/lib/

  install -d "${pkgdir}"/${MINGW_PREFIX}/include/skia
  cp --parents `find ./include -name \*.h` "$pkgdir"/${MINGW_PREFIX}/include/skia
  cp --parents `find ./modules -name \*.h` "$pkgdir"/${MINGW_PREFIX}/include/skia

  install -d "${pkgdir}"/${MINGW_PREFIX}/lib/pkgconfig
  install -Dm644 "${srcdir}/skia.pc" "${pkgdir}"/${MINGW_PREFIX}/lib/pkgconfig/

  install -d "${pkgdir}"/${MINGW_PREFIX}/share/licenses/skia
  install -Dm644 LICENSE* "${pkgdir}"/${MINGW_PREFIX}/share/licenses/${_realname}/
}
