//
//  XMLSysTimeQuery.m
//  ZTBaseProject
//
//  Created by 哈哈哈 on 16/9/11.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLSysTimeQuery.h"

@interface XMLSysTimeQuery ()

@property (nonatomic,strong) NSString               *systime;

@end

@implementation XMLSysTimeQuery

+(instancetype)shared{
    static id _sharedInstance=  nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc]init];
    });
    return _sharedInstance;
}

- (void)RequestWithSysTimeQueryBlocks:(SuccessBlocks)block{
    
    NSString *url = [XMLStoreService TRADEURL];
    
    UserInfoModel *user = [XMLStoreService currentUserModel];
    
    NSString *bodyString=  [NSString stringWithFormat:@"<?xml version='1.0' encoding='GBK' standalone='yes'?><MEBS_MOBILE><REQ name='sys_time_query'><U>%@</U><LAST_ID>0</LAST_ID><TD_CNT>0</TD_CNT><S_I>%@</S_I><CU_LG>0</CU_LG></REQ></MEBS_MOBILE>",user.account,[XMLStoreService RETCODE]];
    
    NSData *body = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"----<URL>:<%@>-----\n----<Body>:<%@>----\n",url,bodyString);

    [self.httpMgr POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithHeaders:@{@"text/xml":@"Content-Type",[NSString stringWithFormat:@"%ld",body.length]:@"Content-Length"} body:body];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSXMLParser *xmlparser = responseObject;
        [xmlparser setDelegate:self];
        [xmlparser parse];
        
        block(self.systime,self.code,self.message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        block(nil,@"-1",error.description);
        
    }];
}
- (void)RequestWithSysTimeQueryWithURL:(NSString *)url  Blocks:(SuccessBlocks)block{
    
    UserInfoModel *user = [XMLStoreService currentUserModel];
    
    NSString *bodyString=  [NSString stringWithFormat:@"<?xml version='1.0' encoding='GBK' standalone='yes'?><MEBS_MOBILE><REQ name='sys_time_query'><U>%@</U><LAST_ID>0</LAST_ID><TD_CNT>0</TD_CNT><S_I>%@</S_I><CU_LG>0</CU_LG></REQ></MEBS_MOBILE>",user.account,[XMLStoreService RETCODE]];
    
    NSData *body = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    [self.httpMgr POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithHeaders:@{@"text/xml":@"Content-Type",[NSString stringWithFormat:@"%ld",body.length]:@"Content-Length"} body:body];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSXMLParser *xmlparser = responseObject;
        [xmlparser setDelegate:self];
        [xmlparser parse];
        
        block(self.systime,self.code,self.message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        block(nil,@"-1",error.description);
        
    }];
}



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
    [super parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
{
    [super parser:parser foundCharacters:string];
    if ([self.currentElementName isEqualToString:@"TV_U"]) {
        self.systime = string;
    }
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
    [super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    
    
}


@end
