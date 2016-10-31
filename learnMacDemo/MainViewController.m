//
//  MainViewController.m
//  learnMacDemo
//
//  Created by FengLing on 16/10/28.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "MainViewController.h"


#import "CommodityModel.h"
#import "ResultOrder_SubmitModel.h"

#import "XMLSysTimeQuery.h"
#import "XMLQueryCommodity.h"
#import "XMLOrderSubmit.h"
#import "XMLEncryptStr.h"
#import "XMLUserLogin.h"
@interface MainViewController ()

{
    dispatch_queue_t queue;
}
@property (nonatomic,weak) IBOutlet  NSButton                   *updateButton;
@property (nonatomic,strong) NSMutableArray               *queryData;
@property (nonatomic,assign) NSTimeInterval             shijiancha;

@property (nonatomic,weak) IBOutlet NSTextFieldCell     *logoLabel1;

@property (nonatomic,weak) IBOutlet NSTextFieldCell     *logoLabel2;

@property (nonatomic,weak) IBOutlet NSTextFieldCell     *logoLabel3;

@property (nonatomic,weak) IBOutlet NSTextFieldCell     *logoLabel4;

@property (nonatomic,weak) IBOutlet NSTextFieldCell     *logoLabel5;

@property (nonatomic,weak) IBOutlet NSTextFieldCell     *shijianchaLabel;


@property (nonatomic,weak) IBOutlet  NSTextField                   *startTime;

@property (nonatomic,weak) IBOutlet  NSProgressIndicator                   *Activity1;
@property (nonatomic,weak) IBOutlet  NSProgressIndicator                   *Activity2;
@property (nonatomic,weak) IBOutlet  NSProgressIndicator                   *Activity3;
@property (nonatomic,weak) IBOutlet  NSProgressIndicator                   *Activity4;
@property (nonatomic,weak) IBOutlet  NSProgressIndicator                   *Activity5;

@property (nonatomic,weak) IBOutlet  NSButton                   *btn1;
@property (nonatomic,weak) IBOutlet  NSButton                   *btn2;
@property (nonatomic,weak) IBOutlet  NSButton                   *btn3;
@property (nonatomic,weak) IBOutlet  NSButton                   *btn4;
@property (nonatomic,weak) IBOutlet  NSButton                   *btn5;


@property (nonatomic,weak) IBOutlet  NSTextField                   *code1;
@property (nonatomic,weak) IBOutlet  NSTextField                   *code2;
@property (nonatomic,weak) IBOutlet  NSTextField                   *code3;
@property (nonatomic,weak) IBOutlet  NSTextField                   *code4;
@property (nonatomic,weak) IBOutlet  NSTextField                   *code5;


@property (nonatomic,weak) IBOutlet  NSTextField                   *price1;
@property (nonatomic,weak) IBOutlet  NSTextField                   *price2;
@property (nonatomic,weak) IBOutlet  NSTextField                   *price3;
@property (nonatomic,weak) IBOutlet  NSTextField                   *price4;
@property (nonatomic,weak) IBOutlet  NSTextField                   *price5;

@property (nonatomic,weak) IBOutlet  NSTextField                   *amount1;
@property (nonatomic,weak) IBOutlet  NSTextField                   *amount2;
@property (nonatomic,weak) IBOutlet  NSTextField                   *amount3;
@property (nonatomic,weak) IBOutlet  NSTextField                   *amount4;
@property (nonatomic,weak) IBOutlet  NSTextField                   *amount5;

@end

@implementation MainViewController

