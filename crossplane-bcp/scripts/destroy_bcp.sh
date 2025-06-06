#!/bin/bash
# Teardown BCP cluster resources
kubectl delete configuration jcp --ignore-not-found
kubectl delete configuration bcp --ignore-not-found
