//
//  XMLOrderSubmitTest.m
//  ZTBaseProject
//
//  Created by FengLing on 16/10/11.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLOrderSubmitTest.h"
#import "ResultOrder_SubmitModel.h"

@interface XMLOrderSubmitTest ()

@property (nonatomic,strong) ResultOrder_SubmitModel               *resultModel;

@end

@implementation XMLOrderSubmitTest

+(instancetype)shared{
    static id _sharedInstance=  nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc]init];
    });
    return _sharedInstance;
}

- (void)RequestWithBuy_Sell:(NSString *)buy_sell commodityID:(NSString *)commodityid Price:(NSString *)price  Amount:(NSString *)amount Blocks:(SuccessBlocks)block{
    
    NSString *url = [XMLStoreService TRADEURL];
    
    
    NSString *bodyString=  [NSString stringWithFormat:@"<?xml version='1.0' encoding='GBK' standalone='yes'?><MEBS_MOBILE><REQ name='order_submit'><U>cn12345324</U><BUY_SELL>1</BUY_SELL><COMMODITY_ID>602003</COMMODITY_ID><PRICE>1</PRICE><QTY>1</QTY><S_I>34567898675676808</S_I></REQ></MEBS_MOBILE>"];
    
    NSData *body = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"----<URL>:<%@>-----\n----<Body>:<%@>----\n",url,bodyString);

    [self.httpMgr POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithHeaders:@{@"text/xml":@"Content-Type",[NSString stringWithFormat:@"%ld",body.length]:@"Content-Length"} body:body];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSXMLParser *xmlparser = responseObject;
        [xmlparser setDelegate:self];
        [xmlparser parse];
        
        block(self.resultModel,self.code,self.message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        block(nil,@"-1",error.description);
        
    }];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
    [super parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
    
    if ([elementName isEqualToString:@"RESULT"]) {
        _resultModel = [[ResultOrder_SubmitModel alloc]init];
        
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
{
    [super parser:parser foundCharacters:string];
    
    if ([self.currentElementName isEqualToString:@"RETCODE"]) {
        _resultModel.resutl = string;
    }
    if ([self.currentElementName isEqualToString:@"MESSAGE"]) {
        _resultModel.message = string;
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
    [super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    
    
}


@end
