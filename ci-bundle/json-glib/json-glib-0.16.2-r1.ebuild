# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit gnome.org toolchain-funcs

DESCRIPTION="A library providing GLib support for the JSON format (CI/Jenkins multi-slot)"
HOMEPAGE="https://wiki.gnome.org/Projects/JsonGlib"

LICENSE="LGPL-2.1+"
SLOT="${PV}"
KEYWORDS=""
IUSE=""

GLIB_VERSIONS=( 2.35.9 2.38.2 2.40.2 2.43.2 )

RDEPEND="=virtual/ci-bundle-glib-2"
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.18
	virtual/pkgconfig"

src_configure() {
	local glib_version glib_prefix json_glib_prefix build_dir
	for glib_version in ${GLIB_VERSIONS[@]}; do
		einfo "Configuring for GLib ${glib_version}"

		glib_prefix="/opt/glib/${glib_version}"
		json_glib_prefix="/opt/json-glib/${PV}/${glib_version}"
		build_dir="${S}/${glib_version}-build"

		mkdir -p "${build_dir}"

		export PKG_CONFIG_PATH="${glib_prefix}/lib/pkgconfig"
		export PKG_CONFIG="pkg-config --define-variable=prefix=${glib_prefix}"
		export LD_LIBRARY_PATH="${glib_prefix}/lib"
		export PATH="${glib_prefix}/bin:${PATH}"

		pushd "${build_dir}" &> /dev/null
		"${S}/configure" \
			--prefix="${json_glib_prefix}" \
			--disable-gcov \
			--disable-introspection \
			|| die "configure failed for ${glib_version}"
		popd &> /dev/null
	done
}

src_compile() {
	local glib_version glib_prefix json_glib_prefix build_dir
	for glib_version in ${GLIB_VERSIONS[@]}; do
		einfo "Building for GLib ${glib_version}"

		glib_prefix="/opt/glib/${glib_version}"
		json_glib_prefix="/opt/json-glib/${PV}/${glib_version}"
		build_dir="${S}/${glib_version}-build"

		export PKG_CONFIG_PATH="${glib_prefix}/lib/pkgconfig"
		export PKG_CONFIG="pkg-config --define-variable=prefix=${glib_prefix}"
		export LD_LIBRARY_PATH="${glib_prefix}/lib"
		export PATH="${glib_prefix}/bin:${PATH}"

		emake -C "${build_dir}"
	done
}

src_install() {
	local glib_version glib_prefix json_glib_prefix build_dir
	for glib_version in ${GLIB_VERSIONS[@]}; do
		einfo "Installing for GLib ${glib_version}"

		glib_prefix="/opt/glib/${glib_version}"
		json_glib_prefix="/opt/json-glib/${PV}/${glib_version}"
		build_dir="${S}/${glib_version}-build"

		export PKG_CONFIG_PATH="${glib_prefix}/lib/pkgconfig"
		export PKG_CONFIG="pkg-config --define-variable=prefix=${glib_prefix}"
		export LD_LIBRARY_PATH="${glib_prefix}/lib"
		export PATH="${glib_prefix}/bin:${PATH}"

		emake DESTDIR="${ED}" -C "${build_dir}" install

		rm -rf "${ED}${json_glib_prefix}/share"
	done

	prune_libtool_files --modules
}
