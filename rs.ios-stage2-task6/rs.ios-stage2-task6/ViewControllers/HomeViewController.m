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
#import "FigureView.h"

@interface HomeViewController ()
@property (strong, nonatomic) IBOutlet RoundedButton *openCvButton;
@property (strong, nonatomic) IBOutlet RoundedButton *goToStartBtn;
@property (strong, nonatomic) IBOutlet FigureView *circleView;
@property (strong, nonatomic) IBOutlet FigureView *triangleView;
@property (strong, nonatomic) IBOutlet FigureView *cubeView;
@property (strong, nonatomic) IBOutlet UILabel *phoneName;
@property (strong, nonatomic) IBOutlet UILabel *phoneModel;
@property (strong, nonatomic) IBOutlet UILabel *phoneSystemName;
@property (strong, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.openCvButton setBackgroundColor:[UIColor rsschoolYellowColor]];
    [self.goToStartBtn setBackgroundColor:[UIColor rsschoolRedColor]];
    [self fillInfoLabels];
    [self setupLayout];
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

-(void) setupLayout {
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [self.stackView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:30.0f],
            [self.view.safeAreaLayoutGuide.trailingAnchor constraintEqualToAnchor:self.stackView.trailingAnchor  constant:30.0f],
            [self.stackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor ],
            [self.view.safeAreaLayoutGuide.bottomAnchor constraintEqualToAnchor:self.stackView.bottomAnchor],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [self.stackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:30.0f],
            [self.view.trailingAnchor constraintEqualToAnchor:self.stackView.trailingAnchor constant:30.0f],
            [self.stackView.topAnchor constraintEqualToAnchor: self.topLayoutGuide.bottomAnchor],
            [self.bottomLayoutGuide.topAnchor constraintEqualToAnchor:self.stackView.bottomAnchor]
        ]];
    }
}

@end
