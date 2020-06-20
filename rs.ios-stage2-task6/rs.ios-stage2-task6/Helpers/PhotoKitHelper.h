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

@interface PhotoKitHelper : NSObject
-(NSUInteger)itemsCount;
-(PHAsset*) itemAt:(NSUInteger)index;
-(void) requestImage:(PHAsset*)asset targetSize:(CGSize)size contentMode:(PHImageContentMode)mode resultHandler:(void (^)(UIImage *_Nullable result))handler;
-(void) requestFileNameForAssets:(PHAsset*)asset resultHandler:(void (^)(NSString *_Nullable result))handler;
@end

NS_ASSUME_NONNULL_END
