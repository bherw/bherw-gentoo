# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop optfeature xdg

DESCRIPTION="a tool aimed at improving the gaming experience of various Paradox games"
HOMEPAGE="https://github.com/crschnick/pdx_unlimiter"
SRC_URI="https://github.com/crschnick/pdx_unlimiter/releases/download/2.2-beta7/pdx_unlimiter-linux.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE=""

DEPEND="
	app-arch/unzip
"
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}

src_unpack() {
	mkdir ${S}/pdx_unlimiter
	cd ${S}/pdx_unlimiter
	unpack ${P}.zip
}

src_prepare() {
	default

	sed -E -i 's/DIR=".+"/DIR=\"\/opt\/pdx_unlimiter\/bin\"/' ${S}/pdx_unlimiter/bin/pdxu
}

src_install() {
	TARGET="/opt/"
	dodir ${TARGET}
	cp -R "${S}/pdx_unlimiter/" ${D}/${TARGET} || die "Install failed!"

	dosym /opt/pdx_unlimiter/bin/pdxu /usr/bin/pdxu
}

pkg_postinst() {
	xdg_pkg_postinst
}
