#!/usr/bin/env bash
set -e

echo "NOT_VYOS: $NOT_VYOS"
if [ "$NOT_VYOS" != "" ]; then
  name="$NOT_VYOS"
  if [ "$name" == "yes" ]; then
    name="NOTvyos"
  fi

  if [[ "$JOB_NAME" == *"vyos-1x"* ]]; then
    # sagitta
    echo "Removing branding for $JOB_NAME..."
    defaultMotd="./data/templates/login/default_motd.j2"
    if [ -f "$defaultMotd" ]; then
      sed -i "s/VyOS/$name/" "$defaultMotd"
    fi

    systemLoginBannerPy="./src/conf_mode/system_login_banner.py"
    if [ -f "$systemLoginBannerPy" ]; then
      sed -i "s/Welcome to VyOS/Welcome to $name/" "$systemLoginBannerPy"
    fi

    vyosRouter="./src/init/vyos-router"
    if [ -f "$vyosRouter" ]; then
      sed -i "s/VyOS Config/$name Config/" "$vyosRouter"
      sed -i "s/VyOS router/$name router/" "$vyosRouter"
    fi

    vyosVersionPy="./src/op_mode/version.py"
    if [ -f "$vyosVersionPy" ]; then
      sed -i "s/VyOS {{version}}/$name {{version}}/" "$vyosVersionPy"
    fi

    airbagPy="./python/vyos/airbag.py"
    if [ -f "$airbagPy" ]; then
      sed -i "s/VyOS {{version}}/$name {{version}}/" "$airbagPy"
    fi

    # equuleus
    systemLoginBannerPy2="./src/conf_mode/system-login-banner.py"
    if [ -f "$systemLoginBannerPy2" ]; then
      sed -i "s/Welcome to VyOS/Welcome to $name/" "$systemLoginBannerPy2"
    fi

    vyosVersionPy2="./src/op_mode/show_version.py"
    if [ -f "$vyosVersionPy2" ]; then
      sed -i "s/VyOS {{version}}/$name {{version}}/" "$vyosVersionPy2"
    fi

  elif [[ "$JOB_NAME" == *"vyatta-cfg"* ]]; then

    # equuleus
    echo "Removing branding for $JOB_NAME..."
    vyosRouter="./scripts/init/vyos-router"
    if [ -f "$vyosRouter" ]; then
      sed -i "s/VyOS Config/$name Config/" "$vyosRouter"
      sed -i "s/VyOS router/$name router/" "$vyosRouter"
    fi

  else
    echo "No branding to remove for $JOB_NAME"
  fi
fi
