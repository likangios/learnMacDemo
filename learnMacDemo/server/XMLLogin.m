//
//  XMLLogin.m
//  ZTBaseProject
//
//  Created by FengLing on 16/8/27.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLLogin.h"

@implementation XMLLogin

+(instancetype)shared{
    static id _sharedInstance=  nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc]init];
    });
    return _sharedInstance;
}
- (void)RequestWithPhone:(NSString *)phone AndPassword:(NSString *)pwd Blocks:(SuccessBlocks)block{
    
    NSString *url =  @"http://m.zongyihui.cn:30200/nuclear/communicateServlet";
    
    NSString *bodyString=  [NSString stringWithFormat:@"<?xml version='1.0' encoding='GBK' standalone='yes'?><MEBS_MOBILE><REQ name='logon'><USERID>%@</USERID><PASSWORD>%@</PASSWORD><LOGONWAY>2</LOGONWAY><LOGONTYPE>2</LOGONTYPE><DEVICEID>%@</DEVICEID><MARKETID>-1</MARKETID></REQ></MEBS_MOBILE>",phone,pwd,DEVICEID];
    
    /*
     <?xml version='1.0' encoding='GBK' standalone='yes'?><MEBS_MOBILE><REQ name='logon'><USERID>13675158507</USERID><PASSWORD>123456</PASSWORD><LOGONWAY>2</LOGONWAY><LOGONTYPE>2</LOGONTYPE><DEVICEID>iE816009A-1483-4252-8EE1-6B6C02ABFC3E</DEVICEID><MARKETID>-1</MARKETID></REQ></MEBS_MOBILE>
     */
    
    NSData *body = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"----<URL>:<%@>-----\n----<Body>:<%@>----\n",url,bodyString);

    [self.httpMgr POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithHeaders:@{@"text/xml":@"Content-Type",[NSString stringWithFormat:@"%ld",body.length]:@"Content-Length"} body:body];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSXMLParser *xmlparser = responseObject;
        [xmlparser setDelegate:self];
        [xmlparser parse];
        
        block(nil,self.code,self.message);
        
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
    
    if ([self.currentElementName isEqualToString:@"RETCODE"]) {
        
        if (string.length>10) {
            [XMLStoreService StoreRETCODE:string];
            [XMLStoreService StoreSESSIONID:string];

            self.code = @"0";
        }else{
            self.code = @"-1";
        }
        
        
    }
    if ([self.currentElementName isEqualToString:@"PINSCODE"]) {
        
        [XMLStoreService StorePINSCODE:string];
        
    }
    
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
    [super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    
}
@end
