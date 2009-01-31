# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf-archive/autoconf-archive-2008.08.25.ebuild,v 1.2 2009/01/29 16:10:26 vapier Exp $

EAPI="prefix"

inherit eutils

MY_PV=${PV//./-}
DESCRIPTION="GNU Autoconf Macro Archive"
HOMEPAGE="http://autoconf-archive.cryp.to/"
SRC_URI="http://autoconf-archive.cryp.to/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

S=${WORKDIR}/${PN}-${MY_PV}

src_install() {
	emake install DESTDIR="${D}" || die
	dodir /usr/share/doc
	mv "${ED}"/usr/share/{${PN},doc/${PF}} || die
}
