# Copyright 2022 Niccolò Scatena
# Distributed under the terms of the MIT License ("Expat License")

EAPI=8

CRATES="
	aho-corasick-0.7.6
	ansi_term-0.11.0
	atty-0.2.13
	bitflags-1.1.0
	clap-2.33.0
	glob-0.3.0
	itoa-0.4.4
	lazy_static-1.4.0
	libc-0.2.62
	memchr-2.2.1
	proc-macro2-1.0.3
	quote-1.0.2
	regex-1.3.1
	regex-syntax-0.6.12
	ryu-1.0.0
	serde-1.0.100
	serde_derive-1.0.100
	serde_json-1.0.40
	strsim-0.8.0
	syn-1.0.5
	textwrap-0.11.0
	thread_local-0.3.6
	unicode-width-0.1.6
	unicode-xid-0.2.0
	vec_map-0.8.1
	winapi-0.3.8
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
	${P}
"

inherit cargo

DESCRIPTION="Automatic display rotation using built-in accelerometer"
HOMEPAGE="https://github.com/efernau/rot8"
SRC_URI="$(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"

LICENSE="Apache-2.0 Boost-1.0 MIT Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
