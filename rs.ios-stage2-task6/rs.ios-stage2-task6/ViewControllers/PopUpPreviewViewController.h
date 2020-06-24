//
//  PopUpPreviewViewController.h
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/24/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopUpPreviewViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) AVPlayer *player;
@end

NS_ASSUME_NONNULL_END