- (void)viewWillAppear{
    [super viewWillAppear];
    self.btn1.state = NSOffState;
    self.btn2.state = NSOffState;
    self.btn3.state = NSOffState;
    self.btn4.state = NSOffState;
    self.btn5.state = NSOffState;
}
- (void)getStoreDate{
    self.startTime.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.startTime"];
    
    self.code1.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.code1"];
    self.price1.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.price1"];
    self.amount1.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.amount1"];
    
    self.code2.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.code2"];
    self.price2.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.price2"];
    self.amount2.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.amount2"];
    
    self.code3.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.code3"];
    self.price3.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.price3"];
    self.amount3.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.amount3"];
    
    self.code4.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.code4"];
    self.price4.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.price4"];
    self.amount4.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.amount4"];
    
    self.code5.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.code5"];
    self.price5.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.price5"];
    self.amount5.stringValue = [XMLStoreService userdefaultValueWithKey:@"self.amount5"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self  getStoreDate];
    NSLog(@"state %ld",self.btn1.state);
    NSTimeInterval  start  =  CACurrentMediaTime();
//    时间同步
    [[XMLSysTimeQuery shared] RequestWithSysTimeQueryBlocks:^(NSString *systime, NSString *code, NSString *message) {
        NSTimeInterval end = CACurrentMediaTime();
        NSDate *now = [NSDate date];
        NSTimeInterval requestTime = 1000/2.0*(end-start);
        self.shijiancha = now.timeIntervalSince1970*1000 - systime.doubleValue + requestTime;
        self.shijianchaLabel.stringValue = [NSString stringWithFormat:@"%.f+%.fms",self.shijiancha-requestTime,requestTime];
        NSLog(@"origin %.f   requestTime %.f ",self.shijiancha-requestTime,requestTime);
    }];

    
//    行情
    [[XMLQueryCommodity shared] RequestQueryCommoditysBlocks:^(id obj, NSString *code, NSString *message) {
        
        if ([code isEqualToString:@"0"]) {
            self.updateButton.enabled = YES;
            
            _queryData = [NSMutableArray arrayWithArray:obj];
            
        }else{
            self.updateButton.enabled = NO;
            
//            [ZTUntil showErrorHUDViewAtView:self.view WithTitle:message];
        }
        
    }];

}
- (IBAction)updatePrice:(id)sender{
    
    [self setPriceWithcode];
}
- (void)setPriceWithcode{
    
    NSLog(@"code %@",self.code1.stringValue);
    
    self.price1.stringValue = [self getMaxPrice:self.code1.stringValue];
    self.price2.stringValue = [self getMaxPrice:self.code2.stringValue];
    self.price3.stringValue = [self getMaxPrice:self.code3.stringValue];
    self.price4.stringValue = [self getMaxPrice:self.code4.stringValue];
    self.price5.stringValue = [self getMaxPrice:self.code5.stringValue];
    
}
- (CommodityModel *)getcommodityWithCode:(NSString *)code{
    
    for (CommodityModel *model in _queryData) {
        
        if ([model.code isEqualToString:code]) {
            return model;
        }
    }
    return nil;
}
- (NSString *)getMaxPrice:(NSString *)code{
    
    CommodityModel *model = [self getcommodityWithCode:code];
    
    return model.maxPrice;
    
}

static int reloginCount = 0;

- (void)relogin{
    
    NSLog(@"重新登录");
    
    UserInfoModel *model = [XMLStoreService currentUserModel];
    
    [[XMLEncryptStr shared] RequestWithName:model.account AndPassword:model.password MarkID:model.markId Blocks:^(id obj, NSString *code, NSString *message) {
        
        NSLog(@"XMLEncryptStr code:%@ message:%@",code,message);
        if ([code isEqualToString:@"0"]) {
            [[XMLUserLogin shared] RequestWithName:model.account AndPassword:model.password Blocks:^(id obj, NSString *code, NSString *message) {
                NSLog(@"XMLUserLogin code:%@ message:%@",code,message);
                if (code) {
                    
                }else{
                    if (reloginCount<5) {
                        reloginCount++;
                        [self relogin];
                    }else{
                        reloginCount = 0;
                    }
                }
                
            }];
            
        }else{
            
            
        }
    }];
}
- (BOOL)shouldStartWithStartTime:(NSString *)time{
    
    if (time.length != 9) {
        return  NO;
    }
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd "];
    NSString *dateStr1 = [formatter1 stringFromDate:now];
    
    [formatter1 setDateFormat:@"yyyy-MM-dd HHmmssSSS"];
    
    NSString *newTime = [NSString stringWithFormat:@"%@%@",dateStr1,time];
    
    NSDate *startDate = [formatter1 dateFromString:newTime];
    
    NSTimeInterval nowTimeInterval = now.timeIntervalSince1970;
    
    NSTimeInterval startTimeInterval = startDate.timeIntervalSince1970;
    //    提前发起时间
    NSTimeInterval early = 50;
    
    if (nowTimeInterval*1000 >= startTimeInterval*1000 + self.shijiancha - early) {
        
        return YES;
    }
    return NO;
}

static NSTimeInterval  tieminterval = 0.001;

static NSTimeInterval  nottieminterval = 0.001;


