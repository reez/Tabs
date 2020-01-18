#!/bin/bash

Pods/!ProtoCompiler/protoc \
--plugin=protoc-gen-grpc="Pods/!ProtoCompiler-gRPCPlugin/grpc_objective_c_plugin" \
--objc_out="Pods/LNDrpc" \
--grpc_out="Pods/LNDrpc" \
-I $GOPATH/src \
-I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
-I "Pods/!ProtoCompiler" \
-I "." \
./*.proto
