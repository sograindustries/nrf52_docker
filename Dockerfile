FROM ubuntu:18.04

RUN apt-get update && \
	apt-get install -y libx11-6 libfreetype6 libxrender1 libfontconfig1 libxext6 xvfb curl unzip python-pip git zip && \
	pip install nrfutil

RUN Xvfb :1 -screen 0 1024x768x16 &

RUN curl -X POST -F "fileid=8F19D314130548209E75EFFADD9348DB" https://www.nordicsemi.com/api/sitecore/Products/DownloadPlatform -o nrftools.tar && \
	tar -xvf nrftools.tar && \
	rm nrftools.tar
ENV PATH="/mergehex:/nrfjprog:$PATH"

RUN curl https://www.segger.com/downloads/embedded-studio/Setup_EmbeddedStudio_ARM_v350_linux_x64.tar.gz -o ses.tar.gz && \
	tar -zxvf ses.tar.gz && \
	DISPLAY=:1 $(find arm_segger_* -name "install_segger*") --copy-files-to /ses && \
	rm ses.tar.gz && \
	rm -rf arm_segger_embedded_studio_*

RUN curl https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v15.x.x/nRF5_SDK_15.2.0_9412b96.zip -o nRF5_SDK_15.2.0_9412b96.zip && unzip nRF5_SDK_15.2.0_9412b96.zip && rm nRF5_SDK_15.2.0_9412b96.zip

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
