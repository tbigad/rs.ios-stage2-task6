//
//  HomeViewController.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/21/20
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import "HomeViewController.h"
#import "RoundedButton.h"
#import "UIColor+RSSchool.h"
#import "CircleView.h"

@interface HomeViewController ()
@property (strong, nonatomic) IBOutlet RoundedButton *openCvButton;
@property (strong, nonatomic) IBOutlet RoundedButton *goToStartBtn;
@property (strong, nonatomic) IBOutlet CircleView *circleView;
@property (strong, nonatomic) IBOutlet CircleView *triangleView;
@property (strong, nonatomic) IBOutlet CircleView *cubeView;
@property (strong, nonatomic) IBOutlet UILabel *phoneName;
@property (strong, nonatomic) IBOutlet UILabel *phoneModel;
@property (strong, nonatomic) IBOutlet UILabel *phoneSystemName;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.openCvButton setBackgroundColor:[UIColor rsschoolYellowColor]];
    [self.goToStartBtn setBackgroundColor:[UIColor rsschoolRedColor]];
    [self fillInfoLabels];
    [self setTitle:@"RSSchool Task 6"];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.circleView animate];
    [self.triangleView animate];
    [self.cubeView animate];
}

- (IBAction)openCV:(RoundedButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://tbigad.github.io/rsschool-cv/cv"] options:@{} completionHandler:nil];
}

- (IBAction)goToStart:(id)sender {
    [self.tabBarController setSelectedIndex:0];
}

-(void) fillInfoLabels {
    [self.phoneName setText:[UIDevice.currentDevice name]];
    [self.phoneModel setText:[UIDevice.currentDevice model]];
    [self.phoneSystemName setText:[UIDevice.currentDevice systemName]];
}

@end
