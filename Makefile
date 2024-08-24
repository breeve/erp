.PHONY: pb
pb:
	protoc --go_out=./pkg/apis --go-grpc_out=./pkg/apis --go_opt=paths=source_relative --go-grpc_opt=paths=source_relative ./pkg/pb/*.proto

.PHONY: server
server:
	go build -o build/server cmd/server/server.go

.PHONY: client
client:
	go build -o build/client cmd/client/client.go

.PHONY: build
build: server client
