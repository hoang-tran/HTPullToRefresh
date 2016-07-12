//
//  HorizontalViewController.m
//  HTPullToRefreshDemo
//
//  Created by Hoang Tran on 7/11/16.
//  Copyright © 2016 Hoang Tran. All rights reserved.
//

#import "HorizontalViewController.h"
#import "SVPullToRefresh.h"
#import "SquareCell.h"

@interface HorizontalViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HorizontalViewController

NSString *kSquareCellReuseID = @"SquareCell";

@synthesize dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDataSource];
    [self setupPullToRefresh];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SquareCell" bundle:nil] forCellWithReuseIdentifier:kSquareCellReuseID];
}

#pragma mark - helper

- (void)setupDataSource {
    dataSource = [NSMutableArray array];
    for(int i = 1; i <= 20; i++) {
        [dataSource addObject:@(i)];
    }
}

- (void)setupPullToRefresh {
    __weak HorizontalViewController *weakSelf = self;

    [self.collectionView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtLeft];
    } position:SVPullToRefreshPositionLeft];

    [self.collectionView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtRight];
    } position:SVPullToRefreshPositionRight];

    for(SVPullToRefreshView *refreshView in self.collectionView.pullToRefreshViews) {
        refreshView.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        refreshView.titleLabel.numberOfLines = 0;
    }
}

- (void)insertRowAtLeft {
    __weak HorizontalViewController *weakSelf = self;
    NSInteger minValue = [[dataSource firstObject] integerValue];

    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.dataSource insertObject:@(minValue - 1) atIndex:0];
        [weakSelf.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];

        [[weakSelf.collectionView pullToRefreshViewAtPosition:SVPullToRefreshPositionLeft] stopAnimating];
    });
}

- (void)insertRowAtRight {
    __weak HorizontalViewController *weakSelf = self;
    NSInteger maxValue = [[dataSource lastObject] integerValue];

    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.dataSource addObject:@(maxValue + 1)];
        [weakSelf.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:weakSelf.dataSource.count - 1 inSection:0]]];

        [[weakSelf.collectionView pullToRefreshViewAtPosition:SVPullToRefreshPositionRight] stopAnimating];
    });
}

#pragma mark - collectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SquareCell *cell = (SquareCell*)[collectionView dequeueReusableCellWithReuseIdentifier:kSquareCellReuseID forIndexPath:indexPath];
    cell.titleLabel.text = [[dataSource objectAtIndex:indexPath.item] stringValue];
    return cell;
}

@end
