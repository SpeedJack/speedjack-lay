# Copyright 2022 Niccolò Scatena
# Distributed under the terms of the MIT License ("Expat License")

EAPI=7

inherit savedconfig toolchain-funcs

DESCRIPTION="On-screen keyboard for wlroots that sucks less"
HOMEPAGE="https://github.com/jjsullivan5196/wvkbd"
SRC_URI="https://github.com/jjsullivan5196/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	x11-libs/libxkbcommon[X,wayland]
	x11-libs/pango[X]
	gui-libs/wlroots
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default

	restore_config config.def.h

	sed -i -e 's|pkg-config|$(PKG_CONFIG)|g' Makefile config.mk || die
}

src_compile() {
	for i in layout*.h; do
		i=${i/layout.}; i=${i/.h}
		emake \
			CC="$(tc-getCC)" \
			PKG_CONFIG="$(tc-getPKG_CONFIG)" \
			LAYOUT=${i}
	done
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	dobin ${PN}-*

	save_config config.def.h
}
