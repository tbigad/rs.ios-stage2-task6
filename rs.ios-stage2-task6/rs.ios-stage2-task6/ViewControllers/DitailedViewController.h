//
//  DitailedViewController.h
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/21/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DitailedViewController : UIViewController
@property (nonatomic,copy)NSString* representedAssetIdentifier;
@property (nonatomic, strong) UIImage* originalImage;
@property (nonatomic, copy) NSDate* creationDate;
@property (nonatomic, copy) NSDate* modificationDate;
@property (nonatomic, copy) NSString* typeOfContent;
@property (nonatomic, copy) NSString* imageName;

@end

NS_ASSUME_NONNULL_END
