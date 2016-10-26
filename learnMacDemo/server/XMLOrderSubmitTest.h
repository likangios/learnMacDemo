//
//  XMLOrderSubmitTest.h
//  ZTBaseProject
//
//  Created by FengLing on 16/10/11.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLRequestBase.h"

@interface XMLOrderSubmitTest : XMLRequestBase

- (void)RequestWithBuy_Sell:(NSString *)buy_sell commodityID:(NSString *)commodityid Price:(NSString *)price  Amount:(NSString *)amount Blocks:(SuccessBlocks)block;


@end
