//
//  InfoTableViewCell.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/20/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import "InfoTableViewCell.h"
#import "UIColor+RSSchool.h"

@interface InfoTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation InfoTableViewCell
@synthesize imageView;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor rsschoolYellowHighlightedColor]];
    [self setSelectedBackgroundView:bgColorView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (NSString *)reuseId {
    return @"InfoTableViewCell";
}

- (void)setCellStyle:(InfoTableViewCellStyle)style {
    
    switch (style) {
        case InfoTableViewCellStyleAudio:
        [self.iconView setImage:[UIImage imageNamed:@"audio"]];
            break;
        case InfoTableViewCellStyleVideo:
        [self.iconView setImage:[UIImage imageNamed:@"video"]];
            break;
        case InfoTableViewCellStylePhoto:
        [self.iconView setImage:[UIImage imageNamed:@"image"]];
            break;
        case InfoTableViewCellStyleOther:
        [self.iconView setImage:[UIImage imageNamed:@"other"]];
            break;
    }
    
}

- (void)setImageLabel:(UIImage *)image {
    [self.imageView setImage:image];
}

- (void)setFileName:(NSString *)name {
    [self.titleLabel setText:name];
}

- (void)setDescriptionText:(NSString *)text {
    [self.descriptionLabel setText:text];
}

@end
