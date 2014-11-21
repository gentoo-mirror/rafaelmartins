# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit unpacker user

DESCRIPTION="An extendable open source continuous integration server"
HOMEPAGE="http://jenkins-ci.org/"
SRC_URI="http://pkg.jenkins-ci.org/debian/binary/jenkins_${PV}_all.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-fonts/dejavu"
RDEPEND="${DEPEND}
	>=virtual/jdk-1.5"

S="${WORKDIR}"

pkg_setup() {
	enewgroup jenkins
	enewuser jenkins -1 /bin/bash /var/lib/jenkins jenkins
}

src_install() {
	keepdir /var/log/jenkins
	keepdir /var/lib/jenkins
	insinto /usr/share/jenkins
	doins usr/share/jenkins/jenkins.war
	newinitd "${FILESDIR}/jenkins.initd" jenkins
	newconfd "${FILESDIR}/jenkins.confd" jenkins
	fowners jenkins:jenkins /var/log/jenkins /var/lib/jenkins
}
