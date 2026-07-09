# Maintainer: Naveen M K <naveen521kk at gmail.com>
# Contributor: Raed Rizqie <raed.rizqie@gmail.com>

_realname=skia
pkgbase=mingw-w64-${_realname}
pkgname="${MINGW_PACKAGE_PREFIX}-${_realname}"
pkgver=143.r77119.da51f0d6
pkgrel=5
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
_commit="da51f0d60ea2b14e845a823dc11b405dbeef42d8"
source=("${_realname}.tar.gz::https://github.com/google/skia/archive/${_commit}.tar.gz"
        "bare-clones/zlib::git+https://chromium.googlesource.com/chromium/src/third_party/zlib.git#commit=646b7f569718921d7d4b5b8e22572ff6c76f2596"
	"bare-clones/vulkanmemoryallocator::git+https://chromium.googlesource.com/external/github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator.git#commit=eb744ea7a2b17040121b4bbb4d6f9e8a77e3cae7"
	"bare-clones/vulkan-deps::git+https://chromium.googlesource.com/vulkan-deps#commit=bbc872ec2e938f2ee087a7058e9f3d4716755f96"
	"bare-clones/vulkan-headers::git+https://chromium.googlesource.com/external/github.com/KhronosGroup/Vulkan-Headers#commit=8d6039a455a7ecc7d2a592ff97f62db4e59b70bf"
	"bare-clones/vulkan-tools::git+https://chromium.googlesource.com/external/github.com/KhronosGroup/Vulkan-Tools#commit=6d586e9a4f0d5ffdef862149adaf1ec6b3130182"
	"bare-clones/vulkan-utility-libraries::git+https://chromium.googlesource.com/external/github.com/KhronosGroup/Vulkan-Utility-Libraries#commit=c0e15b2c46f9ae2314925cbbe9d97ed6ea8a717d"
        "0001-add-pkgconfig-support.patch"
        "0002-add-mingw-toolchain-skia.patch"
        "0003-fix-dwrite-function-mingw.patch"
        "0004-misc-mingw-fixes.patch"
        "0005-external-packages-update.patch"
        "0006-integrates-svg-into-skia-lib.patch"
        "0007-Reland-Make-SkPath-immutable-on-GN-build.patch"
        "0008-dwrite.patch"
        "0009-allow-opengl-aarch64.patch"
	"0010-support-vulkan.patch"
        "skia.pc")
sha256sums=('63eee9235414e0171dec6b47d54a5b55057c4b38fce4514bdfc8003b5713a761'
            '967acb8025f9af3f1a5d4d4e9ab671a65fd9b1a52e93081683f84167077c979b'
            '81e4ae6b5d52e3373ad8db9e847a5b5719f2f6a5ee263ba19e8db4ad10d45f10'
            '8c8b45c34a54085d8de6cb7edc36fa8013cfa4f1cb18129b7709c1b109f72d30'
            '7452187a48f61636911e62ca95a3c92e137037e5198ca3608cb07e11f5243c01'
            '5ab9b9f5d3ee4b7a20437af2c738c520261925479e306ea50b13ce4165291eed'
            'dddf6bf1b5b2e350789188e0e57b6b6073ff1f550e7eb3be54168473d142ef1c'
            '7440572487b8bc33ac7a8445de0cc4148e0d47b538ba46f4952ba8cc97e0fa52'
            '227a070cf5b02a5e265749df14551228ec841f926d922666b0ec96948dc96e16'
            '107526f649a31ff87033608cb1f55c0922d6bd40fa3c8c769ed0320b9230cde6'
            '4321f3dec1b2be7fc4e36b017c7b389179d1cf63b0a0ef7218638cfb99fd07a2'
            '9ad4b876437bc83df8baf72051c9e919529a754b681c434316f119e8440d8996'
            '1ead6b6e2e706b20f070ea3f86ca05648fedcc6afa70d415c5e39bd3712a1e7e'
            '995352c9149e6578d07f8a82d472b29df51ea927545e77ee1a2b81bdcfaddb02'
            '70cbe7b0cec3ae08a6ff74a738953ad09119c6227b272d7198f56a5f45740fd5'
            '830e62231ca3c17053e928e2ea7a03944ac3b3cb929bd17532abf4a80f7207e5'
            '7709a72778a36bbcb8af7034424514e331620cf7cb8d6282b4b651b7a0a3cbce'
            'f0b20d04cee41207a6f974d468e05be63dc3f7ed02992e118660b5bf279e757b')

apply_patch_with_msg() {
  for _patch in "$@"; do
      msg2 "Applying $_patch"
      patch -Nbp1 -i "${srcdir}/$_patch"
  done
}

pkgver() {
  git clone --filter=blob:none --revision "${_commit}" https://skia.googlesource.com/skia.git skia_temp
  cd skia_temp
  local _milestone=$(grep -Eo "Milestone ([0-9]+)" RELEASE_NOTES.md | head -1 | cut -f 2 -d ' ')
  printf "%s.r%s.%s" "${_milestone}" "$(git rev-list --count HEAD)" "$(git rev-parse --short=8 "${_commit}")"
  cd ..
  rm -Rf skia_temp
}

prepare() {
  mv "${_realname}-${_commit}" "${_realname}"
  cd ${_realname}
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

  mkdir -p third_party/externals/zlib
  cp -r "${srcdir}"/zlib/* third_party/externals/zlib/

  mkdir -p third_party/externals/
  cp -r "${srcdir}"/vulkan* third_party/externals/

  # python3 tools/git-sync-deps -h
  # python3 bin/fetch-ninja

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
    is_component_build=true
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

  ninja -C out/${_buildtype}-${MSYSTEM}
}

package() {
  cd ${_realname}

  local _buildtype=Release
  if check_option "debug" "y"; then
    _buildtype=Debug
  fi

  install -d "${pkgdir}"/${MINGW_PREFIX}/bin
  install -Dm755 out/${_buildtype}-${MSYSTEM}/*.dll "${pkgdir}"/${MINGW_PREFIX}/bin/

  install -d "${pkgdir}"/${MINGW_PREFIX}/lib
  install -Dm755 out/${_buildtype}-${MSYSTEM}/*.dll.a "${pkgdir}"/${MINGW_PREFIX}/lib/

  install -d "${pkgdir}"/${MINGW_PREFIX}/include/skia
  cp --parents `find ./include -name \*.h` "$pkgdir"/${MINGW_PREFIX}/include/skia
  cp --parents `find ./modules -name \*.h` "$pkgdir"/${MINGW_PREFIX}/include/skia

  install -d "${pkgdir}"/${MINGW_PREFIX}/lib/pkgconfig
  install -Dm644 "${srcdir}/skia.pc" "${pkgdir}"/${MINGW_PREFIX}/lib/pkgconfig/

  install -d "${pkgdir}"/${MINGW_PREFIX}/share/licenses/skia
  install -Dm644 LICENSE* "${pkgdir}"/${MINGW_PREFIX}/share/licenses/${_realname}/
}
