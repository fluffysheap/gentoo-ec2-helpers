# Copyright 2026 Fluffysheap
# Distributed under the terms of the MIT No Attribution License

EAPI=9

DESCRIPTION="Expand the EC2 EBS root filesystem to the maximum size"
HOMEPAGE="https://github.com/fluffysheap/gentoo-ec2-helpers"
#SRC_URI=""

LICENSE="MIT-0"
SLOT="0"
KEYWORDS="arm64 amd64"

DEPEND=""
RDEPEND="${DEPEND} sys-fs/growpart sys-apps/amazon-ec2-utils[udev]"
BDEPEND=""

src_unpack() {
	# With no real sources this directory doesn't get created, then causes errors for install step.
	mkdir "${S}"
}

src_install() {
	newinitd "${FILESDIR}/ec2-growroot-1.0" ec2-growroot
}

pkg_postinst() {
	echo "Adding ec2-growroot to default runlevel..."
	/usr/bin/rc-update add ec2-growroot default
}
