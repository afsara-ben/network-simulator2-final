#!/bin/bash
#INPUT: output file AND number of iterations
iteration_float=15.0;
iteration=$(printf %.0f $iteration_float);

k=0;
endfinal=15;
while [ $k -le  $endfinal ]
do


start=1
end=5
r=$start

whichTerm=""
if [ "$k" == "0" ];then
	whichTerm="nodes"
elif [ "$k" == "5" ];then
	whichTerm="flows"
elif [ "$k" == "10" ];then
	whichTerm="packet"
elif [ "$k" == "15" ];then
	whichTerm="range"
fi
output_file="tcp_all_wireless_for_$whichTerm.out"
output_file1="tcp_wireless_for_$whichTerm.out"
dat_file="tcp_wireless_$whichTerm.dat"
per_node_thruFile="per_node_throughput_$whichTerm.dat"
>$output_file
>$output_file1
>$dat_file
>$per_node_thruFile

while [ $r -le $end ]
do
echo "total iteration: $iteration"
###############################START A ROUND
# l=0;thr=0.0;del=0.0;s_packet=0.0;r_packet=0.0;d_packet=0.0;del_ratio=0.0;
# dr_ratio=0.0;time=0.0;

l=0;thr=0.0;del=0.0;s_packet=0.0;r_packet=0.0;d_packet=0.0;del_ratio=0.0;
dr_ratio=0.0;time=0.0;t_energy=0.0;energy_bit=0.0;energy_byte=0.0;energy_packet=0.0;total_retransmit=0.0;
t_range=0.00721383;energy_efficiency=0.0;

######################################

#k 0 change for NODE number
#k 5 change for FLOW number
#k 10 change for PACKET/SEC number
#k 15 change for TX_RANGE number

######################################
if [ "$k" == "0" ];then
	echo "                             VARYING FOR NUMBER OF NODES"
	num_packet=200;num_flow=10;t_range=0.00721383;
	if [ "$r" == "1" ]; then
	    num_row=2;num_col=10;
	elif [ "$r" == "2" ]; then	
	    num_row=4;num_col=10;
	elif [ "$r" == "3" ]; then
	    num_row=6;num_col=10;
	elif [ "$r" == "4" ]; then
	    num_row=8;num_col=10;
	elif [ "$r" == "5" ]; then
	    num_row=10;num_col=10;
	fi 
elif [ "$k" == "5" ];then	
	echo "                             VARYING FOR NUMBER OF FLOWS"
	num_row=4;num_col=10;num_packet=100;t_range=0.00721383;
	if [ "$r" == "1" ]; then
	    num_flow=10;
	elif [ "$r" == "2" ]; then	
	    num_flow=20;
	elif [ "$r" == "3" ]; then
	    num_flow=30;
	elif [ "$r" == "4" ]; then
	    num_flow=40;
	elif [ "$r" == "5" ]; then
	    num_flow=50;
	fi  
elif [ "$k" == "10" ];then
	echo "                             VARYING FOR NUMBER OF PACKETS/SEC"
	num_row=4;num_col=10;num_flow=30;t_range=0.00721383;
	if [ "$r" == "1" ]; then
	    num_packet=100;
	elif [ "$r" == "2" ]; then	
	    num_packet=200;
	elif [ "$r" == "3" ]; then
	    num_packet=300;
	elif [ "$r" == "4" ]; then
	    num_packet=400;
	elif [ "$r" == "5" ]; then
	    num_packet=500;
	fi 

elif [ "$k" == "15" ];then
	echo "                             VARYING FOR COVERAGE RANGE"
	num_row=4;num_col=10;num_flow=30;num_packet=100;
	if [ "$r" == "1" ]; then
		t_range=$(echo "1*$t_range" | bc);
		#echo "t_range : $t_range"
	elif [ "$r" == "2" ]; then	
		t_range=$(echo "2*$t_range" | bc);
	elif [ "$r" == "3" ]; then
		t_range=$(echo "3*$t_range" | bc);
	elif [ "$r" == "4" ]; then
		t_range=$(echo "4*$t_range" | bc);
	elif [ "$r" == "5" ]; then
		t_range=$(echo "5*$t_range" | bc);
	fi 
