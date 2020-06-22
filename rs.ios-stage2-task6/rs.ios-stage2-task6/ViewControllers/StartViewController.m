//
//  StartViewController.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/22/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import "StartViewController.h"
#import "RoundedButton.h"
#import "UIColor+RSSchool.h"
#import "CircleView.h"
#import <Photos/Photos.h>

@interface StartViewController ()
@property (strong, nonatomic) IBOutlet RoundedButton *startBtn;
@property (strong, nonatomic) IBOutlet CircleView *circleView;
@property (strong, nonatomic) IBOutlet CircleView *triangleView;
@property (strong, nonatomic) IBOutlet CircleView *cubeView;
@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startBtn.backgroundColor = [UIColor rsschoolYellowColor];
    [self.circleView animate];
    [self.triangleView animate];
    [self.cubeView animate];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTappedStartButton:(RoundedButton *)sender {
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
            self.succecsStartTapped();
            break;
    }
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
                weakSelf.succecsStartTapped();
                break;
            default:
                break;
        }
    }];
}

@end
