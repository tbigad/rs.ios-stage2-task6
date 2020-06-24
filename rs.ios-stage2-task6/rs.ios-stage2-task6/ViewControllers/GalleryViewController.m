//
//  GalleryViewController.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/21/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import "GalleryViewController.h"
#import "HeaderView.h"
#import "PhotoKitHelper.h"
#import "GalleryCollectionViewCell.h"
#import "DitailedViewController.h"
#import "UIColor+RSSchool.h"
#import "PopUpPreviewViewController.h"

@interface GalleryViewController ()< UICollectionViewDelegate, UICollectionViewDataSource, PhotoKitHelperDelegate>
@property (nonatomic,strong)UICollectionView* collectionView;
@property (nonatomic,strong)HeaderView* headerView;
@property (nonatomic,strong)PhotoKitHelper* galleryHelper;
@property (nonatomic, assign) CGSize cellSize;
@end

@implementation GalleryViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = (UIScreen.mainScreen.bounds.size.width / 3 ) - 16 - (2*2);
        _cellSize = CGSizeMake(itemWidth, itemWidth);
        flowLayout.itemSize = _cellSize;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        
        
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _galleryHelper = [[PhotoKitHelper alloc] initWithType:PhotoKitRequestTypeAll];
        _headerView = [[HeaderView alloc] init];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib: [UINib nibWithNibName:[GalleryCollectionViewCell reuseId] bundle:nil] forCellWithReuseIdentifier:[GalleryCollectionViewCell reuseId]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView setAllowsSelection:YES];
    
    [self.headerView setTitleText:@"Gallery"];
    [self.headerView setBackButtonIsHidden:YES];
    [self.view addSubview:self.headerView];
    
    [self.view addSubview:self.collectionView];
    
    self.galleryHelper.delegate = self;
    self.view.backgroundColor = [UIColor rsschoolWhiteColor];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self setupLoyaout];
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GalleryCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier: [GalleryCollectionViewCell reuseId] forIndexPath:indexPath];
    PHAsset* item = [self.galleryHelper itemAt:indexPath.item];
    cell.representedAssetIdentifier = item.localIdentifier;
    __weak typeof(cell) weakCell = cell;
    __weak typeof(item) weakItem = item;
    
    switch (item.mediaType) {
        case PHAssetMediaTypeUnknown:
            [cell setImage:[UIImage imageNamed:@"other"]];
            break;
        case PHAssetMediaTypeAudio:
            [cell setImage:[UIImage imageNamed:@"audio"]];
            break;
        case PHAssetMediaTypeVideo:
        case PHAssetMediaTypeImage:
            [self.galleryHelper requestImage:item targetSize:self.cellSize contentMode:PHImageContentModeAspectFit sync:YES resultHandler:^(UIImage * _Nullable result) {
                if ([weakCell.representedAssetIdentifier isEqualToString:weakItem.localIdentifier]) {
                    [weakCell setImage:result];
                }
            }];
            break;
    }
    
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.galleryHelper itemsCount];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //    DitailedViewController* ditailedVC = [[DitailedViewController alloc]init];
    //    [ditailedVC setModalPresentationStyle:UIModalPresentationFullScreen];
    PHAsset* item = [self.galleryHelper itemAt:indexPath.item];
    //    ditailedVC.representedAssetIdentifier = item.localIdentifier;
    //    ditailedVC.creationDate = item.creationDate;
    //    ditailedVC.modificationDate = item.modificationDate;
    //    ditailedVC.typeOfContent = [self.galleryHelper stringFromMediaType:item.mediaType];
    //    ditailedVC.imageName = [self.galleryHelper fileNameForAssets:item];
    //    ditailedVC.currentAsset = item;
    //    ditailedVC.helper = self.galleryHelper;
    //
    //    __weak typeof(ditailedVC) weakDitailedVC = ditailedVC;
    //    __weak typeof(item) weakItem = item;
    //    __weak typeof(self) weakSelf = self;
    //    [self.galleryHelper requestImage:item targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit sync:YES resultHandler:^(UIImage * _Nullable result) {
    //        if ([weakDitailedVC.representedAssetIdentifier isEqualToString:weakItem.localIdentifier]) {
    //            [weakDitailedVC setOriginalImage:result];
    //            [weakSelf presentViewController:weakDitailedVC animated:YES completion:nil];
    //        }
    //    }];
    
    PopUpPreviewViewController *preview = [[PopUpPreviewViewController alloc]init];
    preview.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    preview.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    __weak typeof(preview) weakDitailedVC = preview;
    if(item.mediaType == PHAssetMediaTypeVideo) {
        [self presentViewController:preview animated:YES completion:nil];
        [self.galleryHelper requestVideoPlayerForAsset:item resultHandler:^(AVPlayer * _Nullable playerItem) {
            dispatch_async(dispatch_get_main_queue(), ^{
                AVPlayerLayer* playerLayer = [AVPlayerLayer playerLayerWithPlayer:playerItem];
                [playerLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
                playerLayer.frame = weakDitailedVC.contentView.layer.bounds;
                [weakDitailedVC.contentView.layer addSublayer:playerLayer];
                [weakDitailedVC setPlayer:playerItem];
                [playerItem play];
            });
        }];
    } else {
        [self.galleryHelper requestImage:item targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit sync:YES resultHandler:^(UIImage * _Nullable result) {
            [weakDitailedVC setImage:result];
        }];
        [self presentViewController:preview animated:YES completion:nil];
    }
}

- (void) setupLoyaout {
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [self.headerView.heightAnchor constraintEqualToConstant:50.0f],
            [self.headerView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
            [self.headerView.trailingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.trailingAnchor],
            [self.headerView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor ],
            [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:8.0f],
            [self.view.safeAreaLayoutGuide.trailingAnchor constraintEqualToAnchor:self.collectionView.trailingAnchor constant:8.0f],
            [self.view.safeAreaLayoutGuide.bottomAnchor constraintEqualToAnchor:self.collectionView.bottomAnchor],
            [self.collectionView.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor constant:8.0f]
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [self.headerView.heightAnchor constraintEqualToConstant:50.0f],
            [self.headerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:8.0f],
            [self.headerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor ],
            [self.view.trailingAnchor constraintEqualToAnchor:self.collectionView.trailingAnchor constant:8.0f],
            [self.headerView.topAnchor constraintEqualToAnchor: self.topLayoutGuide.bottomAnchor],
            [self.bottomLayoutGuide.topAnchor constraintEqualToAnchor:self.collectionView.bottomAnchor],
            [self.headerView.bottomAnchor constraintEqualToAnchor:self.collectionView.topAnchor]
        ]];
    }
}

- (void)libraryDidChage:(PHFetchResultChangeDetails *)ditails {
    [self.collectionView reloadData];
}


@end
