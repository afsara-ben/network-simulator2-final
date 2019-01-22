set title "metrics vs no of nodes" 
set xlabel "Number of nodes"
set ylabel "throughput"
set autoscale
set terminal pdf
set output "grapfs.pdf"

set ylabel "Delay"
plot "tcp_wireless_nodes.dat" using 1:3 title "Average Delay" with linespoints lt rgb "red"
set ylabel "Packets Delivered"
plot "tcp_wireless_nodes.dat" using 1:4 title "Packet delivery ratio" with linespoints lt rgb "blue"
set ylabel "Packets Dropped"
plot "tcp_wireless_nodes.dat" using 1:5 title "Packet drop ratio" with linespoints lt rgb "violet" 
set ylabel "Throughput"
plot "tcp_wireless_nodes.dat" using 1:2 title "Throughput" with linespoints lt rgb "red"
set ylabel "Energy consumed"
plot "tcp_wireless_nodes.dat" using 1:6 title "Energy Consumption" with linespoints lt rgb "green"


set xlabel "Number of flows"
set ylabel "Delay"
plot "tcp_wireless_flows.dat" using 1:3 title "Average Delay" with linespoints lt rgb "red"
set ylabel "Packets Delivered"
plot "tcp_wireless_flows.dat" using 1:4 title "Packet delivery ratio" with linespoints lt rgb "blue"
set ylabel "Packets Dropped"
plot "tcp_wireless_flows.dat" using 1:5 title "Packet drop ratio" with linespoints lt rgb "violet" 
set ylabel "Throughput"
plot "tcp_wireless_flows.dat" using 1:2 title "Throughput" with linespoints lt rgb "red"
set ylabel "Energy consumed"
plot "tcp_wireless_flows.dat" using 1:6 title "Energy Consumption" with linespoints lt rgb "green"


set xlabel "Number of packets"
set ylabel "Delay"
plot "tcp_wireless_packet.dat" using 1:3 title "Average Delay" with linespoints lt rgb "red"
set ylabel "Packets Delivered"
plot "tcp_wireless_packet.dat" using 1:4 title "Packet delivery ratio" with linespoints lt rgb "blue"
set ylabel "Packets Dropped"
plot "tcp_wireless_packet.dat" using 1:5 title "Packet drop ratio" with linespoints lt rgb "violet" 
set ylabel "Throughput"
plot "tcp_wireless_packet.dat" using 1:2 title "Throughput" with linespoints lt rgb "red"
set ylabel "Energy consumed"
plot "tcp_wireless_packet.dat" using 1:6 title "Energy Consumption" with linespoints lt rgb "green"



set xlabel "Range"
set ylabel "Delay"
plot "tcp_wireless_range.dat" using 1:3 title "Average Delay" with linespoints lt rgb "red"
set ylabel "Packets Delivered"
plot "tcp_wireless_range.dat" using 1:4 title "Packet delivery ratio" with linespoints lt rgb "blue"
set ylabel "Packets Dropped"
plot "tcp_wireless_range.dat" using 1:5 title "Packet drop ratio" with linespoints lt rgb "violet" 
set ylabel "Throughput"
plot "tcp_wireless_range.dat" using 1:2 title "Throughput" with linespoints lt rgb "red"
set ylabel "Energy consumed"
plot "tcp_wireless_range.dat" using 1:6 title "Energy Consumption" with linespoints lt rgb "green"

