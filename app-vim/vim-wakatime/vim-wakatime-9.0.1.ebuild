# Copyright 2022 Niccolò Scatena
# Distributed under the terms of the MIT License ("Expat License")

EAPI=8

inherit vim-plugin

DESCRIPTION="vim plugin: automatic time tracking with WakaTime"
HOMEPAGE="https://github.com/wakatime/vim-wakatime"
LICENSE="BSD"
KEYWORDS="~amd64"
SRC_URI="https://github.com/wakatime/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

RDEPEND="${DEPEND}"

VIM_PLUGIN_HELPFILES="doc/wakatime.txt"
VIM_PLUGIN_HELPURI="https://github.com/wakatime/vim-wakatime"
