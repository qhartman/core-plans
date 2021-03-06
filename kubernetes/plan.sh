pkg_name=kubernetes
pkg_origin=core
pkg_description="Production-Grade Container Scheduling and Management"
pkg_upstream_url=https://github.com/kubernetes/kubernetes
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=1.11.1
pkg_source=https://github.com/kubernetes/kubernetes/archive/v${pkg_version}.tar.gz
pkg_shasum=073b77321812f26df6513c0ad0aef3a8b0c17f6281a186d515f5855ae009ea17

pkg_bin_dirs=(bin)

pkg_build_deps=(
  core/git
  core/make
  core/gcc
  core/go
  core/diffutils
  core/which
  core/rsync
  core/coreutils
)

pkg_deps=(
  core/glibc
  core/coreutils
)

do_prepare() {
  # The `/usr/bin/env` path is used as the interpreter in cache_go_dirs.sh
  # https://github.com/kubernetes/kubernetes/blob/b5f61ac129019d314e473584c1491b7ca62144c7/hack/make-rules/helpers/cache_go_dirs.sh

  fix_interpreter "$(find hack -name '*.sh')" core/coreutils bin/env
}

do_build() {
  make
  return $?
}

do_install() {
  cp _output/bin/* "${pkg_prefix}/bin"
  return $?
}
