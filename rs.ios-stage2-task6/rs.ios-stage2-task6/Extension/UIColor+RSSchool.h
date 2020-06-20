//
//  UIColor+RSSchool.h
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/19/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (RSSchool)

+(UIColor *)rsschoolBlackColor;
+(UIColor *)rsschoolWhiteColor;
+(UIColor *)rsschoolRedColor;
+(UIColor *)rsschoolBlueColor;
+(UIColor *)rsschoolGreenColor;
+(UIColor *)rsschoolYellowColor;
+(UIColor *)rsschoolGrayColor;
+(UIColor *)rsschoolYellowHighlightedColor;

+ (UIColor *)colorWithHexString:(NSString *) hexString;
@end

NS_ASSUME_NONNULL_END
