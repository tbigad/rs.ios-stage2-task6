//
//  RootViewController.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/19/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property (nonatomic,strong)UIViewController* infoTab;
@property (nonatomic,strong)UIViewController* galleryTab;
@property (nonatomic,strong)UIViewController* homeTab;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoTab = [[UIViewController alloc] init];
    UINavigationController* infoNav = [[UINavigationController alloc] initWithRootViewController:self.infoTab];
    [self addChildViewController: infoNav];
    UITabBarItem* infoTabItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@"info_unselected"] selectedImage:[UIImage imageNamed:@"info_selected"]];
    infoNav.tabBarItem = infoTabItem;
    
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

@end
