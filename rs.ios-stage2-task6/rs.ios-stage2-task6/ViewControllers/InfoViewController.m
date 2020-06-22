//
//  InfoViewController.m
//  rs.ios-stage2-task6
//
//  Created by Pavel N on 6/19/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

#import "InfoViewController.h"
#import "PhotoKitHelper.h"
#import "UIColor+RSSchool.h"
#import "InfoTableViewCell.h"
#import "HeaderView.h"

@interface InfoViewController () <UITableViewDelegate, UITableViewDataSource, PhotoKitHelperDelegate>
@property (nonatomic,strong)UITableView* tableView;
@property (nonatomic,strong)HeaderView* headerView;
@property (nonatomic,strong)PhotoKitHelper* galleryHelper;
@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:[InfoTableViewCell reuseId] bundle:nil] forCellReuseIdentifier:[InfoTableViewCell reuseId]];
    [self.view addSubview:self.tableView];
    
    self.headerView = [[HeaderView alloc] init];
    [self.headerView setTitleText:@"info"];
    [self.view addSubview:self.headerView];
    
    self.galleryHelper = [[PhotoKitHelper alloc]initWithType:PhotoKitRequestTypeAll];
    self.galleryHelper.delegate = self;
    [self setupLoyaout];
}

- (void) setupLoyaout {
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [self.headerView.heightAnchor constraintEqualToConstant:50],
            [self.view.safeAreaLayoutGuide.leadingAnchor constraintEqualToAnchor:self.headerView.leadingAnchor],
            [self.view.safeAreaLayoutGuide.trailingAnchor constraintEqualToAnchor: self.headerView.trailingAnchor],
            [self.view.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor: self.headerView.topAnchor],
            [self.view.safeAreaLayoutGuide.leadingAnchor constraintEqualToAnchor:self.tableView.leadingAnchor],
            [self.view.safeAreaLayoutGuide.trailingAnchor constraintEqualToAnchor:self.tableView.trailingAnchor],
            [self.view.safeAreaLayoutGuide.bottomAnchor constraintEqualToAnchor:self.tableView.bottomAnchor],
            [self.headerView.bottomAnchor constraintEqualToAnchor:self.tableView.topAnchor]
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [self.headerView.heightAnchor constraintEqualToConstant:50],
            [self.headerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [self.view.leadingAnchor constraintEqualToAnchor:self.tableView.leadingAnchor],
            [self.headerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor ],
            [self.view.trailingAnchor constraintEqualToAnchor:self.tableView.trailingAnchor],
            [self.headerView.topAnchor constraintEqualToAnchor: self.topLayoutGuide.bottomAnchor],
            [self.bottomLayoutGuide.topAnchor constraintEqualToAnchor:self.tableView.bottomAnchor],
            [self.headerView.bottomAnchor constraintEqualToAnchor:self.tableView.topAnchor]
        ]];
    }
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PHAsset* item = [self.galleryHelper itemAt:indexPath.item];
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[InfoTableViewCell reuseId] forIndexPath:indexPath];
    cell.representedAssetIdentifier = item.localIdentifier;
    __weak typeof(cell) weakCell = cell;
    __weak typeof(item) weakItem = item;

    
    [self.galleryHelper requestImage:item targetSize:CGSizeMake(100.0f, 100.0f) contentMode:PHImageContentModeAspectFit sync:YES resultHandler:^(UIImage * _Nullable result) {
        
        if ([weakCell.representedAssetIdentifier isEqualToString:weakItem.localIdentifier]) {
            [weakCell setImageLabel:result];
        }
    }];
    

    switch (item.mediaType) {
        case PHAssetMediaTypeUnknown:
            [cell setCellStyle:InfoTableViewCellStyleOther];
            break;
        case PHAssetMediaTypeImage:
            [cell setCellStyle:InfoTableViewCellStylePhoto];
            [cell setDescriptionText:[[NSString alloc]initWithFormat:@"%lux%lu",item.pixelWidth,item.pixelHeight]];
            break;
        case PHAssetMediaTypeVideo:
            [cell setCellStyle:InfoTableViewCellStyleVideo];
            [cell setDescriptionText:[[NSString alloc]initWithFormat:@"%lux%lu %@",item.pixelWidth,item.pixelHeight, [self formatDuration:item.duration]]];
            break;
        case PHAssetMediaTypeAudio:
            [cell setCellStyle:InfoTableViewCellStyleAudio];
            [cell setDescriptionText:[[NSString alloc]initWithFormat:@"%@", [self formatDuration:item.duration]]];
            break;
    }
    
    [cell setFileName:[self.galleryHelper fileNameForAssets:item]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [self.galleryHelper itemsCount];
    return count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

- (NSString*)formatDuration:(NSTimeInterval)duration {
    int minutes = (int)duration / 60;
    int seconds = (int)duration % 60;

    NSString *time = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
    return time;
}

- (void)libraryDidChage:(nonnull PHFetchResultChangeDetails *)ditails {
    [self.tableView reloadData];
}


@end
