#!/bin/bash

dir=""
output_file_format="per_node_throughput";
under="_"
graph=""
all=""
nodeThr=""
temp="temp"
var3="conges_avg"
dot="."


cd out/
#rm -rf graphs

#mkdir graphs
#cd graphs/


variation=1
pwd
while [ $variation -le 4 ] 
do
	if [ $variation -eq 1 ]; then 
		echo 
		echo 
		echo "*********GENERATING GRAPHS VARYING NUMBER OF NODES*********"
		vary="nodes"

	elif [ $variation -eq 2 ]; then 
		echo 
		echo 
		echo "*********GENERATING GRAPHS VARYING NUMBER OF FLOWS*********"
		vary="flows"

	elif [ $variation -eq 3 ]; then 
		echo 
		echo 
		echo "*********GENERATING GRAPHS VARYING PACKETS PER SECOND*********"
		vary="packet"

	elif [ $variation -eq 4 ]; then 
		echo 
		echo 
		echo "*********GENERATING GRAPHS VARYING RANGE OF NODES*********"
		vary="range"
			
	else 
		echo 
		echo 
		echo "*********WRONG*********"
	fi

	#output_file2="$dir$output_file_format$under$vary$under$graph.out"
	output_file2="$dir$output_file_format$under$vary.dat"

#	node_thr_file="$dir$output_file_format$under$vary$under$nodeThr.out"
	node_thr_file="$output_file_format$under$vary.dat"


	#cwnd_file="$dir$output_file_format$under$vary$under$var3$under.out"


	# gnuplot -persist <<-EOFMarker
	# 	set style line 1 \
	# 	    linecolor rgb '#0060ad' \
	# 	    linetype 1 linewidth 2 \
	# 	    pointtype 7 pointsize 1.5

	# 	set xlabel '$vary'    

	# 	set ylabel 'THR'
	# 	set term png
	# 	set output "THR VS $vary.png"    
	# 	plot '$output_file2' using 1:2 with linespoints linestyle 1 title "Thr VS $vary"

	# 	set ylabel 'Delay'
	# 	set term png
	# 	set output "Delay VS $vary.png"    
	# 	plot '$output_file2' using 1:3 with linespoints linestyle 1 title "Delay VS $vary"

	# 	set ylabel 'DelRatio'
	# 	set term png
	# 	set output "DelRatio VS $vary.png"    
	# 	plot '$output_file2' using 1:4 with linespoints linestyle 1 title "DelRatio VS $vary"

	# 	set ylabel 'DropRatio'
	# 	set term png
	# 	set output "DropRatio VS $vary.png"    
	# 	plot '$output_file2' using 1:5 with linespoints linestyle 1 title "DropRatio VS $vary"

	# 	set ylabel 'TotalEnergy'
	# 	set term png
	# 	set output "TotalEnergy VS $vary.png"    
	# 	plot '$output_file2' using 1:6 with linespoints linestyle 1 title "TotalEnergy VS $vary"

	# EOFMarker


	#NODE THR FILE
	range_count=1;
	echo "node_thr_file : 	$node_thr_file"
	cat $node_thr_file | while read line 
	do

		first_val=$(echo $line | cut -d' ' -f 1)

		if [ $first_val -eq "-1" ]; then
			#echo "				$line"
