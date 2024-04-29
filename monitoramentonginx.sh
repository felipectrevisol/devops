#!/bin/bash

get_nginx() {
  local metrics=$(curl -s "http://localhost/nginx_status")
  if [[ -n "$metrics" ]]; then
    local active_connections=$(awk 'NR==1 {print $3}' <<< "$metrics")
    local requests_per_second=$(awk 'NR==3 {print $2}' <<< "$metrics")
    echo "Active connections: $active_connections"
    echo "Requests per second: $requests_per_second"
  else
    echo "Failure in collecting Nginx metrics."
  fi
}

get_nginx