# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://github.com/rafaelmartins/remote-dump1090.git
		https://github.com/rafaelmartins/remote-dump1090.git"
	inherit git-r3 autotools
fi

DESCRIPTION="A helper to send data from a dump1090 instance to another instance"
HOMEPAGE="https://github.com/rafaelmartins/remote-dump1090"

SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"
if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	[[ ${PV} = *9999* ]] && eautoreconf
	default
}

src_install() {
	default

	newconfd "${FILESDIR}"/remote-dump1090.confd remote-dump1090
	newinitd "${FILESDIR}"/remote-dump1090.initd remote-dump1090
}
