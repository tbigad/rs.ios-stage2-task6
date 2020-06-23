//
//  CircleView.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/22/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import "CircleView.h"
#import "UIColor+RSSchool.h"

IB_DESIGNABLE
@implementation CircleView

- (void)drawRect:(CGRect)rect {
    if(self.type == FigureTypeCircle) {
        [self drawCircle:rect];
    } else if (self.type == FigureTypeCube) {
        [self drawCube:rect];
    }else {
        [self drawTriangle:rect];
    }
}

- (void) drawCircle:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path closePath];
    [[UIColor rsschoolRedColor] setFill];
    [path fill];
    
}

- (void) drawCube:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    [path closePath];
    [[UIColor rsschoolBlueColor] setFill];
    [path fill];
}

- (void) drawTriangle:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(rect.size.width/2, rect.origin.y)];
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    [path addLineToPoint:CGPointMake(rect.origin.x, rect.size.height)];
    [path closePath];
    [[UIColor rsschoolGreenColor] setFill];
    [path fill];
}

- (void)animate {
    if(self.type == FigureTypeCircle) {
        [UIView animateWithDuration:1.0 delay:0 options: (UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat) animations:^{
            [self setTransform: CGAffineTransformMakeScale(1.2, 1.2)];
        } completion:^(BOOL finished) {
            if (finished) {
                [self setTransform: CGAffineTransformMakeScale(1, 1)];
                [self animate];
            }
        }];
    } else if (self.type == FigureTypeCube) {
        [UIView animateWithDuration:1.0 delay:0 options: (UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat) animations:^{
            [self setTransform: CGAffineTransformMakeTranslation(0, 10)];
        } completion:^(BOOL finished) {
            if (finished) {
                [self setTransform: CGAffineTransformMakeTranslation(0, 0)];
                [self animate];
                
            }
        }];
    }else {
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [self setTransform:CGAffineTransformRotate(self.transform, M_PI_2)];
        }completion:^(BOOL finished){
            if (finished) {
                [self animate];
            }
        }];
    }
}
@end