- (IBAction)buttonClick:(NSButton *)sender{
    switch (sender.tag) {
        case 1:
            if (!self.code1.stringValue.length || !self.price1.stringValue.length || !self.amount1.stringValue.length) {
                return;
            }
            break;
        case 2:
            if (!self.code2.stringValue.length || !self.price2.stringValue.length || !self.amount2.stringValue.length) {
                return;
            }
            break;
        case 3:
            if (!self.code3.stringValue.length || !self.price3.stringValue.length || !self.amount3.stringValue.length) {
                return;
            }
            break;
        case 4:
            if (!self.code4.stringValue.length || !self.price4.stringValue.length || !self.amount4.stringValue.length) {
                return;
            }
            break;
        case 5:
            if (!self.code5.stringValue.length || !self.price5.stringValue.length || !self.amount5.stringValue.length) {
                return;
            }
            break;
    }
    NSLog(@"state %ld",sender.state);
    if (sender.state) {
        
        NSString *string = [NSString stringWithFormat:@"queue%ldnstimer",sender.tag];
        
        SEL selector = NSSelectorFromString(string);
        
        [self performSelector:selector withObject:nil afterDelay:0];
    }
}


- (void)queue1nstimer{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (self.btn1.state == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.Activity1 startAnimation:nil];
            });
            NSLog(@"time %@",self.startTime.stringValue);
            
            if ([self shouldStartWithStartTime:self.startTime.stringValue]) {
                NSTimeInterval  start  =  CACurrentMediaTime();
                //            [self requestStart1:start];
                [[XMLOrderSubmit shared] RequestWithBuy_Sell:@"1" commodityID:self.code1.stringValue Price:self.price1.stringValue Amount:self.amount1.stringValue Blocks:^(ResultOrder_SubmitModel *result, NSString *code, NSString *message) {
                    NSTimeInterval end = CACurrentMediaTime();
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.Activity1 stopAnimation:nil];
                        
                        self.logoLabel1.stringValue = [NSString stringWithFormat:@"queue1 code :%@  message :%@ time : %f",code,message,end-start];
                    });
                    
                    NSLog(@"queue1 code :%@  message :%@ time : %f",code,message,end-start);
                    
                    if ([code  isEqualToString:@"-1611"] ||[code  isEqualToString:@"-1633"]) {
                        [NSThread sleepForTimeInterval:tieminterval];
                        [self queue1nstimer];
                        
                    }else if ([code isEqualToString:@"0"]){
                        NSLog(@"queue1 下单成功");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.logoLabel1.stringValue = @"OK";
                            self.btn1.state = 0;
                        });
                    }else if ([code isEqualToString:@"-2"]){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.logoLabel1.stringValue = @"死了";
                        });
                        NSLog(@"queue1 你挂了");
                    }else if ([code isEqualToString:@"-101"]){
                        [self relogin];
                        [self queue1nstimer];
                        
                    }else{
                        [NSThread sleepForTimeInterval:tieminterval];
                        [self queue1nstimer];
                    }
                }];
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.logoLabel1.stringValue = @"等。。。";
                });
                NSLog(@"queue1 时间不到");
                [NSThread sleepForTimeInterval:nottieminterval];
                [self queue1nstimer];
            }
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //                self.logoLabel1.stringValue = @"label";
                [self.Activity1 stopAnimation:nil];
            });
        }
    });
}

