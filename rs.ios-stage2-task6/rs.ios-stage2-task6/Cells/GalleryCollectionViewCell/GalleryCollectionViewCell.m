//
//  GalleryCollectionViewCell.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/21/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import "GalleryCollectionViewCell.h"
@interface GalleryCollectionViewCell()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GalleryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImage:(UIImage *)image {
    [self.imageView setImage:image];
}

+ (NSString *)reuseId {
    return @"GalleryCollectionViewCell";
}
@end
