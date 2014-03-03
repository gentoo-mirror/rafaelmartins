# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://github.com/rafaelmartins/balde.git
		https://github.com/rafaelmartins/balde.git"
	inherit git-r3 autotools
fi

DESCRIPTION="A microframework for C based on GLib and bad intentions."
HOMEPAGE="http://balde.io/"

SRC_URI=""  # FIXME!
KEYWORDS="~amd64 ~x86"
if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="LGPL-2"
SLOT="0"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.34
	dev-libs/fcgi
	sys-apps/file"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_prepare() {
	[[ ${PV} = *9999* ]] && eautoreconf
	default
}

src_configure() {
	econf \
		$(use_with doc doxygen) \
		--disable-examples \
		--without-valgrind
}

src_compile() {
	default
	use doc && emake doxygen
}

src_install() {
	default
	use doc && dohtml -r doc/build/html/.
}
