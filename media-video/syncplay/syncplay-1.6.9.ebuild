# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{8,9,10} )

inherit python-r1

DESCRIPTION="Client/server to synchronize media playback"
HOMEPAGE="https://syncplay.pl"
SRC_URI="https://github.com/Syncplay/syncplay/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 x86"
IUSE="+client +server +tls +gui vlc"
REQUIRED_USE="vlc? ( client )
	${PYTHON_REQUIRED_USE}"

DEPEND=""
RDEPEND="${PYTHON_DEPS}
	|| (
		>=dev-python/twisted-16.0.0[${PYTHON_USEDEP}]
		dev-python/twisted-core[${PYTHON_USEDEP}]
	)
	gui? ( >=dev-python/pyside2-5.11.0[${PYTHON_USEDEP}] )
	vlc? ( media-video/vlc[lua] )
	tls? (
		>=dev-python/certifi-2018.11.29[${PYTHON_USEDEP}]
		>=dev-python/pyopenssl-16.0.0[${PYTHON_USEDEP}]
		dev-python/service_identity[${PYTHON_USEDEP}]
		>=dev-python/idna-0.6[${PYTHON_USEDEP}]
	)
	"

src_compile() {
	:
}

src_install() {
	local MY_MAKEOPTS=( DESTDIR="${D}" PREFIX=/usr )
	use client && \
		emake "${MY_MAKEOPTS[@]}" VLC_SUPPORT=$(usex vlc true false) install-client
	use server && \
		emake "${MY_MAKEOPTS[@]}" install-server
}

pkg_postinst() {
	if use client; then
		einfo "Syncplay supports the following players:"
		einfo "media-video/mpv, media-video/mplayer2, media-video/vlc"
	fi
}
