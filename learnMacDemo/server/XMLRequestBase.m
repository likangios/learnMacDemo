//
//  XMLRequestBase.m
//  ZTBaseProject
//
//  Created by FengLing on 16/8/27.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLRequestBase.h"

@interface XMLRequestBase ()


@end

@implementation XMLRequestBase

+(instancetype)shared{
    
    static id _sharedInstance=  nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc]init];
    });
    return _sharedInstance;
}
- (AFHTTPSessionManager *)httpMgr{
    if (!_httpMgr) {
        _httpMgr =[AFHTTPSessionManager manager];
        _httpMgr.requestSerializer=  [AFHTTPRequestSerializer serializer];
        _httpMgr.responseSerializer = [AFXMLParserResponseSerializer serializer];
        AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
        
        [securityPolicy setAllowInvalidCertificates:YES];
        
        [_httpMgr setSecurityPolicy:securityPolicy];
        
        _httpMgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml", nil];
    }
    return _httpMgr;
}
- (void)testRequest:(void(^)(id obj,NSError *error ))block{
    
    NSString *url =  @"";
    NSString *bodyString=  @"";
    NSData *body = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    [self.httpMgr POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    [formData appendPartWithHeaders:@{@"text/xml":@"Content-Type",[NSString stringWithFormat:@"%ld",body.length]:@"Content-Length"} body:body];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
    self.currentElementName = elementName;
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
{
    
    if ([self.currentElementName isEqualToString:@"RETCODE"]) {
        self.code = string;
    }
    
    if ([self.currentElementName isEqualToString:@"MESSAGE"]) {
        self.message = string;
    }
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{

    mstrXMLString = nil;
    self.currentElementName = nil;
    
}

@end
