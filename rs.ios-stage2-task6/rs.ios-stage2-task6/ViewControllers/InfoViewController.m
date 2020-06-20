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

@interface InfoViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong)UITableView* tableView;
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
    
    self.galleryHelper = [[PhotoKitHelper alloc]init];
    [self.view addSubview:self.tableView];
    [self setupLoyaout];
}

- (void) setupLoyaout {
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
        [self.view.safeAreaLayoutGuide.leadingAnchor constraintEqualToAnchor:self.tableView.leadingAnchor],
        [self.view.safeAreaLayoutGuide.trailingAnchor constraintEqualToAnchor:self.tableView.trailingAnchor],
        [self.view.safeAreaLayoutGuide.bottomAnchor constraintEqualToAnchor:self.tableView.bottomAnchor],
        [self.view.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.tableView.topAnchor]
        ]];
    } else {
        [[self.tableView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor] setActive:YES];
        [[self.view.leadingAnchor constraintEqualToAnchor:self.tableView.leadingAnchor] setActive:YES];
        [[self.view.trailingAnchor constraintEqualToAnchor:self.tableView.trailingAnchor] setActive:YES];
        [[self.bottomLayoutGuide.topAnchor constraintEqualToAnchor:self.tableView.bottomAnchor] setActive:YES];
        [[self.topLayoutGuide.bottomAnchor constraintEqualToAnchor:self.tableView.topAnchor] setActive:YES];
    }
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PHAsset* item = [self.galleryHelper itemAt:indexPath.item];
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[InfoTableViewCell reuseId] forIndexPath:indexPath];
    [cell setMediaAsset:item];
    __weak typeof(cell) weakCell = cell;
    __weak typeof(item) weakItem = item;
    
    [self.galleryHelper requestImage:item targetSize:CGSizeMake(100.0f, 100.0f) contentMode:PHImageContentModeAspectFill resultHandler:^(UIImage * _Nullable result) {
        if ([weakCell.representedAssetIdentifier isEqualToString:weakItem.localIdentifier]) {
            [weakCell setImageLabel:result];
        }
    }];
    
    [self.galleryHelper requestFileNameForAssets:item resultHandler:^(NSString * _Nullable result) {
        [weakCell setFileName:result];
    }];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [self.galleryHelper itemsCount];
    return count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

@end
