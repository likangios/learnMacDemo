//
//  XMLOrderSubmit.h
//  ZTBaseProject
//
//  Created by FengLing on 16/8/30.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "XMLRequestBase.h"

@interface XMLOrderSubmit : XMLRequestBase

- (void)RequestWithBuy_Sell:(NSString *)buy_sell commodityID:(NSString *)commodityid Price:(NSString *)price  Amount:(NSString *)amount Blocks:(SuccessBlocks)block;


@end
