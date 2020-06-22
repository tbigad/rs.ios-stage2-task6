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
#import "GalleryViewController.h"
#import "HomeViewController.h"

@interface RootViewController ()
@property (nonatomic,strong)InfoViewController* infoTab;
@property (nonatomic,strong)GalleryViewController* galleryTab;
@property (nonatomic,strong)HomeViewController* homeTab;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabs];
    [self setSelectedIndex:1];
}

- (void) setupTabs {
    self.infoTab = [[InfoViewController alloc] init];
    UITabBarItem* infoTabItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@"info_unselected"] selectedImage:[UIImage imageNamed:@"info_selected"]];
    self.infoTab.tabBarItem = infoTabItem;
    [self addChildViewController: self.infoTab];
    
    self.galleryTab = [[GalleryViewController alloc] init];
    UITabBarItem* galleryTabItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@"gallery_unselected"] selectedImage:[UIImage imageNamed:@"gallery_selected"]];
    self.galleryTab.tabBarItem = galleryTabItem;
    [self addChildViewController: self.galleryTab];
    
    self.homeTab = [[HomeViewController alloc] init];
    UINavigationController* homeNav = [[UINavigationController alloc] initWithRootViewController:self.homeTab];
    [self addChildViewController: homeNav];
    UITabBarItem* homeTabItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@"home_unselected"] selectedImage:[UIImage imageNamed:@"home_selected"]];
    homeNav.tabBarItem = homeTabItem;
    homeNav.navigationBar.backgroundColor = [UIColor rsschoolYellowColor];
    [homeNav.navigationBar setTitleTextAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold],
                                                     NSForegroundColorAttributeName: [UIColor rsschoolBlackColor] }];
    [[self tabBar] setTintColor:[UIColor blackColor]];
}


@end
