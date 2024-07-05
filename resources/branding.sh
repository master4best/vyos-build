#!/usr/bin/env bash
set -e

echo "NOT_VYOS: $NOT_VYOS"
if [ "$NOT_VYOS" == "yes" ]; then
  if [[ "$JOB_NAME" == *"vyos-1x"* ]]; then
    echo "Removing branding for $JOB_NAME..."
    defaultMotd="./data/templates/login/default_motd.j2"
    if [ -f "$defaultMotd" ]; then
      sed -i 's/VyOS/NOTvyos/' "$defaultMotd"
    fi
    systemLoginBannerPy="./src/conf_mode/system_login_banner.py"
    if [ -f "$systemLoginBannerPy" ]; then
      sed -i 's/Welcome to VyOS/Welcome to NOTvyos/' "$systemLoginBannerPy"
    fi
    systemLoginBannerPy2="./src/conf_mode/system-login-banner.py"
    if [ -f "$systemLoginBannerPy" ]; then
      sed -i 's/Welcome to VyOS/Welcome to NOTvyos/' "$systemLoginBannerPy"
    fi
    vyosRouter="./src/init/vyos-router"
    if [ -f "$vyosRouter" ]; then
      sed -i 's/VyOS Config/NOTvyos Config/' "$vyosRouter"
      sed -i 's/VyOS router/NOTvyos router/' "$vyosRouter"
    fi
  else
    echo "No branding to remove for $JOB_NAME"
  fi
fi
