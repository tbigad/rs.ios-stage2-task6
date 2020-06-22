//
//  DitailedViewController.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/21/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import "DitailedViewController.h"
#import "HeaderView.h"
#import "UIImage+SizeToFit.h"
#import "UIColor+RSSchool.h"
#import "RoundedButton.h"

@interface DitailedViewController ()
@property (strong, nonatomic) IBOutlet HeaderView *headerView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet RoundedButton *shareBtn;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labelsProperties;
@property (strong, nonatomic) IBOutlet UILabel *creationDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *modificationDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentTypeLabel;

- (void) closeView;
@end

@implementation DitailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.headerView.backButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    for (UILabel* label in self.labelsProperties) {
        [label setTextColor:[UIColor rsschoolGrayColor]];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.imageView setImage:[UIImage imageWithImage:self.originalImage scaledToWidth:UIScreen.mainScreen.bounds.size.width]];
    [self.headerView setTitleText:self.imageName];
    [self.creationDateLabel setText:[self formateDate:self.creationDate]];
    [self.modificationDateLabel setText:[self formateDate:self.modificationDate]];
    [self.contentTypeLabel setText:self.typeOfContent];
}

- (void) closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTappedShareBtn:(RoundedButton *)sender {
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[self.originalImage] applicationActivities:nil];
    [self presentViewController:activity animated:YES completion:nil];
}

- (NSString*) formateDate:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocalizedDateFormatFromTemplate:@"HH:mm:ss dd.MM.yy"];
    
    return [dateFormatter stringFromDate:date];
}

@end
