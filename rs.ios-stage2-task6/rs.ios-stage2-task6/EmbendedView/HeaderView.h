//
//  HeaderView.h
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/21/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderView : UIView
@property (strong, nonatomic) IBOutlet UIButton *backButton;
-(void)setTitleText:(NSString*)text;
-(void)setBackButtonIsHidden:(BOOL)isHidden;
@end

NS_ASSUME_NONNULL_END
