//
//  LoginViewController.m
//  learnMacDemo
//
//  Created by FengLing on 16/10/26.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "LoginViewController.h"
#import "XMLLogin.h"
#import "MarkViewController.h"


@interface LoginViewController ()

@property (nonatomic,weak) IBOutlet  NSTextField                   *phone;

@property (nonatomic,weak) IBOutlet  NSTextField                   *pwd;

@property (nonatomic,strong) MarkViewController               *mark;

@property (nonatomic,assign) BOOL             loginSuccess;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
- (MarkViewController *)mark{
    if (!_mark) {
        _mark = [[MarkViewController alloc]init];
    }
    return _mark;
}
- (IBAction)buttonClick:(id)sender{
    
    [[XMLLogin shared] RequestWithPhone:self.phone.accessibilityValue AndPassword:self.pwd.accessibilityValue Blocks:^(id obj, NSString *code, NSString *message) {
        
        if ([code isEqualToString:@"0"]) {
            self.loginSuccess = YES;
        }else{
            self.loginSuccess = NO;
        }
        
        [self presentViewControllerAsModalWindow:self.mark];
    
    }];
    
}
@end
