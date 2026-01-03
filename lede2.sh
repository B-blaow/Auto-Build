#!/bin/bash
#===============================================
# Modify default IP
sed -i 's/192.168.1.1/192.168.5.5/g' $(pwd)/package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile


#2. Custom settings
#sed -i 's?zstd$?zstd ucl upx\n$(curdir)/upx/compile := $(curdir)/ucl/compile?g' tools/Makefile
#sed -i 's/$(TARGET_DIR)) install/$(TARGET_DIR)) install --force-overwrite/' package/Makefile
#sed -i 's/root:.*/root:$1$tTPCBw1t$ldzfp37h5lSpO9VXk4uUE\/:18336:0:99999:7:::/g' package/base-files/files/etc/shadow

#sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings

# ==== 强制启用的插件 ====
SAFE_PKGS=(
  luci-app-ttyd
  mosdns
  luci-app-mosdns
  luci-i18n-mosdns-zh-cn
  luci-app-homeproxy
  luci-i18n-homeproxy-zh-cn
  luci-i18n-adguardhome-zh-cn
  luci-app-adguardhome
  nikki
  luci-app-nikki
  luci-i18n-nikki-zh-cn
  ddns-scripts-cloudflare
  cloudflared
  luci-app-cloudflared
  wireguard-tools
  SING_BOX_BUILD_WIREGUARD
  kmod-wireguard
  luci-app-mwan3
  mwan3
  luci-i18n-mwan3-zh-cn
)

for pkg in "${SAFE_PKGS[@]}"; do
  sed -i "s/^# CONFIG_PACKAGE_${pkg} is not set/CONFIG_PACKAGE_${pkg}=y/" .config
  grep -q "CONFIG_PACKAGE_${pkg}=y" .config || \
    echo "CONFIG_PACKAGE_${pkg}=y" >> .config
done
