//
//  HeaderView.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/21/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import "HeaderView.h"
#import "UIColor+RSSchool.h"

@interface HeaderView ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation HeaderView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void) commonInit {
    [self.backButton setHidden:YES];
    [NSBundle.mainBundle loadNibNamed:@"HeaderView" owner:self options:nil];
    [self addSubview: self.contentView];
    [self.contentView setFrame:self.bounds];
    self.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    self.contentView.backgroundColor = [UIColor rsschoolYellowColor];
}
- (void) setTitleText:(NSString *)text {
    [self.titleLabel setText:text];
}

- (void)setBackButtonIsHidden:(BOOL)isHidden {
    [self.backButton setHidden:isHidden];
}
@end
