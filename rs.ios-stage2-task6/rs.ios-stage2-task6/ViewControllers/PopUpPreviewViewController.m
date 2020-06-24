//
//  PopUpPreviewViewController.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/24/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import "PopUpPreviewViewController.h"

@interface PopUpPreviewViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation PopUpPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.image != nil) {
        [self.imageView setImage:self.image];
    }
}

- (IBAction)didTappedCloseButton:(UIButton *)sender {
    if (self.player != nil) {
        [self.player pause];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
