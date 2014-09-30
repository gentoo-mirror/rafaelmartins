# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# FIXME: build and install sphinx docs

EAPI=5

inherit cmake-utils

DESCRIPTION="A simple, easily embeddable cross-platform C library"
HOMEPAGE="http://libcork.readthedocs.org/"
SRC_URI="https://github.com/redjack/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="virtual/pkgconfig
	test? (
		dev-libs/check
		dev-lang/python )"
RDEPEND=""

src_prepare() {
	if ! use test; then
		sed -i \
			-e '/tests/d' \
			-e '/docs\/old/d' \
			CMakeLists.txt || die 'sed failed'
	fi

	echo -e "#!/bin/bash\necho ${PV}" > version.sh
	chmod +x version.sh

	cmake-utils_src_prepare
}
