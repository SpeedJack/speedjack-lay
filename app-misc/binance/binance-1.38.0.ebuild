# Copyright 2022 Niccolò Scatena
# Distributed under the terms of the MIT License ("Expat License")

EAPI=8

inherit chromium-2 desktop unpacker xdg-utils

DESCRIPTION="Binance cryptocurrency broker official app"
HOMEPAGE="https://www.binance.com"
SRC_URI="https://ftp.binance.com/electron-desktop/linux/production/${PN}-amd64-linux.deb -> ${P}.deb"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror splitdebug test"
IUSE="system-ffmpeg system-mesa system-vulkan"

DEPEND=""
RDEPEND="
	app-accessibility/at-spi2-atk:2
	app-crypt/libsecret
	dev-libs/libappindicator:3
	dev-libs/nss
	sys-apps/util-linux
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/libnotify
	system-ffmpeg? ( <media-video/ffmpeg-4.3[chromium] )
	system-mesa? ( media-libs/mesa )
	system-vulkan? ( media-libs/vulkan-loader )
"
BDEPEND=""

S="${WORKDIR}"

QA_PREBUILT="
	opt/Binance/${PN}
	opt/Binance/chrome-sandbox
	opt/Binance/libEGL.so
	opt/Binance/libGLESv2.so
	opt/Binance/libffmpeg.so
	opt/Binance/libvk_swiftshader.so
	opt/Binance/libvulkan.so.1
	opt/Binance/resources/app.asar.unpacked/node_modules/wmi-client/bin/wmic_centos_x64
	opt/Binance/resources/app.asar.unpacked/node_modules/wmi-client/bin/wmic_ubuntu_x64
	opt/Binance/swiftshader/libEGL.so
	opt/Binance/swiftshader/libGLESv2.so
"

pkg_pretend() {
	chromium_suid_sandbox_check_kernel_config
}

src_configure() {
	chromium_suid_sandbox_check_kernel_config
	default
}

src_install() {
	insinto /opt/Binance
	doins -r opt/Binance/.

	fperms +x /opt/Binance/${PN}
	dosym ../../opt/Binance/${PN} /usr/bin/${PN}

	domenu usr/share/applications/${PN}.desktop
	doicon usr/share/icons/hicolor/512x512/apps/${PN}.png

	if use system-ffmpeg ; then
		rm -f "${ED}"/opt/Binance/libffmpeg.so || die

		cat > 99binance <<-EOF
		LDPATH="${EPREFIX}/usr/$(get_libdir)/chromium"
		EOF
		doenvd 99binance
		elog "Using system ffmpeg. This is experimental and may lead to crashes."
	fi

	if use system-mesa ; then
		rm -f "${ED}"/opt/Binance/libEGL.so || die
		rm -f "${ED}"/opt/Binance/libGLESv2.so || die
		rm -f "${ED}"/opt/Binance/swiftshader/libEGL.so || die
		rm -f "${ED}"/opt/Binance/swiftshader/libGLESv2.so || die
		elog "Using system mesa. This is experimental and may lead to crashes."
	fi

	if use system-vulkan ; then
		rm -f "${ED}"/opt/Binance/libvulkan.so.1 || die
		rm -f "${ED}"/opt/Binance/libvk_swiftshader.so || die
		elog "Using system vulkan. This is experimental and may lead to crashes."
	fi

	rm -rf "${ED}"/opt/Binance/resources/app.asar.unpacked/node_modules/osx-brightness || die
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
