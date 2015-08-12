#!/usr/bin/env bash
#
# TextMagic REST API Client
#
# Copyright (C) 2015 TextMagic Ltd.

readonly E_OK=0
readonly E_INVALID_PARAMETERS=1
readonly E_MISSING_CREDENTIALS=2

################
# CONFIGURATION
################
readonly BASE_URL="https://rest.textmagic.com/api/v2"       # API base URL
readonly USERNAME=""                                        # Account username
readonly TOKEN=""                                           # API access token
readonly CURLOPTS=""                                        # Custom cURL options

function usage() {
    echo "Usage:"
    echo -e "\t$0 send [parameters]"
    echo -e "\t$0 <http-method> <resource> [parameters]\n"    
    echo "Examples:"
    echo -e "\t$0 send --phones=99912345,9997890 --text=\"Hello guys\""
    echo -e "\t$0 GET /replies"
    echo -e "\t$0 POST /messages --phones=99912345 --text=\"Hello guys\""    
    echo -e "\t$0 PUT /user --firstName=Charles --lastName=Conway --company=\"TextMagic Ltd.\""
    echo -e "\t$0 DELETE /contacts/183905"
}

function request() {
    local method path param data curl_string
    
    if [ -z $BASE_URL ] || [ -z $USERNAME ] || [ -z $TOKEN ]; then
        echo "Please configure your access credentials first"
        exit $E_MISSING_CREDENTIALS
    fi
    
    method="$1"; [[ $# > 0 ]] && shift
    case "$method" in
        GET|DELETE|POST|PUT)
            if [[ $# = 0 ]] || [ -z "$1" ] || [ "${1#/}" = "$1" ]; then
                usage
                exit $E_INVALID_PARAMETERS
            fi            
            path=${BASE_URL}${1} && shift
            [[ "$method" = "GET" ]] && curlopts="-G"
            curlopts="$curlopts $CURLOPTS"
                
            i=1
            for param in "$@"; do
                [[ $param == --*=* ]] && param=${param#*--} && data[i]="--data-urlencode '${param%%=*}=${param#*=}'" && i=$((i+1))  
            done
            
            curl_string="curl -s -X $method $curlopts -H 'X-TM-Username: $USERNAME' -H 'X-TM-Key: $TOKEN' ${data[@]} $path"
            eval "$curl_string"
            
            exit $E_OK
            ;;
        *)
            usage
            exit $E_INVALID_PARAMETERS
            ;;
    esac
}

if [[ "$1" = "send" ]]; then
    shift
    request POST /messages "$@"
fi
request "$@"