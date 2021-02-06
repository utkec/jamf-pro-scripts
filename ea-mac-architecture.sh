arch=$(/usr/bin/arch)

if [ "$arch" == "arm64" ]; then
    echo "<result>Apple Silicon - $arch</result>"
elif [ "$arch" == "i386" ]; then
    echo "<result>Intel - $arch</result>"
else
    echo "<result>Unknown Architecture</result>"
fi

