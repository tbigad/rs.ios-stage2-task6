//
//  StartViewController.h
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/22/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StartViewController : UIViewController
@property (nonatomic, copy) void (^succecsStartTapped)(void);
@end

NS_ASSUME_NONNULL_END
