FROM mcr.microsoft.com/dotnet/sdk:9.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends git sudo zsh \
    && groupadd --gid 1000 vscode \
    && useradd --uid 1000 --gid 1000 --create-home --shell /bin/bash vscode \
    && echo 'vscode ALL=(root) NOPASSWD:ALL' > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/usr/bin/pwsh", "-NoLogo", "-NoProfile", "-Command"]

RUN Set-PSRepository PSGallery -InstallationPolicy Trusted; \
    Install-Module Pester -Scope AllUsers -Force -SkipPublisherCheck; \
    Install-Module PSScriptAnalyzer -Scope AllUsers -Force -SkipPublisherCheck

SHELL ["/bin/bash", "-lc"]

RUN git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git /home/vscode/.oh-my-zsh \
    && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /usr/local/share/powerlevel10k \
    && chsh -s /usr/bin/zsh vscode

COPY .zshrc /home/vscode/.zshrc
COPY .p10k.zsh /home/vscode/.p10k.zsh

RUN chown -R vscode:vscode /home/vscode/.oh-my-zsh /home/vscode/.zshrc /home/vscode/.p10k.zsh
