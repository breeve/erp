package service

import (
	"context"

	"github.com/breeve/erp/pkg/apis/pb"
	"google.golang.org/protobuf/types/known/emptypb"
)

type MarketService struct {
	pb.UnimplementedMarketServiceServer
}

func (s *MarketService) Echo(context.Context, *emptypb.Empty) (*pb.Hello, error) {
	return nil, nil
}
