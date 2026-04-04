function stats
    echo "--- 🖥️  System Health ---"
    echo "Memory: " (free -h | awk "/^Mem:/ {print \$3 \" / \" \$2}")
    echo "Uptime: " (uptime -p)
    echo "Public IP: " (curl -s https://ifconfig.me)
    echo "-----------------------"
end
