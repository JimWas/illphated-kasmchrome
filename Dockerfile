FROM kasmweb/chrome:1.17.0-rolling-daily

# Switch to root to modify startup scripts
USER root

# Set default URL and User-Agent
ENV LAUNCH_URL="https://illphated.com/?utm_source=kasm&utm_medium=chrome&utm_campaign=illphated-kasmchrome"
ENV CUSTOM_USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36"

# Overwrite startup script to run Chrome with custom UA
RUN echo '#!/usr/bin/env bash\n' \
    'google-chrome --user-data-dir=/tmp/chrome-profile \\\n' \
    '  --no-first-run --no-default-browser-check \\\n' \
    '  --user-agent="$CUSTOM_USER_AGENT" "$LAUNCH_URL"\n' \
    > /dockerstartup/custom_startup.sh && \
    chmod +x /dockerstartup/custom_startup.sh

# Expose Kasm noVNC / VNC port
EXPOSE 6901

# Switch back to normal Kasm user
USER 1000
