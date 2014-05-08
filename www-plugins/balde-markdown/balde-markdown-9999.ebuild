# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://git.rgm.io/balde/balde-markdown.git
		http://git.rgm.io/balde/balde-markdown.git"
	inherit git-r3 autotools
fi

DESCRIPTION="A balde extension that adds Markdown support."
HOMEPAGE="http://balde.io/"

SRC_URI=""  # FIXME!
KEYWORDS="~amd64 ~x86"
if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="LGPL-2"
SLOT="0"
IUSE="test"

RDEPEND=">=dev-libs/glib-2.34
	net-libs/balde"
DEPEND="${RDEPEND}"

src_prepare() {
	[[ ${PV} = *9999* ]] && eautoreconf
	default
}

src_configure() {
	econf \
		--without-valgrind
}
