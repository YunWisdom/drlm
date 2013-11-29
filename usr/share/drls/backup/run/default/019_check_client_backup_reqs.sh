
# Check if the target client for backup is in DRLS client database

if test -n "$CLINAME"; then
	echo "by cliname"
	
	if exist_client_name "$CLINAME" ;	
	then
		echo "h1"
		IDCLIENT=$(get_cient_id_by_name $CLINAME)
		CLIMACADDR=$(get_client_mac $IDCLIENT)
	        CLIIPADDR=$(get_client_ip $IDCLIENT)
		echo "h2"
	else
		StopIfError "$PROGRAM: Client named: $CLINAME not registered!"
	fi
else
	echo "by clientid"
        if exist_client_id "$IDCLIENT" ;
        then
		echo "h3"
        	CLIMACADDR=$(get_client_mac $IDCLIENT)
	        CLIIPADDR=$(get_client_ip $IDCLIENT)
		echo "h4"
        else
        	StopIfError "$PROGRAM: Client with ID: $IDCLIENT not registered!"
        fi

fi

# Check if client is available over the network
if check_client_connectivity "$IDCLIENT" ; 
then
	LogPrint "Client $CLINAME is online!"
	echo $CLINAME
	echo $IDCLIENT
	echo ".-.-.-.-.-.-.-.-.-."
	echo $CLIMACADDR
	echo $CLIIPADDR
else
	StopIfError "Client $CLINAME is not online! aborting..." 
fi


