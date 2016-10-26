//
//  CommodityModel.h
//  ZTBaseProject
//
//  Created by FengLing on 16/9/27.
//  Copyright © 2016年 lk. All rights reserved.
//

/*
 <SP_U>1082.6</SP_U>
 <SP_D>885.8</SP_D>
 <PR_C>984.2</PR_C>
 CO_N  name
 */
@interface CommodityModel : JSONModel

@property (nonatomic,strong) NSString               *code;

@property (nonatomic,strong) NSString               *name;

@property (nonatomic,strong) NSString               *maxPrice;

@property (nonatomic,strong) NSString               *minPrice;

@property (nonatomic,strong) NSString               *currentPrice;
@end
