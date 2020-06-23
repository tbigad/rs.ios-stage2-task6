//
//  CircleView.h
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/22/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FigureType){
    FigureTypeCircle = 0,
    FigureTypeCube = 1,
    FigureTypeTriangle = 2
};

@interface FigureView : UIButton
@property (nonatomic) IBInspectable NSUInteger type;

- (void) animate;
@end

NS_ASSUME_NONNULL_END
