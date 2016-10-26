//
//  XMLOrderSubmit.m
//  ZTBaseProject
//
//  Created by FengLing on 16/8/30.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLOrderSubmit.h"
#import "ResultOrder_SubmitModel.h"
@interface XMLOrderSubmit ()

@property (nonatomic,strong) ResultOrder_SubmitModel               *resultModel;


@end

@implementation XMLOrderSubmit


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

    UserInfoModel *user = [XMLStoreService currentUserModel];
    
    NSString *bodyString=  [NSString stringWithFormat:@"<?xml version='1.0' encoding='GBK' standalone='yes'?><MEBS_MOBILE><REQ name='order_submit'><U>%@</U><BUY_SELL>%@</BUY_SELL><COMMODITY_ID>%@</COMMODITY_ID><PRICE>%@</PRICE><QTY>%@</QTY><S_I>%@</S_I></REQ></MEBS_MOBILE>",user.account,buy_sell,commodityid,price,amount,[XMLStoreService RETCODE]];
    
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