- (void)queue2nstimer{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (self.btn2.state == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.Activity2 startAnimation:nil];
            });
            if ([self shouldStartWithStartTime:self.startTime.stringValue]) {
                
                NSTimeInterval  start  =  CACurrentMediaTime();
                
                [[XMLOrderSubmit shared] RequestWithBuy_Sell:@"1" commodityID:self.code2.stringValue Price:self.price2.stringValue Amount:self.amount2.stringValue Blocks:^(ResultOrder_SubmitModel *result, NSString *code, NSString *message) {
                    NSTimeInterval end = CACurrentMediaTime();
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.Activity2 stopAnimation:nil];
                        
                        self.logoLabel2.stringValue = [NSString stringWithFormat:@"queue2 code :%@  message :%@ time : %f",code,message,end-start];
                    });
                    
                    NSLog(@"queue2 code :%@  message :%@ time : %f",code,message,end-start);
                    
                    if ([code  isEqualToString:@"-1611"] ||[code  isEqualToString:@"-1633"]) {
                        [NSThread sleepForTimeInterval:tieminterval];
                        
                        [self queue2nstimer];
                        
                    }else if ([code isEqualToString:@"0"]){
                        NSLog(@"queue2 下单成功");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.logoLabel2.stringValue = @"OK";
                            self.btn2.state = 0;
                        });
                    }else if ([code isEqualToString:@"-2"]){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.logoLabel2.stringValue = @"死了";
                        });
                        NSLog(@"queue2 你挂了");
                    }else if ([code isEqualToString:@"-101"]){
                        [self relogin];
                        [self queue2nstimer];
                        
                    }else{
                        [NSThread sleepForTimeInterval:tieminterval];
                        
                        [self queue2nstimer];
                    }
                }];
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.logoLabel2.stringValue = @"等。。。";
                });
                NSLog(@"queue2 时间不到");
                [NSThread sleepForTimeInterval:nottieminterval];
                [self queue2nstimer];
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //                self.logoLabel2.stringValue = @"label";
                [self.Activity2 stopAnimation:nil];
            });
        }
    });
}

