//
//  InfoTableViewCell.h
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/20/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, InfoTableViewCellStyle) {
    InfoTableViewCellStyleAudio,
    InfoTableViewCellStyleVideo,
    InfoTableViewCellStylePhoto,
    InfoTableViewCellStyleOther
};

@interface InfoTableViewCell : UITableViewCell

@property (nonatomic,copy)NSString* representedAssetIdentifier;

+(NSString*)reuseId;
-(void)setCellStyle:(InfoTableViewCellStyle)style;
-(void)setFileName:(NSString*)name;
-(void)setImageLabel:(UIImage*)image;
-(void)setDescriptionText:(NSString*)text;
@end

NS_ASSUME_NONNULL_END
