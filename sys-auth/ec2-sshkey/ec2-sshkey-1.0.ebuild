# Copyright 2026 Fluffysheap
# Distributed under the terms of the MIT No Attribution License

EAPI=9

DESCRIPTION="Pull the ssh keys from EC2 metadata and install them to the gentoo user"
#HOMEPAGE=""
#SRC_URI=""

LICENSE="MIT-0"
SLOT="0"
KEYWORDS="arm64 amd64"

DEPEND=""
RDEPEND="${DEPEND} net-misc/curl"
BDEPEND=""

src_unpack() {
	# With no real sources this directory doesn't get created, then causes errors for install step.
	mkdir "${S}"
}

src_install() {
	newinitd "${FILESDIR}/ec2-sshkey-1.0" ec2-sshkey
}

pkg_postinst() {
	echo "Adding ec2-sshkey to default runlevel..."
	/usr/bin/rc-update add ec2-sshkey default
}
