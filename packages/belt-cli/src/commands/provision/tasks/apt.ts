import execa from "../../../modules/execa.js";

export async function setup({ packages }: { packages: { name: string }[] }) {
  await execa('sudo', ['apt-get', 'update'], { stdio: 'inherit' });

  for (const pkg of packages) {
    await execa('sudo', ['apt-get', 'install', '-y', pkg.name], {
      stdio: 'inherit',
    });
  }
}

export async function extract({ packages }: { packages: any }) {
  for (const pkg of packages) {
    if (pkg.disable) {
      return pkg;
    }

    const result = (await execa('dpkg', ['-s', pkg.name], {})) || '';
    const stdout = result
      .split('\n')
      .find((line: string) => line.startsWith('Version'));

    pkg.version = stdout ? stdout.split(' ')[1] : undefined;
  }

  return { packages };
}

// @TODO move old listing
// #!/bin/sh

// sudo apt-get install -y \
//   traceroute \
//   ranger \
//   awesome \
//   awesome-wm \
//   xcompmgr \
//   wmname \
//   zsh \
//   guake \
//   vlc \
//   tmux \
//   trash-cli \
//   indicator-cpufreq \
//   g++ \
//   wordnet \
//   jq \
//   anki \
//   ncdu \
//   cmake \
//   xbacklight \
//   xdotool \
//   wmctrl \
//   unity-tweak-tool \
//   git \
//   git-extras \
//   redshift \
//   redshift-gtk

// sudo add-apt-repository ppa:webupd8team/nemo
// sudo add-apt-repository ppa:webupd8team/atom
// sudo add-apt-repository ppa:nilarimogard/webupd8
// sudo apt-add-repository ppa:git-core/ppa
// sudo add-apt-repository ppa:zeal-developers/ppa
// sudo add-apt-repository ppa:neovim-ppa/stable

// sudo apt-get update

// sudo apt-get install -y \
//   nemo \
//   nemo-fileroller \
//   atom \
//   prime-indicator \
//   nvidia-settings \
//   git \
//   zeal \
//   neovim

// sudo apt-get purge -y nautilus
