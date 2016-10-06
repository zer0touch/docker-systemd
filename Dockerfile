FROM ubuntu:15.04
Maintainer Ryan Harper, <ryanharper007@zer0touch.co.uk>
# You can change the FROM Instruction to your existing images if you like and build it with same tag
ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
RUN mkdir -p  /etc/apt/sources.d/

ADD ./AptFile /etc/apt/sources.d/01buildconfig

RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt vivid main restricted universe multiverse \n\
deb mirror://mirrors.ubuntu.com/mirrors.txt vivid-updates main restricted universe multiverse \n\
deb mirror://mirrors.ubuntu.com/mirrors.txt vivid-backports main restricted universe multiverse \n\
deb mirror://mirrors.ubuntu.com/mirrors.txt vivid-security main restricted universe multiverse" > /etc/apt/sources.d/ubuntu-mirrors.list
RUN apt-get update && apt-get install systemd -y && \
    rm -f /lib/systemd/system/sysinit.target.wants/cryptsetup.target;\
    rm -f /lib/systemd/system/sysinit.target.wants/debian-fixup.service;\
    rm -f /lib/systemd/system/sysinit.target.wants/dev-hugepages.mount;\
    rm -f /lib/systemd/system/sysinit.target.wants/dev-mqueue.mount;\
    rm -f /lib/systemd/system/sysinit.target.wants/kmod-static-nodes.service;\
    rm -f /lib/systemd/system/sysinit.target.wants/proc-sys-fs-binfmt_misc.automount;\
    rm -f /lib/systemd/system/sysinit.target.wants/sys-fs-fuse-connections.mount;\
    rm -f /lib/systemd/system/sysinit.target.wants/sys-kernel-config.mount;\
    rm -f /lib/systemd/system/sysinit.target.wants/sys-kernel-debug.mount;\
    rm -f /lib/systemd/system/sysinit.target.wants/systemd-ask-password-console.path;\
    rm -f /lib/systemd/system/sysinit.target.wants/systemd-binfmt.service;\
    rm -f /lib/systemd/system/sysinit.target.wants/systemd-hwdb-update.service;\
    rm -f /lib/systemd/system/sysinit.target.wants/systemd-journal-flush.service;\
    rm -f /lib/systemd/system/sysinit.target.wants/systemd-journald.service;\
    rm -f /lib/systemd/system/sysinit.target.wants/systemd-machine-id-commit.service;\
    rm -f /lib/systemd/system/sysinit.target.wants/systemd-modules-load.service;\
    rm -f /lib/systemd/system/sysinit.target.wants/systemd-random-seed.service;\
    rm -f /lib/systemd/system/sysinit.target.wants/systemd-sysctl.service;\
    rm -f /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup.service;\
    rm -f /lib/systemd/system/sysinit.target.wants/systemd-udev-trigger.service;\
    rm -f /lib/systemd/system/sysinit.target.wants/systemd-udevd.service;\
    rm -f /lib/systemd/system/sysinit.target.wants/systemd-update-utmp.service;\
    rm -f /lib/systemd/system/sysinit.target.wants/udev-finish.service;\
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*; \
    rm -f /lib/systemd/system/plymouth*; \
    rm -f /lib/systemd/system/systemd-update-utmp*
RUN systemctl set-default multi-user.target
ENV init /lib/systemd/systemd
VOLUME [ "/sys/fs/cgroup" ]
# docker run -it --privileged=true -v /sys/fs/cgroup:/sys/fs/cgroup:ro 444c127c995b /lib/systemd/systemd systemd.unit=emergency.service
ENTRYPOINT ["/lib/systemd/systemd"]
CMD ["systemd.unit=emergency.service"]