fi

echo "total nodes: $num_row $num_col "
echo ""

total_nodes=$(($num_row * $num_col))
j=0
	node_thr=()
	while [ $j -lt $total_nodes ]; do
		node_thr+=(0)
		j=$(($j+1))

	done
i=0
while [ $i -lt $iteration ]
do
num_node=$(($num_row*$num_col))
#################START AN ITERATION
echo "                             EXECUTING $(($i+1)) th ITERATION"
echo "                             num_node : $num_node"
echo "                             flow : $num_flow"
echo "                             packet : $num_packet"
echo "                             tx_range : $t_range"
echo "                             k	 : $k"



#echo "flow: $num_flow"
#ns wirelessstatic.tcl $num_row $num_col $num_flow $num_packet $t_range
ns-tcp-mod wirelessstatic.tcl $num_row $num_col $num_flow $num_packet $t_range
echo "SIMULATION COMPLETE. BUILDING STAT......"
#awk -f wired.awk wired.tr > wired.out
awk -f tcp_wireless.awk staticout.tr > tcp_wireless.out

while read val
do
	l=$(($l+1))

	if [ "$l" == "1" ]; then
		thr=$(echo "scale=5; $thr+$val/$iteration_float" | bc)
		echo -ne "throughput: $val " >> $output_file
	elif [ "$l" == "2" ]; then
		del=$(echo "scale=5; $del+$val/$iteration_float" | bc)
		echo -ne "delay: $val " >> $output_file
	elif [ "$l" == "3" ]; then
		s_packet=$(echo "scale=5; $s_packet+$val/$iteration_float" | bc)
		echo -ne "send packet: $val " >> $output_file
	elif [ "$l" == "4" ]; then
		r_packet=$(echo "scale=5; $r_packet+$val/$iteration_float" | bc)
		echo -ne "received packet: $val " >> $output_file
	elif [ "$l" == "5" ]; then
		d_packet=$(echo "scale=5; $d_packet+$val/$iteration_float" | bc)
		echo -ne "drop packet: $val " >> $output_file
	elif [ "$l" == "6" ]; then
		del_ratio=$(echo "scale=5; $del_ratio+$val/$iteration_float" | bc)
		echo -ne "delivery ratio: $val " >> $output_file
	elif [ "$l" == "7" ]; then
		dr_ratio=$(echo "scale=5; $dr_ratio+$val/$iteration_float" | bc)
		echo -ne "drop ratio: $val " >> $output_file
	elif [ "$l" == "8" ]; then
		time=$(echo "scale=5; $time+$val/$iteration_float" | bc)
		echo -ne "time: $val " >> $output_file
	elif [ "$l" == "9" ]; then
		t_energy=$(echo "scale=5; $t_energy+$val/$iteration_float" | bc)
		echo -ne "total_energy: $val " >> $output_file
	elif [ "$l" == "10" ]; then
		energy_bit=$(echo "scale=5; $energy_bit+$val/$iteration_float" | bc)
		echo -ne "energy_per_bit: $val " >> $output_file
	elif [ "$l" == "11" ]; then
		energy_byte=$(echo "scale=5; $energy_byte+$val/$iteration_float" | bc)
		echo -ne "energy_per_byte: $val " >> $output_file
	elif [ "$l" == "12" ]; then
		energy_packet=$(echo "scale=5; $energy_packet+$val/$iteration_float" | bc)
		echo -ne "energy_per_packet: $val " >> $output_file
	elif [ "$l" == "13" ]; then
		total_retransmit=$(echo "scale=5; $total_retransmit+$val/$iteration_float" | bc)
		echo -ne "total_retransmit: $val \n" >> $output_file
	elif [ "$l" == "14" ]; then
		energy_efficiency=$(echo "scale=9; $energy_efficiency+$val/$iteration_float" | bc)
		echo -ne "energy_efficiency: $val \n" >> $output_file

	else
	 		#echo "					here"
			n_num=$(echo $val | cut -d' ' -f 1)
			n_thr=$(echo $val | cut -d' ' -f 2)

			node_thr[$n_num]=$(echo "scale=9; ${node_thr[$n_num]}+$n_thr/$iteration_float" | bc)

			if [ $n_num -lt $total_nodes ]; then
				echo node throughput : $n_num $n_thr ${node_thr[$n_num]}
			fi

	fi


	echo "$val"
