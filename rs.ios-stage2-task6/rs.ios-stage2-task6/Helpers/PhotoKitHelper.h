//
//  PhotoKitHelper.h
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/20/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PhotoKitHelperDelegate <NSObject>
-(void)libraryDidChage:(PHFetchResultChangeDetails *)ditails;
@end

typedef NS_ENUM(NSInteger,PhotoKitRequestType) {
    PhotoKitRequestTypeAll,
    PhotoKitRequestTypeImage
};

@interface PhotoKitHelper : NSObject
@property (nonatomic, weak, nullable) id <PhotoKitHelperDelegate> delegate;

- (instancetype)initWithType:(PhotoKitRequestType)type;
-(NSUInteger)itemsCount;
-(PHAsset*) itemAt:(NSUInteger)index;
-(void) requestImage:(PHAsset*)asset targetSize:(CGSize)size contentMode:(PHImageContentMode)mode sync:(BOOL)synchronous resultHandler:(void (^)(UIImage *_Nullable result))handler;
-(NSString *) fileNameForAssets:(PHAsset*)asset;
@end

NS_ASSUME_NONNULL_END
