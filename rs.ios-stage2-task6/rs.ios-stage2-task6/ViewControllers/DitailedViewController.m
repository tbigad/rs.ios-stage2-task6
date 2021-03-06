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
#import <Photos/Photos.h>

@interface DitailedViewController ()
@property (strong, nonatomic) IBOutlet HeaderView *headerView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet RoundedButton *shareBtn;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labelsProperties;
@property (strong, nonatomic) IBOutlet UILabel *creationDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *modificationDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentTypeLabel;
@property (strong, nonatomic) IBOutlet UIStackView *stackView;

- (void) closeView;
@end

@implementation DitailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.headerView.backButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    for (UILabel* label in self.labelsProperties) {
        [label setTextColor:[UIColor rsschoolGrayColor]];
    }
    self.shareBtn.backgroundColor = [UIColor rsschoolYellowColor];
    [self setupLoyaout];
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


- (void) setupLoyaout {
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [self.stackView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor ],
            [self.view.safeAreaLayoutGuide.trailingAnchor constraintEqualToAnchor:self.stackView.trailingAnchor ],
            [self.stackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor ],
            [self.view.safeAreaLayoutGuide.bottomAnchor constraintEqualToAnchor:self.stackView.bottomAnchor],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [self.stackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [self.view.trailingAnchor constraintEqualToAnchor:self.stackView.trailingAnchor],
            [self.stackView.topAnchor constraintEqualToAnchor: self.topLayoutGuide.bottomAnchor],
            [self.bottomLayoutGuide.topAnchor constraintEqualToAnchor:self.stackView.bottomAnchor]
        ]];
    }
}

- (IBAction)didTappedShareBtn:(RoundedButton *)sender {
    if(self.currentAsset.mediaType == PHAssetMediaTypeVideo) {
        __weak typeof(self) weakSelf = self;
        [self.helper requestExportVideoForAsset:self.currentAsset resultHandler:^(NSURL * _Nullable fileURL) {
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[fileURL] applicationActivities:nil];
                    [weakSelf presentViewController:activity animated:YES completion:nil];
                });
            }
        }];
    } else {
        UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[self.originalImage] applicationActivities:nil];
        [self presentViewController:activity animated:YES completion:nil];
    }
}

- (NSString*) formateDate:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *hourFormatter = [[NSDateFormatter alloc] init];
    [hourFormatter setLocalizedDateFormatFromTemplate:@"HH:mm:ss"];
    [dateFormatter setLocalizedDateFormatFromTemplate:@"dd.MM.yyyy"];
    
    
    return [NSString stringWithFormat:@"%@ %@",[hourFormatter stringFromDate:date],[dateFormatter stringFromDate:date]];
}

@end
