//
//  XMLStoreService.m
//  ZTBaseProject
//
//  Created by FengLing on 16/8/29.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLStoreService.h"
#import "UserInfoModel.h"

static UserInfoModel *currentModel;

@implementation XMLStoreService
+(instancetype)shared{
    static id _sharedInstance=  nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc]init];
    });
    return _sharedInstance;
}
+ (NSString *)PINSCODE{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *pinscode = [def objectForKey:@"PINSCODE"];
    
    return pinscode?:@"";
}

+ (void)StorePINSCODE:(NSString *)pinscode{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:pinscode forKey:@"PINSCODE"];
    [def  synchronize];
}

+ (NSString *)RETCODE{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *obj = [def objectForKey:@"RETCODE"];
    return obj?:@"";
}
+ (void)StoreRETCODE:(NSString *)string{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:string forKey:@"RETCODE"];
    [def  synchronize];
}


+ (NSString *)SESSIONID{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *obj = [def objectForKey:@"SESSIONID"];
    return obj?:@"";
}
+ (void)StoreSESSIONID:(NSString *)string{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:string forKey:@"SESSIONID"];
    [def  synchronize];
}
+ (NSString *)ENCRYPTION{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *obj = [def objectForKey:@"ENCRYPTION"];
    return obj?:@"";
}
+ (void)StoreENCRYPTION:(NSString *)string{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:string forKey:@"ENCRYPTION"];
    [def  synchronize];
}

+ (NSString *)RANDOM_KEY{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *obj = [def objectForKey:@"RANDOM_KEY"];
    return obj?:@"";
}
+ (void)StoreRANDOM_KEY:(NSString *)string{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:string forKey:@"RANDOM_KEY"];
    [def  synchronize];
}

+ (NSString *)TRADEURL{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *obj = [def objectForKey:@"TRADEURL"];
    return obj?:@"";
}
+ (void)StoreTRADEURL:(NSString *)string{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:string forKey:@"TRADEURL"];
    [def  synchronize];
}




+ (NSString *)phone{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *obj = [def objectForKey:@"phone"];
    return obj?:@"";
}
+ (void)Storephone:(NSString *)string{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:string forKey:@"phone"];
    [def  synchronize];
}

+ (NSString *)password{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *obj = [def objectForKey:@"password"];
    return obj?:@"";
}
+ (void)Storepassword:(NSString *)string{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:string forKey:@"password"];
    [def  synchronize];
}
+ (NSString *)markId{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *obj = [def objectForKey:@"markId"];
    return obj?:@"";
}
+ (void)StoremarkId:(NSString *)string{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:string forKey:@"markId"];
    [def  synchronize];
}

+ (NSString *)getAccountWithMarkId:(NSString *)markId{
    return nil;
}

+ (void)storeAllAccoutWithMarkId:(NSString *)markId  Account:(NSString *)account PWD:(NSString *)password{
    NSDictionary *dic = @{@"":account,@"password":password};
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:dic forKey:markId];
    [def  synchronize];
}
+ (BOOL)isHasUserInfoWithAccount:(NSString *)account FromArray:(NSArray *)originArray{
    
    UserInfoModel *model = [XMLStoreService searchUserInfoWithAccount:account FromArray:originArray];
    if (model) {
    return YES  ;
    }
    return NO;
    
}
+ (UserInfoModel *)searchUserInfoWithAccount:(NSString *)account FromArray:(NSArray *)originArray{

    for (UserInfoModel *obj in originArray) {
        if ([obj.account isEqualToString:account]) {
            return obj;
            break;
        }
    }
    return nil;
    
}
+ (void)storeUserInfos:(UserInfoModel *)userinfo WithMarkId:(NSString *)markId{
    
    NSArray *accounts = [XMLStoreService userinfosWithMarkId:markId];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:accounts];
    
    UserInfoModel *searchModle = [XMLStoreService searchUserInfoWithAccount:userinfo.account FromArray:accounts];
    if (searchModle) {
        [array removeObject:searchModle];
    }
    [array insertObject:userinfo atIndex:0];
    
    [self storeUserInfosArray:array WithMarkId:markId];
}
+(void)storeUserInfosArray:(NSArray *)accounts WithMarkId:(NSString *)markId{
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:accounts];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:encodedObject forKey:markId];
    
    [userDefault synchronize];
}
+ (NSArray *)getTradeUrlsWithMarkId:(NSString *)markId{
   
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    
    NSString *key = [NSString stringWithFormat:@"TRADEURL_%@",markId];
    
    NSData *encodedObject = [defau objectForKey:key];
    
    id  obj  = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    if (obj) {
        return  obj;
    }
    return nil;
}
+(void)storeTradeUrls:(NSArray *)array WithMarkId:(NSString *)markId{
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:array];
    
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    
    NSString *key = [NSString stringWithFormat:@"TRADEURL_%@",markId];
    
    [defau setObject:encodedObject forKey:key];
    
    [defau synchronize];
}

+(NSArray *)userinfosWithMarkId:(NSString *)markId{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [userDefault objectForKey:markId];
    
    id  obj  = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    if ([obj isKindOfClass:[UserInfoModel class]]) {
        return @[obj];
    }
    return obj;
    
}
//
+ (void)storeUserInfo:(UserInfoModel *)userinfo WithMarkId:(NSString *)markId{

    [XMLStoreService storeUserInfos:userinfo WithMarkId:markId];
    
    currentModel = userinfo;
}
+ (UserInfoModel *)currentUserModel{
    
    return currentModel;
    
}
+ (UserInfoModel *)userinfoWithMarkId:(NSString *)markId{
    NSArray *users =[XMLStoreService userinfosWithMarkId:markId];
    if (users.count) {
        return users[0];
    }
    return nil;
}

+ (NSString *)userdefaultValueWithKey:(NSString *)key{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *obj = [def objectForKey:key];
    return obj?:@"";
}
+ (void)StoredefaultValue:(NSString *)string Key:(NSString *)key{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:string forKey:key];
    [def  synchronize];
}
/*
+(void)testStoreWithKeyChain:(NSString *)name password:(NSString *)password{
    [XMLStoreService testStoreWithKeyChain:name password:password AccessGroup:@"account"];
}
+(void)testStoreWithKeyChain:(NSString *)name password:(NSString *)password AccessGroup:(NSString *)accessGroup{
    
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"com.luck" accessGroup:accessGroup];
    keychain[name] = password;
}
+ (NSArray *)testGetAllItem{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"com.luck"];
    return  keychain.allItems;
}
+ (NSArray *)testGetAllItemWithAccountGoup:(NSString *)accessGroup{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"com.luck" accessGroup:accessGroup];
    return  keychain.allItems;
}
*/
@end
