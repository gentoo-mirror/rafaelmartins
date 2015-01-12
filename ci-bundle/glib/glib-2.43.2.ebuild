# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

## This package is used by https://ci.rgm.io/
## Do not use it if you don't know what you're doing.

EAPI="5"

inherit gnome.org autotools

DESCRIPTION="The GLib library of C routines (CI/Jenkins multi-slot)"
HOMEPAGE="http://www.gtk.org/"

LICENSE="LGPL-2+"
SLOT="${PV}"
IUSE=
KEYWORDS=

RDEPEND="
	virtual/libiconv
	virtual/libffi
	sys-libs/zlib
	>=dev-libs/elfutils-0.142"

DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.11"

PDEPEND="x11-misc/shared-mime-info"

src_prepare() {
	sed -i \
		-e 's/^SUBDIRS.*reference.*$/SUBDIRS =/' \
		docs/Makefile.am || die 'sed docs failed'

	sed -i \
		-e 's/^SUBDIRS.*codegen$/SUBDIRS =/' \
		gio/Makefile.am || die 'sed codegen failed'

	sed -i \
		-e 's/ tests//' \
		{.,gio,glib}/Makefile.am || die 'sed tests failed'

	sed -i \
		-e '/${PYTHON}/d' \
		glib/Makefile.{am,in} || die 'sed python failed'

	eautoreconf
	epunt_cxx
}

src_configure() {
	./configure \
		--prefix="/opt/${PN}/${PV}" \
		--with-threads=posix \
		--with-pcre=internal \
		--disable-selinux \
		--disable-xattr \
		--disable-fam \
		--disable-static \
		--disable-dtrace \
		--disable-systemtap \
		--disable-man \
		--disable-gtk-doc \
		|| die 'configure failed'
}

src_install() {
	local opt_prefix="/opt/${PN}/${PV}"
	make DESTDIR="${ED}" install

	# delete uneeded stuff
	rm -rf "${ED}${opt_prefix}/share/"{bash-completion,locale,gdb,glib-2.0/{gdb,gettext}}/
	rm -f "${ED}${opt_prefix}/lib/charset.alias"
	rm "${ED}${opt_prefix}/bin/gtester-report"

	prune_libtool_files --modules
}
