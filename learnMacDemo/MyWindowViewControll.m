//
//  MyWindowViewControll.m
//  learnMacDemo
//
//  Created by FengLing on 16/10/20.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "MyWindowViewControll.h"
#import "XMLLogin.h"

@interface testModel : JSONModel

@property (nonatomic,strong) NSString               *message;

@property (nonatomic,strong) NSString               *status;

@end
@implementation testModel

@end



@interface MyWindowViewControll ()

@property (nonatomic,weak) IBOutlet  NSTextField                   *phone;

@property (nonatomic,weak) IBOutlet  NSTextField                   *pwd;

@end

@implementation MyWindowViewControll


- (IBAction)buttonClick:(id)sender{
    
    [[XMLLogin shared] RequestWithPhone:self.phone AndPassword:self.pwd Blocks:^(id obj, NSString *code, NSString *message) {
        
    }];
}

@end
