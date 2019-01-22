BEGIN {
	max_node = 2000;
	nSentPackets = 0.0 ;		
	#nSentPackets = 1.0 ;		
	
	nReceivedPackets = 0.0 ;
	rTotalDelay = 0.0 ;
	max_pckt = 10000;
	
	idHighestPacket = 0;
	idLowestPacket = 100000;
	rStartTime = 10000.0;
	rEndTime = 0.0;
	nReceivedBytes = 0;

	nDropPackets = 0.0;

	total_energy_consumption = 0;
	rEnergyEfficiency = 0;

	temp = 0;
	
	for (i=0; i<max_node; i++) {
		energy_consumption[i] = 0;		
	}

	total_retransmit = 0;
	for (i=0; i<max_pckt; i++) {
		retransmit[i] = 0;		
	}

}

{
#	event = $1;    time = $2;    node = $3;    type = $4;    reason = $5;    node2 = $5;    
#	packetid = $6;    mac_sub_type=$7;    size=$8;    source = $11;    dest = $10;    energy=$14;

	strEvent = $1 ;
	idPacket = $41;			rTime = $3 ;
	node = $9 ;	
	pkt_size = $37;			
	strAgt = $19 ;			
	strType = $35 ;			#nBytes = $8;

	# energy = $13;			total_energy = $14;
	# idle_energy_consumption = $16;	sleep_energy_consumption = $18; 
	# transmit_energy_consumption = $20;	receive_energy_consumption = $22; 
	# num_retransmit = $30;
	# rThroughput_per_node[max_node];
	
	sub(/^_*/, "", node);
	sub(/_*$/, "", node);

# 	if (energy == "[energy") {
# 		energy_consumption[node] = (idle_energy_consumption + sleep_energy_consumption + transmit_energy_consumption + receive_energy_consumption);
# #		printf("%d %15.5f\n", node, energy_consumption[node]);
# 	}

# 	if( 0 && temp <=25 && energy == "[energy" && strEvent == "D") {
# 		#printf("%s %15.5f %d %s %15.5f %15.5f %15.5f %15.5f %15.5f \n", strEvent, rTime, idPacket, energy, total_energy, idle_energy_consumption, sleep_energy_consumption, transmit_energy_consumption, receive_energy_consumption);
# 		temp+=1;
# 	}


	#if(pkt_size != 0) {	printf("%15.0f\n", pkt_size);}
	if ( strAgt == "AGT"   &&   strType == "tcp" ) {
		if (idPacket > idHighestPacket) idHighestPacket = idPacket;
		if (idPacket < idLowestPacket) idLowestPacket = idPacket;

		if(rTime>rEndTime) rEndTime=rTime;
		if(rTime<rStartTime) rStartTime=rTime;

		if ( strEvent == "s" ) {
			nSentPackets += 1 ;	rSentTime[ idPacket ] = rTime ;
			#printf("%15.5f\n", nSentPackets);
		}
#		if ( strEvent == "r" ) {
		if ( strEvent == "r" && idPacket >= idLowestPacket) {
			nReceivedPackets += 1 ;		#nReceivedBytes += nBytes;
			#printf("%15.0f\n", nBytes);

			################
 			   # Rip off the header
               #hdr_size = pkt_size % 512
               #printf("hdr size : %15.0f\n", hdr_size);
               #pkt_size -= hdr_size
               # Store received packet's size
               nReceivedBytes += pkt_size
              # printf("%15.9f\n", pkt_size);
               #printf("%15.9f\n", nReceivedBytes);
			################

			rThroughput_per_node[node] = nBytes*8 / rTime;
			rReceivedTime[ idPacket ] = rTime ;
			rDelay[idPacket] = rReceivedTime[ idPacket] - rSentTime[ idPacket ];
#			rTotalDelay += rReceivedTime[ idPacket] - rSentTime[ idPacket ];
			rTotalDelay += rDelay[idPacket]; 

#			printf("%15.5f   %15.5f\n", rDelay[idPacket], rReceivedTime[ idPacket] - rSentTime[ idPacket ]);
		}
	}

	# if( strEvent == "D"   &&   strType == "tcp" )
	# if( strEvent == "D"   &&   strType == "message" )
	if( strEvent == "D"   &&   strType == "cbr" ) 
	{
		if(rTime>rEndTime) rEndTime=rTime;
		if(rTime<rStartTime) rStartTime=rTime;
		nDropPackets += 1;
		#printf("packet dropped\n")
	}

# 	if( strType == "tcp" )
# 	{
# #		printf("%d \n", idPacket);
# #		printf("%d %15d\n", idPacket, num_retransmit);
# 		retransmit[idPacket] = num_retransmit;		
# 	}
}

