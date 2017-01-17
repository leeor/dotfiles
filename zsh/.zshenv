pushover() {
    if [[ $# == 1 ]]; then
        TITLE="Script notification"
    else
        TITLE=$1; shift
    fi

    curl -s -F "token=***REMOVED***" \
        -F "user=***REMOVED***" \
        -F "title=${TITLE}" \
        -F "message=$1" \
        https://api.pushover.net/1/messages.json
}
