//
//  XMLSysTimeQuery.h
//  ZTBaseProject
//
//  Created by 哈哈哈 on 16/9/11.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLRequestBase.h"

@interface XMLSysTimeQuery : XMLRequestBase

- (void)RequestWithSysTimeQueryBlocks:(SuccessBlocks)block;

- (void)RequestWithSysTimeQueryWithURL:(NSString *)url  Blocks:(SuccessBlocks)block;

@end
