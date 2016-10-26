//
//  XMLRequestBase.h
//  ZTBaseProject
//
//  Created by FengLing on 16/8/27.
//  Copyright © 2016年 lk. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "XMLStoreService.h"
#import "UserInfoModel.h"

#define DEVICEID   @"iE816009A-1483-4252-8EE1-6B6C02ABFC3E"

typedef void(^SuccessBlocks)(id obj , NSString *code , NSString *message);

@interface XMLRequestBase : NSObject<NSXMLParserDelegate>
{
    NSMutableString *mstrXMLString;  //用于存储元素标签的值
//    NSString *currentElementName;   //当前elementName

}
@property (nonatomic,strong) NSString               *currentElementName;

@property (nonatomic,strong) AFHTTPSessionManager               *httpMgr;

@property (nonatomic,strong) NSString               *code;

@property (nonatomic,strong) NSString               *message;

+(instancetype)shared;

@end
