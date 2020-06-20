//
//  InfoTableViewCell.h
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/20/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/PHAsset.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoTableViewCell : UITableViewCell

@property (nonatomic,copy)NSString* representedAssetIdentifier;

+(NSString*)reuseId;
-(void)setMediaAsset:(PHAsset*)asset;
-(void)setFileName:(NSString*)name;
-(void)setImageLabel:(UIImage*)image;
@end

NS_ASSUME_NONNULL_END
