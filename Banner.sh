# Defines
    red='\e[0;31m'
    green='\e[0;32m'
    cyan='\e[0;36m'
    lightgray='\e[0;37m'
    purple='\e[1;35m'

let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
if [[ ${days} == 0 ]]; then
    UPTIME=`printf "%02d hours %02d minutes" "$hours" "$mins"`
else
    UPTIME=`printf "%d days %02d hours %02d minutes" "$days" "$hours" "$mins"`
fi

city='Bengaluru' # Change this to your location for Weather Info or keep it empty for automatic location retrieval

weather=$(curl -s "wttr.in/${city}?format=1")
used_memory=$(free | grep Mem | awk '{printf "%d\n", $3 / 1024 }')
total_memory=$(free | grep Mem | awk '{printf "%d\n", $2 / 1024 }')
free_memory=$(free | grep Mem | awk '{printf "%d\n", $7 / 1024 }')
memory_usage_percent=$(free | grep Mem | awk '{printf "%d\n", $3/$2 * 100}')

HOST=$(hostname)
    if [[ ${#HOST} -lt 14 ]]; then
        echo -e "${lightgray}"
        figlet -c "$(hostname)" | lolcat
    fi
    echo ""
    echo -e "${purple}\\tToday is:\\t\\t${cyan} $(date)"
    echo -e "${purple}\\tOperating System: \\t${cyan} $(lsb_release -ds) ($(uname -o))"
    echo -e "${purple}\\tProcessor: \\t\\t${cyan} $(lscpu | grep 'Model name' | cut -f 2 -d ":" | awk '{$1=$1}1')"
    echo -e "${purple}\\tKernel Information: \\t${cyan} $(uname -smr)"
    echo -e "${purple}\\tUptime: \\t\\t ${lightgray}Host up for ${cyan}${UPTIME}"
    echo -e "${purple}\\tMemory Usage: \\t\\t${lightgray} Used ${cyan}${used_memory} MB ${lightgray}of ${cyan}${total_memory} MB ${lightgray}(${cyan}${memory_usage_percent} %${lightgray})\n\\t\\t\\t\\t ${cyan}${free_memory} MB ${lightgray}available"
    echo -e "${purple}\\tWeather in ${city}: \\t${cyan} ${weather}"
    echo ""
    echo -e "${lightgray}\\tHave a great day, ${purple}$(whoami)${lightgray}!"
