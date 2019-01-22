set title "metrics vs no of nodes" 
set xlabel "Number of nodes"
set ylabel "throughput"
set autoscale
set term png


set ylabel "Delay"
set output "vary_node_avg_delay.png"
plot "tcp_wireless_nodes.dat" using 1:3 title "Average Delay" with linespoints lt rgb "red"

set ylabel "Packets Delivered"
set output "vary_node_packet_delivery_ratio.png"
plot "tcp_wireless_nodes.dat" using 1:4 title "Packet delivery ratio" with linespoints lt rgb "blue"

set ylabel "Packets Dropped"
set output "vary_node_packet_drop_ratio.png"
plot "tcp_wireless_nodes.dat" using 1:5 title "Packet drop ratio" with linespoints lt rgb "violet" 

set ylabel "Throughput"
set output "vary_node_throughput.png"
plot "tcp_wireless_nodes.dat" using 1:2 title "Throughput" with linespoints lt rgb "red"

set ylabel "Energy consumed"
set output "vary_node_energy_consumed.png"
plot "tcp_wireless_nodes.dat" using 1:6 title "Energy Consumption" with linespoints lt rgb "green"

set ylabel "Energy Efficiency"
set output "vary_node_energy_efficiency.png"
plot "tcp_wireless_nodes.dat" using 1:7 title "Energy Efficiency" with linespoints lt rgb "blue"


set xlabel "Number of flows"

set ylabel "Delay"
set output "vary_flows_avg_delay.png"
plot "tcp_wireless_flows.dat" using 1:3 title "Average Delay" with linespoints lt rgb "red"

set ylabel "Packets Delivered"
set output "vary_flows_packet_delivery_ratio.png"
plot "tcp_wireless_flows.dat" using 1:4 title "Packet delivery ratio" with linespoints lt rgb "blue"

set ylabel "Packets Dropped"
set output "vary_flows_packet_drop_ratio.png"
plot "tcp_wireless_flows.dat" using 1:5 title "Packet drop ratio" with linespoints lt rgb "violet" 

set ylabel "Throughput"
set output "vary_flows_throughput.png"
plot "tcp_wireless_flows.dat" using 1:2 title "Throughput" with linespoints lt rgb "red"

set ylabel "Energy consumed"
set output "vary_flows_energy_consumed.png"
plot "tcp_wireless_flows.dat" using 1:6 title "Energy Consumption" with linespoints lt rgb "green"

set ylabel "Energy Efficiency"
set output "vary_flows_energy_efficiency.png"
plot "tcp_wireless_flows.dat" using 1:7 title "Energy Efficiency" with linespoints lt rgb "blue"


set xlabel "Number of packets"

set ylabel "Delay"
set output "vary_packets_avg_delay.png"
plot "tcp_wireless_packet.dat" using 1:3 title "Average Delay" with linespoints lt rgb "red"

set ylabel "Packets Delivered"
set output "vary_packets_packet_delivery_ratio.png"
plot "tcp_wireless_packet.dat" using 1:4 title "Packet delivery ratio" with linespoints lt rgb "blue"

set ylabel "Packets Dropped"
set output "vary_packets_packet_drop_ratio.png"
plot "tcp_wireless_packet.dat" using 1:5 title "Packet drop ratio" with linespoints lt rgb "violet" 

set ylabel "Throughput"
set output "vary_packets_throughput.png"
plot "tcp_wireless_packet.dat" using 1:2 title "Throughput" with linespoints lt rgb "red"

set ylabel "Energy consumed"
set output "vary_packets_energy_consumed.png"
plot "tcp_wireless_packet.dat" using 1:6 title "Energy Consumption" with linespoints lt rgb "green"

set ylabel "Energy Efficiency"
set output "vary_packets_energy_efficiency.png"
plot "tcp_wireless_packet.dat" using 1:7 title "Energy Efficiency" with linespoints lt rgb "blue"


set xlabel "Range"

set ylabel "Delay"
set output "vary_range_avg_delay.png"
plot "tcp_wireless_range.dat" using 1:3 title "Average Delay" with linespoints lt rgb "red"

set ylabel "Packets Delivered"
set output "vary_range_packet_delivery_ratio.png"
plot "tcp_wireless_range.dat" using 1:4 title "Packet delivery ratio" with linespoints lt rgb "blue"

set ylabel "Packets Dropped"
set output "vary_range_packet_drop_ratio.png"
plot "tcp_wireless_range.dat" using 1:5 title "Packet drop ratio" with linespoints lt rgb "violet" 

set ylabel "Throughput"
set output "vary_range_throughput.png"
plot "tcp_wireless_range.dat" using 1:2 title "Throughput" with linespoints lt rgb "red"

set ylabel "Energy consumed"
set output "vary_range_energy_consumed.png"
plot "tcp_wireless_range.dat" using 1:6 title "Energy Consumption" with linespoints lt rgb "green"

set ylabel "Energy Efficiency"
set output "vary_range_energy_efficiency.png"
plot "tcp_wireless_range.dat" using 1:7 title "Energy Efficiency" with linespoints lt rgb "blue"

