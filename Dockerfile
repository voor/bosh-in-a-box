FROM ubuntu

ENV BOSH_VERSION    latest
ENV BBL_VERSION     latest
ENV BOSH_SHA        5017ea3be52a71c9c35ee015904f1e91f77cddc4a32f011e042cf4cdf33f7278
ENV BBL_SHA         adeccd88a9d3ac370983c8aea20f989bdca8c53c2aa08521c1ed8c5b2a3b0ad0
ENV CHECK_SHA       false

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
    unzip \
	curl \
    jq \
    && curl -sSL -o usr/bin/bbl $(curl -sSL https://api.github.com/repos/cloudfoundry/bosh-bootloader/releases/${BBL_VERSION} | jq -r -c ".assets[] | .browser_download_url" | grep linux) \
    && chmod +x /usr/bin/bbl \
    && curl -sSL -o usr/bin/bosh $(curl -sSL https://api.github.com/repos/cloudfoundry/bosh-cli/releases/${BOSH_VERSION} | jq -r -c ".assets[] | .browser_download_url" | grep linux) \
    && chmod +x /usr/bin/bosh \
    && apt-get purge --auto-remove -y curl gnupg unzip \
	&& rm -rf /var/lib/apt/lists/* \
    && bbl --version \
    && bosh --version

RUN bash -c "if [ \"${CHECK_SHA}\" = \"true\" ]; then \
    echo \"${BOSH_SHA} /usr/bin/bosh\" >> /checksum.txt \
    && echo \"${BBL_SHA} /usr/bin/bbl\" >> /checksum.txt \
    && cat /checksum.txt \
    && sha256sum -c /checksum.txt \
    && rm -rf /checksum.txt; fi"