done < tcp_wireless.out

i=$(($i+1))
l=0
#################END AN ITERATION
done
total_nodes=$(($num_row * $num_col))
echo "flow is:$num_flow  num_row is:$num_row  num_col is:$num_col"
if [ "$k" == "0" ];then
	echo -ne "$total_nodes $thr $del $del_ratio $dr_ratio $t_energy $energy_efficiency">>$dat_file
	echo "">>$dat_file
elif [ "$k" == "5" ];then
	echo -ne "$num_flow $thr $del $del_ratio $dr_ratio $t_energy $energy_efficiency">>$dat_file
	echo "">>$dat_file
elif [ "$k" == "10" ];then
	echo -ne "$num_packet $thr $del $del_ratio $dr_ratio $t_energy $energy_efficiency">>$dat_file
	echo "">>$dat_file
elif [ "$k" == "15" ];then
	echo -ne "$t_range $thr $del $del_ratio $dr_ratio $t_energy $energy_efficiency">>$dat_file
	echo "">>$dat_file
fi

echo -ne "\n\nnodes: $num_row  $num_col  " >> $output_file1

echo -ne "Throughput:          				$thr \n" >> $output_file1
echo -ne "AverageDelay:         			$del \n" >> $output_file1
echo -ne "Sent Packets:         			$s_packet \n" >> $output_file1
echo -ne "Received Packets:         		$r_packet \n" >> $output_file1
echo -ne "Dropped Packets:         			$d_packet \n" >> $output_file1
echo -ne "PacketDeliveryRatio:      		$del_ratio \n" >> $output_file1
echo -ne "PacketDropRatio:      			$dr_ratio \n" >> $output_file1
echo -ne "Total time:  						$time \n\n" >> $output_file1
echo -ne "Total energy consumption:        	$t_energy " >> $output_file1
echo -ne "Average Energy per bit:         	$energy_bit " >> $output_file1
echo -ne "Average Energy per byte:         	$energy_byte " >> $output_file1
echo -ne "Average energy per packet:        $energy_packet " >> $output_file1
echo "total_retransmit:         			$total_retransmit " >> $output_file1
echo "energy_efficiency: 				$energy_efficiency " >> $output_file1

	z=0;
	if [ "$k" == "0" ];then
		echo "-1 $total_nodes ">>$per_node_thruFile
	elif [ "$k" == "5" ];then
		echo "-1 $num_flow ">>$per_node_thruFile
	elif [ "$k" == "10" ];then
		echo  "-1 $num_packet ">>$per_node_thruFile
	elif [ "$k" == "15" ];then
		echo  "-1 $t_range ">>$per_node_thruFile
	fi
	while [ $z -lt $total_nodes ]; do

		temp_thr=$(printf %.0f ${node_thr[$z]});
		echo "	in while			$temp_thr"
		if [ $temp_thr -gt 0 ]; then
			echo $z ${node_thr[$z]} >> $per_node_thruFile
			echo Per-node Throughput: $z ${node_thr[$z]}

		fi

		z=$(($z+1))

	done

r=$(($r+1))
#######################################END A ROUND
done
k=$(($k+5))
done
pwd
cp per_node_throughput_flows.dat out/per_node_throughput_flows.dat
cp per_node_throughput_nodes.dat out/per_node_throughput_nodes.dat
cp per_node_throughput_packet.dat out/per_node_throughput_packet.dat
cp per_node_throughput_range.dat out/per_node_throughput_range.dat

gnuplot plot.p
./graph.sh #for generating graphs of per node throughput

