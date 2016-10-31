//
//  LoginMarkViewController.m
//  learnMacDemo
//
//  Created by FengLing on 16/10/31.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "LoginMarkViewController.h"
#import "MainViewController.h"
#import "UserInfoModel.h"
#import "XMLStoreService.h"
#import "XMLLogin.h"

#import "XMLEncryptStr.h"
#import "XMLUserLogin.h"

@interface LoginMarkViewController ()<NSComboBoxDataSource,NSComboBoxDelegate>

@property (nonatomic,weak) IBOutlet  NSComboBox                   *phone;

@property (nonatomic,weak) IBOutlet  NSSecureTextField                   *pwd;

@property (nonatomic,strong) NSArray               *accounts;

@end

@implementation LoginMarkViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    _accounts = [XMLStoreService userinfosWithMarkId:self.markId];
    if (_accounts.count) {
        UserInfoModel *model = _accounts[0];
        self.phone.stringValue = model.account;
        self.pwd.stringValue = model.password;
    }
}
- (IBAction)cancelClick:(id)sender{
    [self dismissController:self];
}
- (IBAction)confirmClick:(id)sender{
    
    UserInfoModel *model = [[UserInfoModel alloc]init];
    
    model.account = self.phone.stringValue;
    
    model.password = self.pwd.stringValue;
    
    model.markId = self.markId;
    
    [XMLStoreService storeUserInfo:model WithMarkId:[NSString stringWithFormat:@"%ld",(long)self.markId]];
    
//    [ZTUntil showHUDAddedTo:self.view];
    
    [[XMLEncryptStr shared] RequestWithName:self.phone.stringValue AndPassword:self.pwd.stringValue MarkID:self.markId Blocks:^(id obj, NSString *code, NSString *message) {
        NSLog(@"code:%@ message:%@",code,message);

        if ([code isEqualToString:@"0"]) {
            
            [[XMLUserLogin shared] RequestWithName:self.phone.stringValue AndPassword:self.pwd.stringValue Blocks:^(id obj, NSString *code, NSString *message) {
//                [ZTUntil hideAllHUDsForView:self.view];
                NSLog(@"code:%@ message:%@",code,message);
                if (code) {
                    MainViewController *main = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
                    [self dismissController:self];
                    [[[NSApplication sharedApplication] keyWindow] setContentViewController:main];

//                    [ZTUntil showErrorHUDViewAtView:self.view WithTitle:@"OK"];
                }else{
//                    [ZTUntil showErrorHUDViewAtView:self.view WithTitle:message];
                }
                
            }];
            
        }else{
//            [ZTUntil hideAllHUDsForView:self.view];
            
//            [ZTUntil showErrorHUDViewAtView:self.view WithTitle:message];
        }
    }];
    
    
    

}
#pragma mark NSComBoxDelegate 

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)comboBox{
    return _accounts.count;
}
- (nullable id)comboBox:(NSComboBox *)comboBox objectValueForItemAtIndex:(NSInteger)index{
    UserInfoModel *model = _accounts[index];
    return model.account;
}
- (void)comboBoxSelectionDidChange:(NSNotification *)notification{
    [self updateAccount];
}
- (void)updateAccount{
    
    UserInfoModel *model = _accounts[self.phone.selectedTag];
    
    self.pwd.stringValue = model.password;
}
@end
