# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

GIT_ECLASS=
if [[ ${PV} = *9999* ]]; then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="git://github.com/rafaelmartins/distpatch.git
		https://github.com/rafaelmartins/distpatch"
fi

inherit distutils-r1 ${GIT_ECLASS}

DESCRIPTION="Distfile Patching Support for Gentoo Linux (tools)"
HOMEPAGE="http://www.gentoo.org/proj/en/infrastructure/distpatch/"

SRC_URI="mirror://github/rafaelmartins/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

CDEPEND=">=sys-apps/portage-2.1.8.3
	dev-python/snakeoil"
DEPEND="${CDEPEND}
	dev-python/setuptools"
RDEPEND="${CDEPEND}
	>=dev-util/diffball-1.0.1"
