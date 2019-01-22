set title "metrics vs no of nodes" 

set ylabel "throughput"
set autoscale

set term png

set xlabel "Number of nodes"

	set ylabel "Delay"
	set output "vary_node_avg_delay.png"
	plot "tcp_wired_nodes.dat" using 1:3 title "average delay" with linespoints lt rgb "red"

	set ylabel "Packets Delivered"
	set output "vary_node_packet_delivery_ratio.png"
	plot "tcp_wired_nodes.dat" using 1:4 title "packet delivery ratio" with linespoints lt rgb "blue"

	set ylabel "Packets Dropped"
	set output "vary_node_packet_drop_ratio.png"
	plot "tcp_wired_nodes.dat" using 1:5 title "packet drop ratio" with linespoints lt rgb "violet" 

	set ylabel "Throughput"
	set output "vary_node_throughput.png"
	plot "tcp_wired_nodes.dat" using 1:2 title "throughput" with linespoints lt rgb "red"

set xlabel "Number of flows"

	set ylabel "Delay"
	set output "vary_flows_avg_delay.png"
	plot "tcp_wired_flows.dat" using 1:3 title "average delay" with linespoints lt rgb "red"

	set ylabel "Packets Delivered"
	set output "vary_flows_packet_delivery_ratio.png"
	plot "tcp_wired_flows.dat" using 1:4 title "packet delivery ratio" with linespoints lt rgb "blue"

	set ylabel "Packets Dropped"
	set output "vary_flows_packet_drop_ratio.png"
	plot "tcp_wired_flows.dat" using 1:5 title "packet drop ratio" with linespoints lt rgb "violet" 

	set ylabel "Throughput"
	set output "vary_flows_throughput.png"
	plot "tcp_wired_flows.dat" using 1:2 title "throughput" with linespoints lt rgb "red"

set xlabel "Number of packets"

	set ylabel "Delay"
	set output "vary_packets_avg_delay.png"
	plot "tcp_wired_packet.dat" using 1:3 title "average delay" with linespoints lt rgb "red"

	set ylabel "Packets Delivered"
	set output "vary_packets_packet_delivery_ratio.png"
	plot "tcp_wired_packet.dat" using 1:4 title "packet delivery ratio" with linespoints lt rgb "blue"

	set ylabel "Packets Dropped"
	set output "vary_packets_packet_drop_ratio.png"
	plot "tcp_wired_packet.dat" using 1:5 title "packet drop ratio" with linespoints lt rgb "violet" 

	set ylabel "Throughput"
	set output "vary_packets_throughput.png"
	plot "tcp_wired_packet.dat" using 1:2 title "throughput" with linespoints lt rgb "red"
