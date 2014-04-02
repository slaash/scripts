#!/bin/bash
vcmd="/opt/vc/bin/vcgencmd"
${vcmd} version
${vcmd} get_mem arm
${vcmd} get_mem gpu
cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))

echo CPU temp"="$cpuTemp1"."$cpuTempM"'C"
echo GPU $(/opt/vc/bin/vcgencmd measure_temp)
for m in sdram_c sdram_i sdram_p; do
	echo "${m}: $(${vcmd} measure_volts ${m})"
done
for c in H264 MPG2 WVC1 MPG4 MJPG WMV9; do
	echo "${c}: $(${vcmd} codec_enabled ${c})"
done
${vcmd} get_config int

