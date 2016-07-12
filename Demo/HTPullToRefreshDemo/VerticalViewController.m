//
//  VerticalViewController.m
//  HTPullToRefreshDemo
//
//  Created by Hoang Tran on 7/11/16.
//  Copyright © 2016 Hoang Tran. All rights reserved.
//

#import "VerticalViewController.h"
#import "SVPullToRefresh.h"

NSString *kVerticalCellReuseID = @"kVerticalCellReuseID";

@interface VerticalViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation VerticalViewController

@synthesize dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDataSource];
    [self setupPullToRefresh];
}

#pragma mark - helper

- (void)setupDataSource {
    dataSource = [NSMutableArray array];
    for(int i = 1; i <= 20; i++) {
        [dataSource addObject:@(i)];
    }
}

- (void)setupPullToRefresh {
    __weak VerticalViewController *weakSelf = self;

    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    } position:SVPullToRefreshPositionTop];

    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    } position:SVPullToRefreshPositionBottom];
}


- (void)insertRowAtTop {
    __weak VerticalViewController *weakSelf = self;
    NSInteger minValue = [[dataSource firstObject] integerValue];

    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.tableView beginUpdates];
        [weakSelf.dataSource insertObject:@(minValue - 1) atIndex:0];
        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [weakSelf.tableView endUpdates];
        
        [[weakSelf.tableView pullToRefreshViewAtPosition:SVPullToRefreshPositionTop] stopAnimating];
    });
}

- (void)insertRowAtBottom {
    __weak VerticalViewController *weakSelf = self;
    NSInteger maxValue = [[dataSource lastObject] integerValue];

    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.tableView beginUpdates];
        [weakSelf.dataSource addObject:@(maxValue + 1)];
        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.dataSource.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [weakSelf.tableView endUpdates];

        [[weakSelf.tableView pullToRefreshViewAtPosition:SVPullToRefreshPositionBottom] stopAnimating];
    });
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kVerticalCellReuseID];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kVerticalCellReuseID];
    }
    cell.textLabel.text = [[dataSource objectAtIndex:indexPath.row] stringValue];
    return cell;
}

@end
