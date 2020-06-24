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

- (instancetype)initWithType:(PhotoKitRequestType)type
{
    self = [super init];
    if (self) {
        [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
        _photoManager = [[PHCachingImageManager alloc]init];
        PHFetchOptions* options = [[PHFetchOptions alloc]init];
        options.sortDescriptors = @[ [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:YES] ];
        if(type == PhotoKitRequestTypeImage) {
            options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
        }
        _fetchResult = [PHAsset fetchAssetsWithOptions:options];
    }
    return self;
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    PHFetchResultChangeDetails *changeDitails = [changeInstance changeDetailsForFetchResult:self.fetchResult];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.fetchResult = [changeDitails fetchResultAfterChanges];
        [weakSelf.delegate libraryDidChage:changeDitails];
    });
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

-(void) requestImage:(PHAsset*)asset targetSize:(CGSize)size contentMode:(PHImageContentMode)mode sync:(BOOL)synchronous resultHandler:(void (^)(UIImage *_Nullable result))handler {
    PHImageRequestOptions *option = [PHImageRequestOptions new];
    option.synchronous = synchronous;
    [self.photoManager requestImageForAsset:asset targetSize:size contentMode:mode options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        handler(result);
    }];
}

-(NSString *) fileNameForAssets:(PHAsset*)asset {
    NSArray *resources = [PHAssetResource assetResourcesForAsset:asset];
    return ((PHAssetResource*)resources[0]).originalFilename;
}

- (NSString*) stringFromMediaType:(PHAssetMediaType)type {
    switch (type) {
        case PHAssetMediaTypeUnknown:
            return @"Unknown";
        case PHAssetMediaTypeImage:
            return @"Image";
        case PHAssetMediaTypeVideo:
            return @"Video";
        case PHAssetMediaTypeAudio:
            return @"Audio";
    }
}

- (void)requestExportVideoForAsset:(PHAsset*)asset resultHandler:(void (^)(NSURL *__nullable fileURL))resultHandler {
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHVideoRequestOptionsVersionOriginal;
    
    [self.photoManager requestAVAssetForVideo:asset options:options resultHandler:
     ^(AVAsset * _Nullable avasset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        
        AVURLAsset *avurlasset = (AVURLAsset*) avasset;
        NSString *tmpDirectory = NSTemporaryDirectory();
        NSString *tmpFile = [tmpDirectory stringByAppendingPathComponent:[avurlasset.URL lastPathComponent]];
        NSURL *fileURL = [NSURL fileURLWithPath:tmpFile];
        if([[NSFileManager defaultManager] copyItemAtURL:avurlasset.URL toURL:fileURL error:nil]) {
             resultHandler(fileURL);
        }
     }];
}

- (void) requestVideoPlayerForAsset:(PHAsset*) asset resultHandler:(void (^)(AVPlayer *__nullable playerItem))resultHandler{
    PHVideoRequestOptions *option = [PHVideoRequestOptions new];
    [option setNetworkAccessAllowed:YES];
    [option setDeliveryMode:PHVideoRequestOptionsDeliveryModeAutomatic];
    
    [self.photoManager requestPlayerItemForVideo:asset options:option resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
        AVPlayer* player = [[AVPlayer alloc]initWithPlayerItem:playerItem];
        resultHandler(player);
    }];
}

@end
