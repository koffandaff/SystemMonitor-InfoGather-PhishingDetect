#!/bin/bash
trap ctrl_c INT

function ctrl_c() {
    echo ""
    echo "Detected Ctrl+C — Exiting cleanly..."
    exit
}


echo "!!! This Tool is Made by Cheif Dhruvil used For system Monitoring, Infogathering and Phising Detection"
echo "!!! Only for education purpose Use tool respectfully"
echo "Use Numbers to navigate through Menu"
echo "" 
echo "Python library You might need to install whois, requests, tldextract"
echo ""
sysarr=("top -b -n 1" "df -h" "free -h")
infoarr=("whois" "dig" "nslookup" "traceroute -m 25")

while true
do 
        echo "1. System Monitor"
        echo "2. Infogathering "
        echo "3. Detect a Phishing site"
        echo "4. exit"
        read n
        echo ""
        case "$n" in
                1)
                        while true
                        do
                                echo "1. Show all running process and Threads"
                                echo "2. Show  Disk usage and availability in the system"
                                echo "3. Show Memory usage and free space"
                                echo "4. Show all of the above about the system"
                                echo "5. Back"
                                read sys
                                echo ""
                                case "$sys" in
                                        1)
                                                echo "Runnning Processes "
                                                ${sysarr[0]}
                                                echo ""
                                                ;;
                                        2) 
                                                echo "Disk Usage/Availability"
                                                ${sysarr[1]}
                                                echo ""
                                                ;;
                                        3) 
                                                echo "Memory Usage/Availability"
                                                ${sysarr[2]}
                                                echo ""
                                                ;;
                                        4) 
                                                echo "Everything at once"
                                                for cmd in "${sysarr[@]}"
                                                do
                                                        eval "$cmd"
                                                        echo ""
                                                done
                                                ;;
                                         5) 
                                                echo "Going to Main menu"
                                                break
                                                echo ""
                                                ;;

                                        *) 
                                                echo "Enter The right Number"
                                                ;;
                                esac

                                echo ""
                                echo ""
                        done

                ;;
                2)
                        echo "Write the site/Ip you wanna know about"
                        read site
                        echo""

                        while true
                        do

                                echo ""
                                echo "1. Investigate about the site/IP domain detail and it's history"
                                echo "2. Find IP address of the Site"
                                echo "3. Investiage about site DNS"
                                echo "4. Creation Date of the Site"
                                echo "5. Investigate How many hops way the Site is (max 25)"
                                echo "6. Perform Every Investigation on the site"
                                echo "7. Back"
                                read info
                                echo ""

                                case "$info" in
                                        1)
                                                echo "Details:"
                                                ${infoarr[0]} "$site" 
                                                echo ""
                                                ;;
                                        2) 
                                                echo "IP Addresses:"
                                                ${infoarr[2]} "$site" | grep "Address"
                                                echo ""
                                                ;;
                                        3) 
                                                echo "Adavnce DNS lookup:"
                                                ${infoarr[1]} "$site"
                                                echo ""
                                                ;;

                                        4) 
                                                echo "Site Creation date:"
                                                ${infoarr[0]} "$site" | grep "Creation"
                                                echo ""
                                                ;;
                                        5) 
                                                echo "Let's see how far the Server is number shows the hops(max 25)"
                                                ${infoarr[3]} "$site"
                                                echo ""
                                                ;;


                                        6)
                                                echo "All of the above Investigation on Site "
                                                for cmd in "${infoarr[@]}"
                                                do
                                                        eval "$cmd" "$site"
                                                done
                                                ;;

                                        7)
                                                echo "Back to Main Menu"
                                                break
                                                ;;
                                        *)
                                                echo "Choose the correct number dumbass"
                                                ;;

                                esac
                        echo ""
                        echo ""
                        done
                ;;
                3)
                        echo "Ignore the Warning Just Enter the URL"
                        python3 phishingdetection.py
                        echo ""
                        echo ""
                ;;
                4)
                        echo "Thanks for using this tool logging off"
                        exit
                        ;;


                *)
                        echo "Talk About trying to run a tool without knowing how to type 1,2 or 3"
                        ;;
        esac

done

