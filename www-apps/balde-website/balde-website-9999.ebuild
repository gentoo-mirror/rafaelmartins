# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://git.rgm.io/balde/balde-website.git
		http://git.rgm.io/balde/balde-website.git"
	inherit git-r3 autotools
fi

DESCRIPTION="The balde web application that runs at http://balde.io"
HOMEPAGE="http://balde.io/"

SRC_URI=""  # FIXME!
KEYWORDS="~amd64 ~x86"
if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="LGPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=dev-libs/glib-2.34
	net-libs/balde
	www-plugins/balde-markdown"
DEPEND="${RDEPEND}"

src_prepare() {
	[[ ${PV} = *9999* ]] && eautoreconf
	default
}
