#!/bin/sh
echo "Cache-Control: no-cache, no-store, must-revalidate"
echo "Pragma: no-cache"
echo "Expires: 0"
echo "Content-Type: text/plain"
echo
echo "done `date`"
echo "reload to print again"
echo "Test Print\n\nGenerated: `date`\nFrom: $REMOTE_ADDR\nQuery String: $QUERY_STRING\n\n\n" > /tmp/print