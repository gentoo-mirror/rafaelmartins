# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://github.com/rafaelmartins/blogc.git
		https://github.com/balde/balde-utils.git"
	inherit git-r3 autotools
fi

DESCRIPTION="A blog compiler"
HOMEPAGE="http://blogc.org/"

SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"
if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="BSD"
SLOT="0"
IUSE="test static-libs"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-util/cmocka )"

src_prepare() {
	[[ ${PV} = *9999* ]] && eautoreconf
	default
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable test tests) \
		--disable-valgrind
}
