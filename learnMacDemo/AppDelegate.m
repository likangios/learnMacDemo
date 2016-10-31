//
//  AppDelegate.m
//  learnMacDemo
//
//  Created by FengLing on 16/10/20.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "AppDelegate.h"
#import "MyWindowViewControll.h"

@interface AppDelegate ()


@property (nonatomic,strong) MyWindowViewControll               *mywindow;


@property (nonatomic,strong) MyWindowViewControll               *moreWindow;


@end

@implementation AppDelegate

- (MyWindowViewControll *)GetNewWindowController{
    _moreWindow = [[MyWindowViewControll alloc]initWithWindowNibName:@"MyWindowViewControll"];
    return _moreWindow;
    
}
- (MyWindowViewControll *)mywindow{
    
    if (!_mywindow) {
        _mywindow = [[MyWindowViewControll alloc]initWithWindowNibName:@"MyWindowViewControll"];
    }
    return _mywindow;
}

- (IBAction)CommandNClick:(id)sender{
    NSLog(@"新开 window");
    [self GetNewWindowController];
    [_moreWindow showWindow:self];
    
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
//    [self.mywindow showWindow:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
