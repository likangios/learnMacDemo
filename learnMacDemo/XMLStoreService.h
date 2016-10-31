//
//  XMLStoreService.h
//  ZTBaseProject
//
//  Created by FengLing on 16/8/29.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <Foundation/Foundation.h>
//20160830135635378cn6565080014342093.22450170545
@class UserInfoModel;
@class AppModel;
@interface XMLStoreService : NSObject

+ (NSString *)PINSCODE;
+ (void)StorePINSCODE:(NSString *)pinscode;

+ (NSString *)RETCODE;
+ (void)StoreRETCODE:(NSString *)string;

+ (NSString *)SESSIONID;
+ (void)StoreSESSIONID:(NSString *)string;

+ (NSString *)ENCRYPTION;
+ (void)StoreENCRYPTION:(NSString *)string;

+ (NSString *)RANDOM_KEY;
+ (void)StoreRANDOM_KEY:(NSString *)string;


+ (NSString *)TRADEURL;
+ (void)StoreTRADEURL:(NSString *)string;

+ (NSString *)phone;
+ (void)Storephone:(NSString *)string;

+ (NSString *)password;
+ (void)Storepassword:(NSString *)string;

+ (NSArray *)getAppAccounts;

+ (void)StoreAppAccount:(AppModel *)account;


+ (NSString *)markId;
+ (void)StoremarkId:(NSString *)string;

+ (NSString *)getAccountWithMarkId:(NSString *)markId;

+ (void)storeAllAccoutWithMarkId:(NSString *)markId;

+ (UserInfoModel *)currentUserModel;
//单个账号
+ (void)storeUserInfo:(UserInfoModel *)userinfo WithMarkId:(NSString *)markId;

+ (UserInfoModel *)userinfoWithMarkId:(NSString *)markId;

//多个账户
+(NSArray *)userinfosWithMarkId:(NSString *)markId;


+ (NSString *)userdefaultValueWithKey:(NSString *)key;
+ (void)StoredefaultValue:(NSString *)string Key:(NSString *)key;

//server url

+ (NSArray *)getTradeUrlsWithMarkId:(NSString *)markId;
+(void)storeTradeUrls:(NSArray *)array WithMarkId:(NSString *)markId;

+(void)testStoreWithKeyChain:(NSString *)name password:(NSString *)password;
+(void)testStoreWithKeyChain:(NSString *)name password:(NSString *)password AccessGroup:(NSString *)accessGroup;
+ (NSArray *)testGetAllItem;
+ (NSArray *)testGetAllItemWithAccountGoup:(NSString *)accessGroup;

@end
