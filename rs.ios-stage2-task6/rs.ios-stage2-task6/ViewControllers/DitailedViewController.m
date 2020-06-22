//
//  DitailedViewController.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/21/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import "DitailedViewController.h"
#import "HeaderView.h"

@interface DitailedViewController ()
@property (strong, nonatomic) IBOutlet HeaderView *headerView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (void) closeView;
@end

@implementation DitailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.headerView.backButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
}

- (void) closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.imageView setImage:self.imageToShow];
}

- (void) setImageToShow:(UIImage *)imageToShow {
    _imageToShow = imageToShow;
    [self.imageView setImage:imageToShow];
}

@end
