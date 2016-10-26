//
//  XMLLogin.h
//  ZTBaseProject
//
//  Created by FengLing on 16/8/27.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLRequestBase.h"

@interface XMLLogin : XMLRequestBase

- (void)RequestWithPhone:(NSString *)phone AndPassword:(NSString *)pwd Blocks:(SuccessBlocks)block;

@end
