# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://github.com/rafaelmartins/kvm-systemd.git
		https://github.com/rafaelmartins/kvm-systemd.git"
	inherit git-r3
fi

inherit systemd

DESCRIPTION="Some utilities to run KVM with systemd"
HOMEPAGE="https://github.com/rafaelmartins/kvm-systemd"

SRC_URI=""
KEYWORDS="~amd64 ~x86"
if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="net-dns/dnsmasq
	sys-apps/systemd"

src_install() {
	systemd_dounit systemd/system/kvm@.service
	systemd_dotmpfilesd systemd/tmpfiles/kvm.conf
	insinto /etc/kvm
	doins etc/kvm/vm.conf.example
	insinto /usr/share/doc/${PF}/examples
	doins -r examples/network
}
