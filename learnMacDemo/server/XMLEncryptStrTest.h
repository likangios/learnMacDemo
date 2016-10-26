//
//  XMLEncryptStrTest.h
//  ZTBaseProject
//
//  Created by FengLing on 16/10/11.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLRequestBase.h"

@interface XMLEncryptStrTest : XMLRequestBase
- (void)RequestWithName:(NSString *)name AndPassword:(NSString *)password MarkID:(NSString *)markId Blocks:(SuccessBlocks)block;

@end