- (void)queue3nstimer{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (self.btn3.state == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.Activity3 startAnimation:nil];
            });
            if ([self shouldStartWithStartTime:self.startTime.stringValue]) {
                
                NSTimeInterval  start  =  CACurrentMediaTime();
                
                [[XMLOrderSubmit shared] RequestWithBuy_Sell:@"1" commodityID:self.code3.stringValue Price:self.price3.stringValue Amount:self.amount3.stringValue Blocks:^(ResultOrder_SubmitModel *result, NSString *code, NSString *message) {
                    NSTimeInterval end = CACurrentMediaTime();
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.Activity3 stopAnimation:nil];
                        
                        self.logoLabel3.stringValue = [NSString stringWithFormat:@"queue3 code :%@  message :%@ time : %f",code,message,end-start];
                    });
                    
                    NSLog(@"queue3 code :%@  message :%@ time : %f",code,message,end-start);
                    
                    NSLog(@" :%@  message :%@",code,message);
                    
                    if ([code  isEqualToString:@"-1611"] ||[code  isEqualToString:@"-1633"]) {
                        [NSThread sleepForTimeInterval:tieminterval];
                        [self queue3nstimer];
                        
                    }else if ([code isEqualToString:@"0"]){
                        NSLog(@"queue3 下单成功");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.logoLabel3.stringValue = @"OK";
                            self.btn3.state = 0;
                        });
                    }else if ([code isEqualToString:@"-2"]){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.logoLabel3.stringValue = @"死了";
                        });
                        NSLog(@"queue3 你挂了");
                    }else if ([code isEqualToString:@"-101"]){
                        [self relogin];
                        [self queue3nstimer];
                        
                    }else{
                        [NSThread sleepForTimeInterval:tieminterval];
                        
                        [self queue3nstimer];
                    }
                }];
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.logoLabel3.stringValue = @"等。。。";
                });
                NSLog(@"queue3 时间不到");
                [NSThread sleepForTimeInterval:nottieminterval];
                [self queue3nstimer];
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //                self.logoLabel3.stringValue = @"label";
                [self.Activity3 stopAnimation:nil];
            });
        }
    });
}
- (void)queue4nstimer{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (self.btn4.state == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.Activity4 startAnimation:nil];
            });
            if ([self shouldStartWithStartTime:self.startTime.stringValue]) {
                
                NSTimeInterval  start  =  CACurrentMediaTime();
                
                [[XMLOrderSubmit shared] RequestWithBuy_Sell:@"1" commodityID:self.code4.stringValue Price:self.price4.stringValue Amount:self.amount4.stringValue Blocks:^(ResultOrder_SubmitModel *result, NSString *code, NSString *message) {
                    NSTimeInterval end = CACurrentMediaTime();
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.Activity4 stopAnimation:nil];
                        
                        self.logoLabel4.stringValue = [NSString stringWithFormat:@"queue4 code :%@  message :%@ time : %f",code,message,end-start];
                    });
                    
                    NSLog(@"queue4 code :%@  message :%@ time : %f",code,message,end-start);
                    
                    if ([code  isEqualToString:@"-1611"] ||[code  isEqualToString:@"-1633"]) {
                        [NSThread sleepForTimeInterval:tieminterval];
                        
                        [self queue4nstimer];
                        
                    }else if ([code isEqualToString:@"0"]){
                        NSLog(@"queue4 下单成功");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.logoLabel4.stringValue = @"OK";
                            self.btn4.state = 0;
                        });
                    }else if ([code isEqualToString:@"-2"]){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.logoLabel4.stringValue = @"死了";
                        });
                        NSLog(@"queue4 你挂了");
                    }else if ([code isEqualToString:@"-101"]){
                        [self relogin];
                        [self queue4nstimer];
                        
                    }else{
                        [NSThread sleepForTimeInterval:tieminterval];
                        
                        [self queue4nstimer];
                    }
                }];
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.logoLabel4.stringValue = @"等。。。";
                });
                NSLog(@"queue4 时间不到");
                [NSThread sleepForTimeInterval:nottieminterval];
                [self queue4nstimer];
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //                self.logoLabel4.stringValue = @"label";
                [self.Activity4 stopAnimation:nil];
            });
        }
    });
}
- (void)queue5nstimer{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (self.btn5.state == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.Activity5 startAnimation:nil];
            });
            if ([self shouldStartWithStartTime:self.startTime.stringValue]) {
                
                NSTimeInterval  start  =  CACurrentMediaTime();
                
                [[XMLOrderSubmit shared] RequestWithBuy_Sell:@"1" commodityID:self.code5.stringValue Price:self.price5.stringValue Amount:self.amount5.stringValue Blocks:^(ResultOrder_SubmitModel *result, NSString *code, NSString *message) {
                    NSTimeInterval end = CACurrentMediaTime();
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.Activity5 stopAnimation:nil];
                        
                        self.logoLabel5.stringValue = [NSString stringWithFormat:@"queue5 code :%@  message :%@ time : %f",code,message,end-start];
                    });
                    
                    NSLog(@"queue5 code :%@  message :%@ time : %f",code,message,end-start);
                    
                    if ([code  isEqualToString:@"-1611"] ||[code  isEqualToString:@"-1633"]) {
                        [NSThread sleepForTimeInterval:tieminterval];
                        
                        [self queue5nstimer];
                        
                    }else if ([code isEqualToString:@"0"]){
                        NSLog(@"queue5 下单成功");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.logoLabel5.stringValue = @"OK";
                            self.btn5.state = 0;
                        });
                    }else if ([code isEqualToString:@"-2"]){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.logoLabel5.stringValue = @"死了";
                        });
                        self.btn5.state = 0;
                        NSLog(@"queue5 你挂了");
                    }else if ([code isEqualToString:@"-101"]){
                        [self relogin];
                        [self queue5nstimer];
                        
                    }else{
                        [NSThread sleepForTimeInterval:tieminterval];
                        
                        [self queue5nstimer];
                    }
                }];
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.logoLabel5.stringValue = @"等。。。";
                });
                NSLog(@"queue5 时间不到");
                [NSThread sleepForTimeInterval:nottieminterval];
                [self queue5nstimer];
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //                self.logoLabel5.stringValue = @"label";
                [self.Activity5 stopAnimation:nil];
            });
        }
    });
}
- (void)controlTextDidChange:(NSNotification *)obj{
    
    NSTextField *textfield = obj.object;
    
    if (textfield == self.startTime) {
        
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.startTime"];
    }else if (textfield == self.code1){
        
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.code1"];
        
    }else if (textfield == self.code2){
        
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.code2"];
        
    }else if (textfield == self.code3){
        
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.code3"];
        
    }else if (textfield == self.code4){
        
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.code4"];
        
    }else if (textfield == self.code5){
        
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.code5"];
        
    }else if (textfield == self.price1){
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.price1"];
        
    }else if (textfield == self.price2){
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.price2"];
        
    }else if (textfield == self.price3){
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.price3"];
        
    }else if (textfield == self.price4){
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.price4"];
        
    }else if (textfield == self.price5){
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.price5"];
        
    }else if(textfield == self.amount1){
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.amount1"];
    }else if(textfield == self.amount2){
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.amount2"];
    }else if(textfield == self.amount3){
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.amount3"];
    }else if(textfield == self.amount4){
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.amount4"];
    }else if(textfield == self.amount5){
        [XMLStoreService StoredefaultValue:textfield.stringValue Key:@"self.amount5"];
    }
    NSLog(@"text %@",textfield.stringValue);
}

@end
