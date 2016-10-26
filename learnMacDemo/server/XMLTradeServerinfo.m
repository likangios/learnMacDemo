//
//  XMLTradeServerinfo.m
//  ZTBaseProject
//
//  Created by FengLing on 16/9/1.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLTradeServerinfo.h"
#import "TradModel.h"

@interface XMLTradeServerinfo ()

@property (nonatomic,strong) NSMutableArray                *tradeUrlArray;

@property (nonatomic,strong) TradModel               *tradmodel;
@end

@implementation XMLTradeServerinfo
+(instancetype)shared{
    static id _sharedInstance=  nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc]init];
    });
    return _sharedInstance;
}

- (void)RequestBlocks:(SuccessBlocks)block{
    
    NSString *url = @"http://m.zongyihui.cn:30200/nuclear/communicateServlet";
    
    NSString *markId = [XMLStoreService markId];

    NSString *bodyString=  [NSString stringWithFormat:@"<?xml version='1.0' encoding='GBK' standalone='yes'?><MEBS_MOBILE><REQ name='tradeserverinfo'><PINSCODE>%@</PINSCODE><SESSIONID>%@</SESSIONID><MARKETID>%@</MARKETID><TRADEMODELID>1</TRADEMODELID></REQ></MEBS_MOBILE>",[XMLStoreService PINSCODE],[XMLStoreService SESSIONID],markId];
    
    NSLog(@"----<URL>:<%@>-----\n----<Body>:<%@>----\n",url,bodyString);
    
    NSData *body = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    [self.httpMgr POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithHeaders:@{@"text/xml":@"Content-Type",[NSString stringWithFormat:@"%ld",body.length]:@"Content-Length"} body:body];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSXMLParser *xmlparser = responseObject;
        [xmlparser setDelegate:self];
        [xmlparser parse];
        
        block(self.tradeUrlArray,self.code,self.message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        block(nil,@"-1",error.description);
        
    }];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
    [super parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
    if ([self.currentElementName isEqualToString:@"RESULTLIST"]) {
        _tradeUrlArray =[NSMutableArray array];
    }
    
    if ([self.currentElementName isEqualToString:@"REC"]) {
        _tradmodel = [[TradModel alloc]init];
    }
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
{
    [super parser:parser foundCharacters:string];
    
    if ([self.currentElementName isEqualToString:@"TRADEURL"]) {
        if (string.length) {
            [XMLStoreService StoreTRADEURL:string];
        }
    }
    if ([self.currentElementName isEqualToString:@"TRADENAME"]) {
        if (string.length) {
            _tradmodel.TradeName = string;
        }
    }
    if ([self.currentElementName isEqualToString:@"TRADEURL"]) {
        if (string.length) {
            _tradmodel.TradeUrl = string;
        }
    }

    
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
    [super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    
    if ([elementName isEqualToString:@"REC"]) {
        
        [_tradeUrlArray addObject:_tradmodel];
        
        _tradmodel = nil;
    }
    
}

@end
