#!/bin/bash

# Init the step ca
step ca init --name=TestCA --dns=127.0.0.1 --address=:8443 --provisioner=example@nxp.com --password-file="/secret/password.txt"

# Start the step ca
echo "Starting step-ca..."
step-ca $(step path)/config/ca.json -password-file "/secret/password.txt" &
sleep 2

echo "step ca initialized and up?"
export STEPDEBUG=0
step ca health

# Generate server private key and certificate signed by ca
echo "Generating server key and certificate ..."
step ca certificate 127.0.0.1 "srv.crt" "srv.key" --provisioner-password-file="/secret/password.txt"

echo "Use following fingerprint to bootstrap ca root certificate:"
step certificate fingerprint $(step path)/certs/root_ca.crt


# Start server application
echo "Run server using generated credentials ..."
go run srv.go
