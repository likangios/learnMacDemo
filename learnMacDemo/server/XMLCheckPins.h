//
//  XMLCheckPins.h
//  ZTBaseProject
//
//  Created by FengLing on 16/8/29.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLRequestBase.h"

@interface XMLCheckPins : XMLRequestBase

- (void)RequestWithPinscode:(NSString *)pinscode Blocks:(SuccessBlocks)block;

@end
