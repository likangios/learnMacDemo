//
//  XMLQueryCommodity.m
//  ZTBaseProject
//
//  Created by FengLing on 16/9/27.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLQueryCommodity.h"
#import "CommodityModel.h"

@interface XMLQueryCommodity ()

@property (nonatomic,strong) NSMutableArray               *queryCommodityArray;

@property (nonatomic,strong)  CommodityModel             *commodityObj;

@end

@implementation XMLQueryCommodity

+(instancetype)shared{
    static id _sharedInstance=  nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc]init];
    });
    return _sharedInstance;
}

- (void)RequestQueryCommoditysBlocks:(SuccessBlocks)block{
    
    NSString *url = [XMLStoreService TRADEURL];
    
    UserInfoModel *user = [XMLStoreService currentUserModel];
    
    NSString *bodyString=  [NSString stringWithFormat:@"<?xml version='1.0' encoding='GBK' standalone='yes'?><MEBS_MOBILE><REQ name='query_commodity'><U>%@</U><COMMODITY_ID></COMMODITY_ID><S_I>%@</S_I></REQ></MEBS_MOBILE>",user.account,[XMLStoreService RETCODE]];
    
    NSData *body = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"----<URL>:<%@>-----\n----<Body>:<%@>----\n",url,bodyString);
    
    [self.httpMgr POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithHeaders:@{@"text/xml":@"Content-Type",[NSString stringWithFormat:@"%ld",body.length]:@"Content-Length"} body:body];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSXMLParser *xmlparser = responseObject;
        [xmlparser setDelegate:self];
        [xmlparser parse];
        
        block(self.queryCommodityArray,self.code,self.message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        block(nil,@"-1",error.description);
        
    }];
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
    [super parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
    
    if ([elementName isEqualToString:@"RESULTLIST"]) {
        _queryCommodityArray = [NSMutableArray array];
    }
    if ([elementName isEqualToString:@"REC"]) {
        _commodityObj = [[CommodityModel alloc]init];
    }
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
{
    [super parser:parser foundCharacters:string];
    
    if ([self.currentElementName isEqualToString:@"SP_U"]) {

        self.commodityObj.maxPrice = string;
    }
    if ([self.currentElementName isEqualToString:@"SP_D"]) {
        self.commodityObj.minPrice = string;
        
    }
    if ([self.currentElementName isEqualToString:@"PR_C"]) {
        self.commodityObj.currentPrice = string;
        
    }
    if ([self.currentElementName isEqualToString:@"CO_I"]) {
        self.commodityObj.code = string;
        
    }
    if ([self.currentElementName isEqualToString:@"CO_N"]) {
        self.commodityObj.name = string;
        
    }
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
    [super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];

    if ([elementName isEqualToString:@"REC"]) {
        
        [_queryCommodityArray addObject:self.commodityObj];
        
        self.commodityObj = nil;
    
    }
    
}
@end
