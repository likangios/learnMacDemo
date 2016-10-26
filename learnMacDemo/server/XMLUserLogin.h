//
//  XMLUserLogin.h
//  ZTBaseProject
//
//  Created by FengLing on 16/8/30.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLRequestBase.h"

@interface XMLUserLogin : XMLRequestBase
- (void)RequestWithName:(NSString *)name AndPassword:(NSString *)password Blocks:(SuccessBlocks)block;
@end
