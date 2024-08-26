.PHONY: generate_go
# gen xxx.proto to xxx.go
generate_go:
	$(info ******************** generate_go ********************)
	protoc \
	-I ./pkg/pb \
	-I ./pkg/pb/third_party \
	--go_out=./pkg --go_opt=module=github.com/breeve/erp \
	--go-grpc_out=./pkg --go-grpc_opt=module=github.com/breeve/erp \
	--grpc-gateway_out=./pkg --grpc-gateway_opt=module=github.com/breeve/erp \
    $(shell find ./pkg/pb -iname "*.proto" -not -path "./pkg/pb/third_party*")

# --validate_out=. --validate_opt=module=github.com/breeve/erp --validate_opt=lang=go \

# .PHONY: generate_openapi
# # gen xxx.proto to openapi
# generate_openapi:
# 	$(info ******************** generate_openapi ********************)
# 	for i in $$(find ./pb -iname "*.proto" -not -path "./pb/third_party*"); do \
# 		filename=$$(basename $$i .proto); \
# 		dirname=$$(dirname $$i); \
# 		protoc -I ./pb -I ./pb/third_party --openapi_out=$$dirname --openapi_opt=naming=proto $$i; \
# 		mv $$dirname/openapi.yaml $$dirname/$$filename.openapi.yaml; \
# 		cp $$dirname/$$filename.openapi.yaml docs/apis/; \
# 	done


# "github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
# "github.com/grpc-ecosystem/grpc-gateway/v2/utilities"

.PHONY: pb
# 使用 make docker_pb，不要直接 make pb，确保生成代码的一致
pb: generate_go

.PHONY: server
server:
	go build -o build/server cmd/server/server.go

.PHONY: client
client:
	go build -o build/client cmd/client/client.go

.PHONY: build
build: server client
