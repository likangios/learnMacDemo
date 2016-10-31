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
#import "AppModel.h"


@interface LoginViewController ()<NSComboBoxDelegate,NSComboBoxDataSource>

@property (nonatomic,weak) IBOutlet  NSComboBox                   *phone;

@property (nonatomic,weak) IBOutlet  NSSecureTextField                   *pwd;

@property (nonatomic,strong) MarkViewController               *mark;

@property (nonatomic,strong) NSArray               *accounts;
@end

@implementation LoginViewController

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)comboBox{
    return _accounts.count;
}
- (nullable id)comboBox:(NSComboBox *)comboBox objectValueForItemAtIndex:(NSInteger)index{
    AppModel *model = _accounts[index];
    return model.account;
}
- (void)comboBoxSelectionDidChange:(NSNotification *)notification{
    [self updateAccount];
}
- (void)updateAccount{
    
    AppModel *model = _accounts[self.phone.selectedTag];
    self.pwd.stringValue = model.password;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _accounts = [XMLStoreService getAppAccounts];
    if (_accounts.count) {
        AppModel *model = _accounts[0];
        self.phone.stringValue = model.account;
        self.pwd.stringValue = model.password;
    }
    
}
- (MarkViewController *)mark{
    if (!_mark) {
        _mark = [[MarkViewController alloc]init];
    }
    return _mark;
}
- (IBAction)buttonClick:(id)sender{
    
    [[XMLLogin shared] RequestWithPhone:self.phone.stringValue AndPassword:self.pwd.stringValue Blocks:^(id obj, NSString *code, NSString *message) {
        
        if ([code isEqualToString:@"0"]) {
            AppModel *obj = [[AppModel alloc]init];
            obj.account = self.phone.stringValue;
            obj.password = self.pwd.stringValue;
            [XMLStoreService StoreAppAccount:obj];
            
            [[[NSApplication sharedApplication] keyWindow] setContentViewController:self.mark];
        }else{
            
        }

    }];
    
}
- (void)animatePresentationOfViewController:(NSViewController *)viewController fromViewController:(NSViewController *)fromViewController{
    
    [self.view.window close];
}
@end
