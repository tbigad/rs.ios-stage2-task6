//
//  RootViewController.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/19/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//


#import "RootViewController.h"
#import "UIColor+RSSchool.h"
#import "InfoViewController.h"
#import <Photos/Photos.h>

@interface RootViewController ()
@property (nonatomic,strong)InfoViewController* infoTab;
@property (nonatomic,strong)UIViewController* galleryTab;
@property (nonatomic,strong)UIViewController* homeTab;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PHAuthorizationStatus code = [PHPhotoLibrary authorizationStatus];
    
    switch (code) {
        case PHAuthorizationStatusNotDetermined:
            [self requestAuthorization];
            break;
        case PHAuthorizationStatusRestricted:
            //TODO
            break;
        case PHAuthorizationStatusDenied:
            //TODO
            break;
        case PHAuthorizationStatusAuthorized:
            [self setupTabs];
            break;
    }
    
}

- (void) setupTabs {
    self.infoTab = [[InfoViewController alloc] init];
    UINavigationController* infoNav = [[UINavigationController alloc] initWithRootViewController:self.infoTab];
    [self addChildViewController: infoNav];
    UITabBarItem* infoTabItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@"info_unselected"] selectedImage:[UIImage imageNamed:@"info_selected"]];
    infoNav.tabBarItem = infoTabItem;
    infoNav.navigationBar.backgroundColor = [UIColor rsschoolYellowColor];
    infoNav.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"System-Semibold" size:18.0],NSFontAttributeName,nil];
    
    self.galleryTab = [[UIViewController alloc] init];
    UINavigationController* galleryNav = [[UINavigationController alloc] initWithRootViewController:self.galleryTab];
    [self addChildViewController: galleryNav];
    UITabBarItem* galleryTabItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@"gallery_unselected"] selectedImage:[UIImage imageNamed:@"gallery_selected"]];
    galleryNav.tabBarItem = galleryTabItem;
    
    self.homeTab = [[UIViewController alloc] init];
    UINavigationController* homeNav = [[UINavigationController alloc] initWithRootViewController:self.homeTab];
    [self addChildViewController: homeNav];
    UITabBarItem* homeTabItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@"home_unselected"] selectedImage:[UIImage imageNamed:@"home_selected"]];
    homeNav.tabBarItem = homeTabItem;
    
    [[self tabBar] setTintColor:[UIColor blackColor]];
}
- (void) requestAuthorization {
    __weak typeof(self) weakSelf = self;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusNotDetermined:
                //TODO
                break;
            case PHAuthorizationStatusRestricted:
                //TODO
                break;
            case PHAuthorizationStatusDenied:
                //TODO
                break;
            case PHAuthorizationStatusAuthorized:
                [weakSelf setupTabs];
                break;
            default:
                break;
        }
    }];
}

@end
