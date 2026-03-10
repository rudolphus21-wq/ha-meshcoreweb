# ==============================================================================
# MeshCore Linux GUI Container
# Based on jlesage/baseimage-gui — serves the app via noVNC on port 5800
# and VNC on port 5900.
#
# App source: https://files.liamcottle.net/MeshCore/v1.41.0/
# ==============================================================================

#FROM jlesage/baseimage-gui:ubuntu-22.04-v4
FROM jlesage/baseimage-gui:debian-13-v4.11.2
# ---------------------------------------------------------------------------
# Metadata
# ---------------------------------------------------------------------------
LABEL maintainer="mk_throwable@outlook.com"
LABEL description="MeshCore v1.41.0 desktop client running in a browser via noVNC"

# ---------------------------------------------------------------------------
# App name shown in the noVNC title bar
# ---------------------------------------------------------------------------
RUN set-cont-env APP_NAME "MeshCore"
RUN set-cont-env HOME "/config/meshcore"

# ---------------------------------------------------------------------------
# Runtime dependencies for the pre-built Flutter Linux bundle
# ---------------------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    unzip \
    ca-certificates \
    mesa-utils \
    mesa-va-drivers \
    i965-va-driver \
    libgtk-3-0 \
    libglib2.0-0 \
    xz-utils \
    libstdc++6 \
    libusb-1.0-0 \
    xdg-user-dirs \
    && rm -rf /var/lib/apt/lists/*

#    RUN add-pkg \
#    curl \
#    unzip \
#    ca-certificates \
#    mesa-dri-gallium     mesa-va-gallium     libva-intel-driver \
#    gtk+3.0 \
#    glib \
#    xz-libs \
#    libstdc++ \
#    libusb \



    # GTK3 + GLib (Flutter Linux runtime)
    #libgtk-3-0 \
    #libglib2.0-0 \
    # Other libs bundled Flutter apps commonly need
    #libgl1 \
    #libglx-mesa0 \
    #libegl1 \
    #libblkid1 \
    #liblzma5 \
    #libstdc++6 \
    # USB/serial passthrough support
    #libusb-1.0-0 \
    #udev 


# ---------------------------------------------------------------------------
# Download and extract the pre-built MeshCore Linux x86_64 bundle
# ---------------------------------------------------------------------------
ENV MESHCORE_VERSION=1.41.0
ENV MESHCORE_BUILD=66-3c66fd5
ENV MESHCORE_ZIP=MeshCore-v${MESHCORE_VERSION}+${MESHCORE_BUILD}-linux-x86_64.zip
ENV MESHCORE_URL=https://files.liamcottle.net/MeshCore/v${MESHCORE_VERSION}/${MESHCORE_ZIP}
ENV MESHCORE_HOME=/opt/meshcore

RUN curl -fsSL "${MESHCORE_URL}" -o /tmp/meshcore.zip \
    && mkdir -p "${MESHCORE_HOME}" \
    && unzip -q /tmp/meshcore.zip -d "${MESHCORE_HOME}" \
    && chmod a+x "${MESHCORE_HOME}/MeshCore" \
    && rm /tmp/meshcore.zip 

# ---------------------------------------------------------------------------
# Persistent config volume (device settings, contacts, keys)
# ---------------------------------------------------------------------------
VOLUME ["/config"]

RUN chmod 777 -R /root

# ---------------------------------------------------------------------------
# Start script — called by jlesage/baseimage-gui to launch the app
# ---------------------------------------------------------------------------
COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh

# ---------------------------------------------------------------------------
# Ports
#   5800 — noVNC web UI  (http://host:5800)
#   5900 — raw VNC       (optional)
# ---------------------------------------------------------------------------
EXPOSE 5800
#EXPOSE 5900