END {
	rTime = rEndTime - rStartTime ;
	rThroughput = nReceivedBytes*8 / rTime;
	rPacketDeliveryRatio = (nReceivedPackets / nSentPackets) * 100 ;
	rPacketDropRatio = (nDropPackets / nSentPackets) * 100;

	for(i=0; i<max_node;i++) {
#		printf("%d %15.5f\n", i, energy_consumption[i]);
		total_energy_consumption += energy_consumption[i];
	}
	if ( nReceivedPackets != 0 ) {
		rAverageDelay = rTotalDelay / nReceivedPackets ;
		avg_energy_per_packet = total_energy_consumption / nReceivedPackets ;
	}

	if ( nReceivedBytes != 0 ) {
		avg_energy_per_byte = total_energy_consumption / nReceivedBytes ;
		avg_energy_per_bit = avg_energy_per_byte / 8;
		rEnergyEfficiency = total_energy_consumption / (nReceivedBytes*8);
	}

	
	for (i=0; i<max_pckt; i++) {
		total_retransmit += retransmit[i] ;		
#		printf("%d %15.5f\n", i, retransmit[i]);
	}

#	printf( "AverageDelay: %15.5f PacketDeliveryRatio: %10.2f\n", rAverageDelay, rPacketDeliveryRatio ) ;

	# printf( "%15.5f\n%15.5f\n%15.5f\n%15.2f\n%15.5f\n%10.5f\n%10.5f\n%10.5f\n", rThroughput, rAverageDelay, nSentPackets, nReceivedPackets, nDropPackets, rPacketDeliveryRatio, rPacketDropRatio,rTime) ;
	# printf("%15.5f\n%15.5f\n%15.5f\n%15.5f\n%15.5f\n%15.9f\n", total_energy_consumption, avg_energy_per_bit, avg_energy_per_byte, avg_energy_per_packet, total_retransmit,rEnergyEfficiency);

	for (i =0; i< max_node; i++)
	{
		if(rThroughput_per_node[i] != 0)
			{
				printf("%.0f %.5f\n",i, rThroughput_per_node[i]);
			}
	}
	# printf( "%15.5f\n%15.5f\n%15.5f\n%15.2f\n%15.5f\n%10.5f\n%10.5f\n%10.5f\n", rThroughput, rAverageDelay, nSentPackets, nReceivedPackets, nDropPackets, rPacketDeliveryRatio, rPacketDropRatio,rTime) ;
	# printf("%15.5f\n%15.5f\n%15.5f\n%15.5f\n%15.5f\n", total_energy_consumption, avg_energy_per_bit, avg_energy_per_byte, avg_energy_per_packet, total_retransmit);


#	printf( "%15.2f\n%15.5f\n%15.2f\n%15.2f\n%15.2f\n%15.2f\n%15.2f\n%15.5f\n", rThroughput, rAverageDelay, nSentPackets, nReceivedPackets, nDropPackets, rPacketDeliveryRatio, rPacketDropRatio,rTime) ;
#	printf("%15.5f\n%15.5f\n%15.5f\n%15.5f\n%15.0f\n", total_energy_consumption, avg_energy_per_bit, avg_energy_per_byte, avg_energy_per_packet, total_retransmit);


	# printf( "Throughput: %15.2f Delay: %15.5f Sent_Pckts: %15.2f Rcvd_Pckts: %15.2f Drop_Pckts: %15.2f Delivery_Ratio: %15.2f Drop_Ratio: %15.2f Time: %15.5f ", rThroughput, rAverageDelay, nSentPackets, nReceivedPackets, nDropPackets, rPacketDeliveryRatio, rPacketDropRatio,rTime) ;
	# printf("Total_energy: %15.5f Avg_enr_per_bit: %15.5f Avg_enr_per_byte: %15.5f Avg_enr_per_pckt: %15.5f Total_rexmit: %15.0f\n", total_energy_consumption, avg_energy_per_bit, avg_energy_per_byte, avg_energy_per_packet, total_retransmit);
	printf( "Throughput: %15.9f \nAverageDelay: %15.5f \nSent Packets: %15.2f \nReceived Packets: %15.2f \nDropped Packets: %15.2f \nPacketDeliveryRatio: %10.2f \nPacketDropRatio: %10.2f\nTotal time: %10.5f\n", rThroughput, rAverageDelay, nSentPackets, nReceivedPackets, nDropPackets, rPacketDeliveryRatio, rPacketDropRatio,rTime) ;
	

	# printf( "Throughput: %15.9f \nAverageDelay: %15.5f \nSent Packets: %15.2f \nReceived Packets: %15.2f \nDropped Packets: %15.2f \nPacketDeliveryRatio: %10.2f \nPacketDropRatio: %10.2f\nTotal time: %10.5f\n", rThroughput, rAverageDelay, nSentPackets, nReceivedPackets, nDropPackets, rPacketDeliveryRatio, rPacketDropRatio,rTime) ;
	# printf("\n\nTotal energy consumption: %15.5f \nAverage Energy per bit: %15.5f \nAverage Energy per byte: %15.5f \nAverage energy per packet: %15.5f\n", total_energy_consumption, avg_energy_per_bit, avg_energy_per_byte, avg_energy_per_packet);
}


