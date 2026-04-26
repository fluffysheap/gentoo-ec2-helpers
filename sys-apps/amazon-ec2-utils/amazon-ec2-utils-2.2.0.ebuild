# ebuild Copyright 2026 Fluffysheap
# Distributed under the terms of the MIT Non Attribution License

EAPI=8

inherit udev

DESCRIPTION="Amazon EC2 host commandline utilities (not AWS-CLI)"
HOMEPAGE="https://github.com/amazonlinux/amazon-ec2-utils/"
SRC_URI="https://github.com/amazonlinux/amazon-ec2-utils/archive/refs/tags/v2.2.0.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="arm64 amd64"
IUSE="udev"

DEPEND=""
RDEPEND="${DEPEND} net-misc/curl"
BDEPEND=""

src_install() {
	dobin "${S}"/ec2-metadata ec2-metadata
	dosbin "${S}"/ec2nvme-nsid ec2nvme-nsid
	dosbin "${S}"/ec2udev-vbd ec2udev-vbd
	dosbin "${S}"/ebsnvme-id ebsnvme-id
	doman "${S}"/doc/*.8

	if [ $(usev udev) ] ; then
		insinto /lib/udev/rules.d
		# Collides with the one from systemd[-utils] and doesn't really matter
		rm "${S}"/60-cdrom_id.rules
		doins "${S}"/*rules 
	fi
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
