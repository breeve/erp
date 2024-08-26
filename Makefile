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
	--validate_out=. --validate_opt=module=github.com/breeve/erp --validate_opt=lang=go \
    $(shell find ./pkg/pb -iname "*.proto" -not -path "./pkg/pb/third_party*")

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


#  2026  go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
#  2028  go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest
#  2029  go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest
#  2031  go install github.com/bufbuild/protoc-gen-validate@latest
#  2033  go install github.com/envoyproxy/protoc-gen-validate@latest
#  2016  go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
