# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: ... ebo Exp $

inherit flag-o-matic subversion eutils

DESCRIPTION="A Modelica modeling, compilation and simulation environment."
HOMEPAGE="http://www.ida.liu.se/labs/pelab/modelica/OpenModelica.html"

#SRC_URI="mirror://gentoo//${P}.tar.bz2"

# Since the tarball keeps disipearing, this ebuild grabs a specific
# revision of the SVN source.
ESVN_REPO_URI="https://openmodelica.ida.liu.se/svn/OpenModelica/tags/OPENMODELICA_1_4_5"
ESVN_OPTIONS=" --username anonymous --password none"
S=${WORKDIR}/trunk


LICENSE="OSMC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+corba doc threads fortran"

DEPEND="sys-apps/sed
	sys-apps/coreutils
	sys-apps/findutils
	app-arch/tar
	media-libs/coin
	media-libs/SoQt"
RDEPEND="dev-lang/rml
	=dev-java/antlr-2*
	sys-libs/readline
	threads? ( dev-libs/boost )
	corba? ( >=net-misc/mico-2.3.12 
		=x11-libs/qt-4* 
		>=virtual/jre-1.4 )
	${DEPEND}"

pkg_setup() {
	export RMLHOME="${ROOT}usr"
	export ANTLRHOME="${ROOT}usr"
	export CLASSPATH="${ROOT}usr/share/antlr/lib/antlr.jar"

	# This package is very sensitive to parallelisation of the build
	# process. Do not do it and you will be safe.
	MAKEOPTS="${MAKEOPTS} -j1"
}

src_unpack() {
	subversion_src_unpack || die "subversion unpack failed"

	cd "${S}"
	chmod +x configure
	chmod +x Compiler/rml2sig/rmldep-new.sh

	epatch "${FILESDIR}/${P}-build_fixes.patch"

	# Convert DOS line endings to UNIX, or script will not work.
	sed -i -e "s|\r$||g" configure
}

src_compile() {
	econf \
		$(use_with corba CORBA) \
		$(use_with threads MODPAR) \
		$(use_with threads BOOST) \
		|| die "Configure failed."

	# Correct the documentation installation directory: the package
	# does not give a 'make doc' alternative, so we simply install it
	# into a folder that will be discarded if documentation is not
	# desired.
	if use doc ; then
		sed -i -r "s|^(INSTALL_DOCDIR.*)/omc/doc|\1/doc/${P}|" "${S}/Makefile"
	else
		sed -i -r "s|^(INSTALL_DOCDIR).*/omc/doc|\1 = ${T}/rubbish|" "${S}/Makefile"
	fi

	emake || die "Build of the OpenModelica Compiler failed."

	if use corba ; then
		cd "${S}/OMShell"
		qmake OMShell.pro || die "QMake could not be run on OMShell.pro."
		emake || die "Build of the OpenModelica GUI Shell failed."
	else
		ewarn "You deactivated CORBA support for OpenModelica. This means also"
		ewarn "that the Qt-based GUI will not be built."
	fi
}

src_install() {
	sed -i -r "s#^((lib|data)dir\s*=)\s*/usr(.*)#\1 \${prefix}\3#" Makefile
	make prefix="${D}/usr" install
	dobin "${S}/OMShell/OMShell"
	# Yes, it looks stupid to put data files in /bin, but that's
	# where OpenModelica expects them to be.
	dobin "${S}/OMNotebook/OMNotebookQT4/commands.xml"
	dobin "${S}/OMNotebook/OMNotebookQT4/modelicacolors.xml"
	dobin "${S}/OMNotebook/OMNotebookQT4/stylesheet.xml"

    # removed.  See below
	#dodoc "${S}/build/bin/ptplot\ copyright.txt"
	dodoc "${S}/OSMC-License.txt"

	# Untar the Modelica standard library and set permissions
	LIBRARYDIR="${D}/usr/share/${PN}"
	mkdir ${LIBRARYDIR}
	cd ${LIBRARYDIR}
	tar xzf "${S}/Compiler/VC7/Setup/zips/ModelicaLib.tar.gz"
	for DIR in $( find ${LIBRARYDIR} -type d )
	do
		chmod 755 ${DIR}
	done
	for FILE in $( find ${LIBRARYDIR} -type f )
	do
		chmod 644 ${FILE}
	done

	# Build environment variables
	echo "OPENMODELICAHOME=${ROOT}usr" > "${T}/99OpenModelica"
	echo "OPENMODELICALIBRARY=${ROOT}usr/share/${PN}/ModelicaLibrary" >> "${T}/99OpenModelica"
	doenvd "${T}/99OpenModelica"
	
	# Do some spring cleaining: some files must be removed.
	cd "${D}/usr"
	# Note that lib/ could be lib64/ or lib32/.
	rm -f lib*/libQt*.a lib*/libf2c*
	# This has been dodoc'ed above.
	rm -f bin/ptplot\ copyright.txt
	# Remove files that are not useful in UNIX.
	rm -f bin/Compile.* bin/doPlot.* bin/omc_*
	# Remove one header that belongs to another package.
	rm -f include/f2c.h

	# Adjust some permissions
	chmod 755 "${D}/usr/bin/Compile"
	chmod 755 "${D}/usr/bin/doPlot"
	# ... And fix some line endings
	sed -i -e "s|\r$||g" "${D}/usr/bin/Compile"
	sed -i -e "s|\r$||g" "${D}/usr/bin/doPlot"
}

pkg_postinst() {
	if use corba ; then
		ewarn "Remember to run 'source /etc/profile' as a user before starting the"
		ewarn "graphical interface OMShell, otherwise it will not be able to"
		ewarn "find the compiler and the Modelica standard library."
		ewarn
		ewarn "Note that OMShell generates a number of garbage files (C++ files,"
		ewarn "result listings, executables) in the folder it is run from. You"
		ewarn "should run OMShell from a sandbox folder."
	fi
}
