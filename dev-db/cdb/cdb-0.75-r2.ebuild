# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/cdb/cdb-0.75-r2.ebuild,v 1.13 2008/08/01 15:05:00 hattya Exp $

inherit eutils toolchain-funcs

KEYWORDS="~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"

DESCRIPTION="Fast, reliable, simple package for creating and reading constant databases."
HOMEPAGE="http://cr.yp.to/cdb.html"
SRC_URI="http://cr.yp.to/cdb/${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
IUSE=""

DEPEND=">=sys-apps/sed-4
		!dev-db/tinycdb"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-errno.diff

	sed -i -e 's/head -1/head -n 1/g' Makefile \
		|| die "sed Makefile failed"
}

src_compile() {
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	echo "${EPREFIX}/usr" > conf-home
	emake || die "emake failed"
}

src_install() {
	dobin cdbdump cdbget cdbmake cdbmake-12 cdbmake-sv cdbstats cdbtest \
		|| die "dobin failed"

	# ok so ... first off, some automakes fail at finding
	# cdb.a, so install that now
	dolib *.a || die "dolib failed"

	# then do this pretty little symlinking to solve the somewhat
	# cosmetic library issue at hand
	dosym cdb.a /usr/$(get_libdir)/libcdb.a || die "dosym failed"

	# uint32.h needs installation too, otherwise compiles depending
	# on it will fail
	insinto /usr/include
	doins cdb*.h buffer.h alloc.h uint32.h || die "doins failed"

	dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION
}
