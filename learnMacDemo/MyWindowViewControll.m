//
//  MyWindowViewControll.m
//  learnMacDemo
//
//  Created by FengLing on 16/10/20.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "MyWindowViewControll.h"
#import "XMLLogin.h"
#import "MarkViewController.h"



@interface MyWindowViewControll ()

@property (nonatomic,weak) IBOutlet  NSTextField                   *phone;

@property (nonatomic,weak) IBOutlet  NSTextField                   *pwd;

@property (nonatomic,strong) MarkViewController               *mark;
@end

@implementation MyWindowViewControll


- (MarkViewController *)mark{
    if (!_mark) {
        _mark = [[MarkViewController alloc]init];
    }
    return _mark;
}
- (IBAction)buttonClick:(id)sender{
    
    [[XMLLogin shared] RequestWithPhone:self.phone.accessibilityCriticalValue AndPassword:self.pwd.accessibilityCriticalValue Blocks:^(id obj, NSString *code, NSString *message) {
        self.contentViewController = self.mark;
    }];
}

@end
