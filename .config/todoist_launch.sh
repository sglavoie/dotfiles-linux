#!/bin/bash

sleep 4

# Launch Todoist as a detached web app to avoid using the buggy snap version
brave-browser-stable --profile-directory=Default --app-id=elldfnmogicegdcphgljaoaklkpcnbnn --class=todoistapp
