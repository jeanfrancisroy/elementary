# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit vala cmake-utils

DESCRIPTION="Configure what applications do what using Switchboard."
HOMEPAGE="https://launchpad.net/switchboard-plug-default-applications"
SRC_URI="https://code.launchpad.net/~elementary-os/+archive/stable/+files/${PN}_${PV}%7Er62-0%2Br1%7Eprecise1.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

CDEPEND="
	dev-libs/glib
	pantheon-base/libpantheon
	x11-libs/granite"
RDEPEND="${CDEPEND}
	pantheon-base/switchboard"
DEPEND="${CDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	default_src_unpack

	mv "${WORKDIR}/recipe-{debupstream}~r{revno}-0+r1" "${S}"
}

src_prepare() {
	use nls || sed -i '/add_subdirectory (po)/d' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
	)
	cmake-utils_src_configure
}
