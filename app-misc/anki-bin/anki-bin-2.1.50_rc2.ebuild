# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"

inherit desktop unpacker xdg-utils

DESCRIPTION="A spaced-repetition memory training program (flash cards)"
HOMEPAGE="https://apps.ankiweb.net"
SRC_URI="https://apps.ankiweb.net/downloads/beta/anki-2.1.50%2Brc2_6718e678-linux-qt6.tar.zst -> ${P}.tar.zst"

LICENSE="AGPL-3+ BSD MIT GPL-3+ CC-BY-SA-3.0 Apache-2.0 CC-BY-2.5"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

RDEPEND="!app-misc/anki
	systemd? ( sys-apps/systemd )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/anki-2.1.50-linux-qt6"

QA_PREBUILT="*"

src_install() {
	insinto "/opt/${MY_PN}"
	doins -r *

	exeinto "/opt/${MY_PN}"
	doexe "${MY_PN}"
	exeinto "/opt/${MY_PN}/lib/PyQt6/Qt6/libexec"
	doexe "lib/PyQt6/Qt6/libexec/QtWebEngineProcess"

	dosym "/opt/${MY_PN}/${MY_PN}" "/usr/bin/${MY_PN}"

	if ! use systemd; then
		dosym "/usr/"$(get_libdir)"/libdbus-1.so.3" "/opt/${MY_PN}/bin/libdbus-1.so.3"
	fi

	doicon "${MY_PN}.png"
	domenu "${MY_PN}.desktop"
	doman "${MY_PN}.1"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}

