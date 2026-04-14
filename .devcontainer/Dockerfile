FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget apt-transport-https software-properties-common \
    && wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y --no-install-recommends powershell git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/usr/bin/pwsh", "-NoLogo", "-NoProfile", "-Command"]

RUN Set-PSRepository PSGallery -InstallationPolicy Trusted; \
    Install-Module Pester -Scope AllUsers -Force -SkipPublisherCheck; \
    Install-Module PSScriptAnalyzer -Scope AllUsers -Force -SkipPublisherCheck
