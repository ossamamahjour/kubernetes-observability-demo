#!/bin/bash
# Save as traffic-gen.sh and run it

# Use kubectl port-forward in background
kubectl port-forward svc/sample-app 8080:8080 &
PF_PID=$!

# Wait for port-forward to establish
sleep 3

# Generate varied traffic patterns
for i in {1..100}; do
  # Different endpoints to generate diverse traces
  curl "http://localhost:8080/dispatch?customer=392&nonse=$i"
  curl "http://localhost:8080/customer?customer=392"
  curl "http://localhost:8080/driver?driver=T7$i"
  sleep 1
done

# Clean up port-forward
kill $PF_PID
