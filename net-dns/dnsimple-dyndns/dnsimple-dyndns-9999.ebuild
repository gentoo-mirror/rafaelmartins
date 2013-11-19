# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit git-r3 distutils-r1

DESCRIPTION="Dynamic DNS implementation, that relies on DNSimple.com"
HOMEPAGE="https://github.com/rafaelmartins/dnsimple-dyndns"

EGIT_REPO_URI="
	git://github.com/rafaelmartins/dnsimple-dyndns.git
	https://github.com/rafaelmartins/dnsimple-dyndns.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-python/requests-2.0.0
	virtual/python-argparse"
RDEPEND="${DEPEND}"
