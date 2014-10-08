//
//  SwipeableTableViewController.m
//  SwipeableTableView
//
//  Created by Avismara on 06/10/14.
//  Copyright (c) 2014 Rare Mile. All rights reserved.
//

#import "SwipeableTableViewController.h"

#define kCELL @"SwipeableTableViewCell"

@implementation SwipeableTableViewController

- (instancetype)init {
    self = [super init];
    if(self) {
        [self.tableView registerClass:[SwipeableTableViewCell class] forCellReuseIdentifier:kCELL];
    }
    return  self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SwipeableTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCELL];
    if(cell == nil) {
        cell = [[SwipeableTableViewCell alloc]initWithDelegate:self dataSource:self];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SwipeableTableViewCell *cell =  (SwipeableTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell closeSlidingView];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfButtonsInSlidingViewForCell:(SwipeableTableViewCell *)cell {
    return 4;
}

- (UIButton *)swipeableTableViewCell:(SwipeableTableViewCell *)cell buttonForSlidingViewAtButtonIndex:(NSInteger)buttonIndex {
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:[NSString stringWithFormat:@"Hello %ld",(long)buttonIndex] forState:UIControlStateNormal];
    return button;
}

- (CGFloat)swipeableTableViewCell:(SwipeableTableViewCell *)cell widthOfButtonAtIndex:(NSInteger)index {
    return 60;
}

- (void)swipeableTableViewCell:(SwipeableTableViewCell *)cell didTapOnButton:(UIButton *)button buttonIndex:(NSInteger)buttonIndex {
    NSLog(@"ButtonIndex: %ld",(long)buttonIndex);
}

- (BOOL)shouldSlideMenuBeOpenInCell:(SwipeableTableViewCell *)cell {
    return NO;
}
@end
