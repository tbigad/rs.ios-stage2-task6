//
//  PhotoKitHelper.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/20/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import "PhotoKitHelper.h"

@interface PhotoKitHelper ()<PHPhotoLibraryChangeObserver>
@property (nonatomic,strong) PHImageManager *photoManager;
@property (nonatomic, strong) PHFetchResult<PHAsset*> *fetchResult;
@end

@implementation PhotoKitHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
        _photoManager = [[PHCachingImageManager alloc]init];
        PHFetchOptions* options = [[PHFetchOptions alloc]init];
        options.sortDescriptors = @[ [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:YES] ];
        _fetchResult = [PHAsset fetchAssetsWithOptions:options];
    }
    return self;
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    
}

- (void)dealloc
{
    [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
}

- (NSUInteger)itemsCount {
    return [self.fetchResult count];
}

-(PHAsset*) itemAt:(NSUInteger)index {
    return [self.fetchResult objectAtIndex:index];
}

-(void) requestImage:(PHAsset*)asset targetSize:(CGSize)size contentMode:(PHImageContentMode)mode resultHandler:(void (^)(UIImage *_Nullable result))handler {
    [self.photoManager requestImageForAsset:asset targetSize:size contentMode:mode options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        handler(result);
    }];
}

-(void) requestFileNameForAssets:(PHAsset*)asset resultHandler:(void (^)(NSString *_Nullable result))handler {
    [self.photoManager requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        if ([info objectForKey:@"PHImageFileURLKey"]) {
            // path looks like this -
            // file:///var/mobile/Media/DCIM/###APPLE/IMG_####.JPG
            NSURL *path = [info objectForKey:@"PHImageFileURLKey"];
            handler([path lastPathComponent]);
        }
    }];
}

@end
