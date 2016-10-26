//
//  XMLEncryptStr.h
//  ZTBaseProject
//
//  Created by FengLing on 16/8/30.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLRequestBase.h"

@interface XMLEncryptStr : XMLRequestBase
- (void)RequestWithName:(NSString *)name AndPassword:(NSString *)password MarkID:(NSString *)markId Blocks:(SuccessBlocks)block;
@end
