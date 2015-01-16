#!/bin/bash -ex

echo "export DEBIAN_FRONTEND=noninteractive" >> /etc/environment
echo "export UBUNTU_RELEASE=$(lsb_release -cs)" >> /etc/environment

cat <<EOF > /etc/dpkg/dpkg.cfg.d/01_nodoc
path-exclude /usr/share/doc/*
path-include /usr/share/doc/*/copyright
path-exclude /usr/share/man/*
path-exclude /usr/share/groff/*
path-exclude /usr/share/info/*
path-exclude /usr/share/lintian/*
path-exclude /usr/share/linda/*
EOF

cat <<EOF >/etc/apt/apt.conf.d/02_nocache
Dir::Cache "";
Dir::Cache::archives "";
EOF

cat <<EOF > /etc/apt/apt.conf.d/99-defaults
APT::Get::Assume-Yes "true";
APT::Install-Recommends "false";
EOF

cat <<EOF > /etc/apt/apt.conf.d/local
Dpkg::Options {
  "--force-confdef";
  "--force-confold";
}
EOF

echo "Removing documentation..." >&2
find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true
find /usr/share/doc -empty|xargs rmdir || true
rm -rf /usr/share/man/man*/* \
   /usr/share/groff \
   /usr/share/info \
   /usr/share/lintian \
   /usr/share/linda \
   /var/cache/man
