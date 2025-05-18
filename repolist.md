
sudo dnf config-manager --add-repo=https://download.docker.com/linux/fedora/docker-ce.repo && \
sudo dnf config-manager --add-repo=https://rpmfusion.org/keys?action=AttachFile&do=get&target=rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && \
sudo dnf config-manager --add-repo=https://rpmfusion.org/keys?action=AttachFile&do=get&target=rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
sudo dnf copr enable heus-sueh/packages -y && \
sudo dnf copr enable nunodias/WasIstLos -y && \
sudo dnf copr enable phracek/PyCharm -y && \
sudo dnf copr enable solopasha/hyprland -y && \
sudo dnf config-manager --add-repo=https://dl.google.com/linux/chrome/rpm/stable/x86_64/google-chrome.repo && \
sudo dnf config-manager --add-repo=https://repo.protonvpn.com/fedora/protonvpn.repo
