#!/bin/bash

SPOOLFILE="/tmp/print"

handle_post() {
        echo "Content-Type: application/json"
        echo ""

        if [ -f "$SPOOLFILE" ]; then

                echo "{"
                echo -e "\"jobReady\": true,"
                echo -e "\"mediaTypes\": [\"text/plain\"],"
                echo -e "\"deleteMethod\": \"GET\""
                echo "}"

        else
                echo "{"
                echo -e "\"jobReady\": false"
                echo "}"
        fi
        (>&2 cat)
}

handle_get() {
        echo "Content-Type: text/plain"
        echo ""
        if [ -f "$SPOOLFILE" ]; then
                cat "$SPOOLFILE"
        fi
}

handle_delete() {
                (rm -f -v "$SPOOLFILE" >> /tmp/cplog 2>> /tmp/cplog)
                echo "Content-Type: text/plain"
                echo ""
}

echo "Cache-Control: no-cache, no-store, must-revalidate"
echo "Pragma: no-cache"
echo "Expires: 0"

if [ "x$REQUEST_METHOD" == "xPOST" ]; then
        (>&2 echo "Received POST request")
        handle_post

elif [ "x$REQUEST_METHOD" == "xGET" ]; then

        (echo "Received GET $QUERY_STRING" >> /tmp/cplog)
        case $QUERY_STRING in
                *delete*)
                        (>&2 echo "Received GET delete request")
                        handle_delete
                        ;;
                *)
                        (>&2 echo "Received GET request")
                        handle_get
                        ;;
        esac

elif [ "x$REQUEST_METHOD" == "xDELETE" ]; then
        (>&2 echo "Received DELETE request")
        handle_delete
else
        (>&2 echo "unhandled method")
fi

