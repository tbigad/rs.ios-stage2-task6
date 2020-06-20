//
//  InfoTableViewCell.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/20/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import "InfoTableViewCell.h"

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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (NSString *)reuseId {
    return @"InfoTableViewCell";
}

- (void)setMediaAsset:(PHAsset *)asset {
    self.representedAssetIdentifier = asset.localIdentifier;

    switch (asset.mediaType) {
        case PHAssetMediaTypeUnknown:
            [self.iconView setImage:[UIImage imageNamed:@"other"]];
            break;
        case PHAssetMediaTypeImage:
            [self.iconView setImage:[UIImage imageNamed:@"image"]];
            [self.descriptionLabel setText:[[NSString alloc]initWithFormat:@"%lux%lu",asset.pixelWidth,asset.pixelHeight]];
            break;
        case PHAssetMediaTypeVideo:
            [self.iconView setImage:[UIImage imageNamed:@"video"]];
            break;
        case PHAssetMediaTypeAudio:
            [self.iconView setImage:[UIImage imageNamed:@"audio"]];
            break;
    }
}

- (void)setImageLabel:(UIImage *)image {
    [self.imageView setImage:image];
}

- (void)setFileName:(NSString *)name {
    [self.titleLabel setText:name];
}

@end
