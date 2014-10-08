//
//  SwipeableTableViewController.m
//  SwipeableTableView
//
//  Created by Avismara on 06/10/14.
//  Copyright (c) 2014 Rare Mile. All rights reserved.
//

#import "AVISwipeableTableViewController.h"

#define kCELL @"SwipeableTableViewCell"

@implementation AVISwipeableTableViewController

- (instancetype)init {
    self = [super init];
    if(self) {
        [self.tableView registerClass:[AVISwipeableTableViewCell class] forCellReuseIdentifier:kCELL];
    }
    return  self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AVISwipeableTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCELL];
    if(cell == nil) {
        cell = [[AVISwipeableTableViewCell alloc]initWithDelegate:self dataSource:self];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AVISwipeableTableViewCell *cell =  (AVISwipeableTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell closeSlidingView];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfButtonsInSlidingViewForCell:(AVISwipeableTableViewCell *)cell {
    return 3;
}

- (UIButton *)swipeableTableViewCell:(AVISwipeableTableViewCell *)cell buttonForSlidingViewAtButtonIndex:(NSInteger)buttonIndex {
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:[NSString stringWithFormat:@"Hello %ld",(long)buttonIndex] forState:UIControlStateNormal];
    return button;
}

- (CGFloat)swipeableTableViewCell:(AVISwipeableTableViewCell *)cell widthOfButtonAtIndex:(NSInteger)index {
    return 80;
}

- (void)swipeableTableViewCell:(AVISwipeableTableViewCell *)cell didTapOnButton:(UIButton *)button buttonIndex:(NSInteger)buttonIndex {
    NSLog(@"ButtonIndex: %ld",(long)buttonIndex);
}

- (BOOL)shouldSlideMenuBeOpenInCell:(AVISwipeableTableViewCell *)cell {
    return NO;
}
@end
