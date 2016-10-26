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

@end

@implementation AppDelegate

- (MyWindowViewControll *)mywindow{
    
    if (!_mywindow) {
        _mywindow = [[MyWindowViewControll alloc]initWithWindowNibName:@"MyWindowViewControll"];
    }
    return _mywindow;
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
//    [self.mywindow showWindow:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
