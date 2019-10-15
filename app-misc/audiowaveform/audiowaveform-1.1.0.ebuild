# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit cmake-utils

DESCRIPTION="Generate waveform data and render waveform images from audio files"
BASE_SERVER_URI="https://github.com/bbc/audiowaveform"
HOMEPAGE="${BASE_SERVER_URI}"
SRC_URI="${BASE_SERVER_URI}/archive/${PV}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="mirror"

DEPEND="
	dev-libs/boost"
RDEPEND="${DEPEND}
	media-libs/libmad
	media-libs/gd
	media-libs/libsndfile
	media-libs/libid3tag"

src_configure() {
	local mycmakeargs=(-DENABLE_TESTS=0)
	cmake-utils_src_configure
}
