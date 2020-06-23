//
//  AppDelegate.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/19/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "StartViewController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    StartViewController *start = [StartViewController new];
    __weak typeof(self) weakSelf = self;
    start.succecsStartTapped = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.window setRootViewController:[RootViewController new]];
        });
    };
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:start];
    [self.window makeKeyAndVisible];
    [self.window setBackgroundColor:[UIColor clearColor]];
    return YES;
}

@end