#			curr_num_point=$(echo $line | cut -d' ' -f $(($variation+2)))
			curr_num_point=$(echo $line | cut -d' ' -f 2)
			echo "curr_num_point  $curr_num_point"
			if [[ $variation -eq 4 ]]; then
				curr_num_point=$(($range_count))
				range_count=$(($range_count+1))
			fi
			temp_file="$dir$output_file_format$under$vary$under$temp$curr_num_point.dat"
			rm -f $temp_file
			touch $temp_file

			echo "temp_file  	$temp_file"

		else
			echo $line >> $temp_file

		fi
	
	done



	#======================================
	#PER_NODE THROUGHPUT GRAPHS WILL BE GENERATED IN BANGLA METHOD
	#======================================

	temp_file="$dir$output_file_format$under$vary$under$temp"

	if [ $variation -eq 1 ]; then 
		echo "		done done"
		gnuplot -persist <<-EOFMarker
			set xlabel 'Node Number'    

			set ylabel 'PER-NODE THR'
			set term png
			set output "PER-NODE THR VS $vary.png"    
			plot '$temp_file$((20)).dat' using 1:2 with line title "$vary = 20", \
			 '$temp_file$((40)).dat' using 1:2 with line title "$vary = 40", \
			 '$temp_file$((60)).dat' using 1:2 with line title "$vary = 60", \
			 '$temp_file$((80)).dat' using 1:2 with line title "$vary = 80", \
			 '$temp_file$((100)).dat' using 1:2 with line title "$vary = 100"

			# plot '$temp_file.dat' using 1:2 with line title "$vary = 20", \
			#  '$temp_file.dat' using 1:2 with line title "$vary = 40", \
			#  '$temp_file.dat' using 1:2 with line title "$vary = 60", \
			#  '$temp_file.dat' using 1:2 with line title "$vary = 80", \
			#  '$temp_file.dat' using 1:2 with line title "$vary = 100"


		EOFMarker

	elif [ $variation -eq 2 ]; then 
		gnuplot -persist <<-EOFMarker
			set xlabel 'Node Number'    

			set ylabel 'PER-NODE THR'
			set term png
			set output "PER-NODE THR VS $vary.png"    
			plot '$temp_file$((10)).dat' using 1:2 with line title "$vary = 10", \
			 '$temp_file$((20)).dat' using 1:2 with line title "$vary = 20", \
			 '$temp_file$((30)).dat' using 1:2 with line title "$vary = 30", \
			 '$temp_file$((40)).dat' using 1:2 with line title "$vary = 40", \
			 '$temp_file$((50)).dat' using 1:2 with line title "$vary = 50"

			# plot '$temp_file.dat' using 1:2 with line title "$vary = 10", \
			#  '$temp_file.dat' using 1:2 with line title "$vary = 20", \
			#  '$temp_file.dat' using 1:2 with line title "$vary = 30", \
			#  '$temp_file.dat' using 1:2 with line title "$vary = 40", \
			#  '$temp_file.dat' using 1:2 with line title "$vary = 50"

		EOFMarker

	elif [ $variation -eq 3 ]; then 
		gnuplot -persist <<-EOFMarker
			set xlabel 'Node Number'    

			set ylabel 'PER-NODE THR'
			set term png
			set output "PER-NODE THR VS $vary.png"    
			plot '$temp_file$((100)).dat' using 1:2 with line title "$vary = 100", \
			 '$temp_file$((200)).dat' using 1:2 with line title "$vary = 200", \
			 '$temp_file$((300)).dat' using 1:2 with line title "$vary = 300", \
			 '$temp_file$((400)).dat' using 1:2 with line title "$vary = 400", \
			 '$temp_file$((500)).dat' using 1:2 with line title "$vary = 500"

			 #  plot '$temp_file.dat' using 1:2 with line title "$vary = 100", \
			 # '$temp_file.dat' using 1:2 with line title "$vary = 200", \
			 # '$temp_file.dat' using 1:2 with line title "$vary = 300", \
			 # '$temp_file.dat' using 1:2 with line title "$vary = 400", \
			 # '$temp_file.dat' using 1:2 with line title "$vary = 500"

		EOFMarker

	elif [ $variation -eq 4 ]; then 
		gnuplot -persist <<-EOFMarker

			set xlabel 'Node Number'    

			set ylabel 'PER-NODE THR'
			set term png
			set output "PER-NODE THR VS $vary.png"    
			# plot '$temp_file$dot$((10#0072137)).dat' using 1:2 with line title "$vary = ", \
			#  '$temp_file$dot$((10#01442766)).dat' using 1:2 with line title "$vary = 10", \
			#  '$temp_file$dot$((10#0216414)).dat' using 1:2 with line title "$vary = 15", \
			#  '$temp_file$dot$((10#02885532 )).dat' using 1:2 with line title "$vary = 20", \
			#  '$temp_file$dot$((10#03606915 )).dat' using 1:2 with line title "$vary = 25"

			plot '$temp_file$((1)).dat' using 1:2 with line title "$vary = .00721383 ", \
			 '$temp_file$((2)).dat' using 1:2 with line title "$vary = .01442766", \
			 '$temp_file$((3)).dat' using 1:2 with line title "$vary = .02164149", \
			 '$temp_file$((4 )).dat' using 1:2 with line title "$vary = .02885532", \
			 '$temp_file$((5)).dat' using 1:2 with line title "$vary = .03606915"

			
		EOFMarker
			
	else 
		echo 
		echo 
		echo "*********WRONG*********"
	fi





	# #CWND FILE
	# while read line 
	# do

	# 	first_val=$(echo $line | cut -d' ' -f 1)

	# 	if [ "$first_val" == "-2" ]; then
	# 		curr_num_point=$(echo $line | cut -d' ' -f $((variation+2)))
	# 		#echo $curr_num_point
	# 		temp_file="$dir$output_file_format$under$vary$under$temp$curr_num_point.out"
	# 		rm -f $temp_file
	# 		touch $temp_file

	# 		#echo $temp_file

	# 	else
	# 		echo $line >> $temp_file

	# 	fi
	
	# done < "$cwnd_file"

	# #======================================
	# #Average Congestion Window GRAPHS WILL BE GENERATED IN BANGLA METHOD
	# #======================================

	# temp_file="$dir$output_file_format$under$vary$under$temp"

	# if [ $variation -eq 1 ]; then 
	# 	gnuplot -persist <<-EOFMarker
	# 		set xlabel 'Time'    

	# 		set ylabel 'Avg Congestion'
	# 		set term png
	# 		set output "Avg_Congestion VS $vary.png"    
	# 		plot '$temp_file$((20)).out' using 1:2 with line title "$vary = 20", \
	# 		 '$temp_file$((40)).out' using 1:2 with line title "$vary = 40", \
	# 		 '$temp_file$((60)).out' using 1:2 with line title "$vary = 60", \
	# 		 '$temp_file$((80)).out' using 1:2 with line title "$vary = 80", \
	# 		 '$temp_file$((100)).out' using 1:2 with line title "$vary = 100"

	# 	EOFMarker

	# elif [ $variation -eq 2 ]; then 
	# 	gnuplot -persist <<-EOFMarker
	# 		set xlabel 'Time'    

	# 		set ylabel 'Avg Congestion'
	# 		set term png
	# 		set output "Avg_Congestion VS $vary.png"    
	# 		plot '$temp_file$((10)).out' using 1:2 with line title "$vary = 10", \
	# 		 '$temp_file$((20)).out' using 1:2 with line title "$vary = 20", \
	# 		 '$temp_file$((30)).out' using 1:2 with line title "$vary = 30", \
	# 		 '$temp_file$((40)).out' using 1:2 with line title "$vary = 40", \
	# 		 '$temp_file$((50)).out' using 1:2 with line title "$vary = 50"

	# 	EOFMarker

	# elif [ $variation -eq 3 ]; then 
	# 	gnuplot -persist <<-EOFMarker
	# 		set xlabel 'Time'    

	# 		set ylabel 'Avg Congestion'
	# 		set term png
	# 		set output "Avg_Congestion VS $vary.png"    
	# 		plot '$temp_file$((100)).out' using 1:2 with line title "$vary = 100", \
	# 		 '$temp_file$((200)).out' using 1:2 with line title "$vary = 200", \
	# 		 '$temp_file$((300)).out' using 1:2 with line title "$vary = 300", \
	# 		 '$temp_file$((400)).out' using 1:2 with line title "$vary = 400", \
	# 		 '$temp_file$((500)).out' using 1:2 with line title "$vary = 500"

	# 	EOFMarker
	# elif [ $variation -eq 4 ]; then 
	# 	gnuplot -persist <<-EOFMarker
	# 		set xlabel 'Time'    

	# 		set ylabel 'Avg Congestion'
	# 		set term png
	# 		set output "Avg_Congestion VS $vary.png"    
	# 		plot '$temp_file$((5)).out' using 1:2 with line title "$vary = 5", \
	# 		 '$temp_file$((10)).out' using 1:2 with line title "$vary = 10", \
	# 		 '$temp_file$((15)).out' using 1:2 with line title "$vary = 15", \
	# 		 '$temp_file$((20)).out' using 1:2 with line title "$vary = 20", \
	# 		 '$temp_file$((25)).out' using 1:2 with line title "$vary = 25"

	# 	EOFMarker
	
	# else
	# 	echo 
	# 	echo 
	# 	echo "*********WRONG*********"
	# fi





	echo Done generating $vary variation graphs
	variation=$(($variation+1))


done

#cd ../..
