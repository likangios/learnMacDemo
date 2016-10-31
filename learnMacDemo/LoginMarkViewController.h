//
//  LoginMarkViewController.h
//  learnMacDemo
//
//  Created by FengLing on 16/10/31.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LoginMarkViewController : NSViewController

@property (nonatomic,strong) NSString               *markId;
- (IBAction)cancelClick:(id)sender;
- (IBAction)confirmClick:(id)sender;

@end
