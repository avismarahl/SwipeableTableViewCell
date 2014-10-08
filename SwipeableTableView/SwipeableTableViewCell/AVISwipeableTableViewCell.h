//
//  AVISwipeableTableViewCell.h
//  SwipeableTableView
//
//  Created by Avismara on 06/10/14.
//  Copyright (c) 2014 Avismara. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AVISwipeableTableViewCellDataSource;
@protocol AVISwipeableTableViewCellDelegate;


@interface AVISwipeableTableViewCell : UITableViewCell <UIGestureRecognizerDelegate> {
    CGFloat previousPanXPosition;
    CGFloat previousSlidingViewXPosition;
}

@property (nonatomic,strong) UIView *slidingView;
@property (nonatomic,weak) id <AVISwipeableTableViewCellDataSource> dataSource;
@property (nonatomic,weak) id <AVISwipeableTableViewCellDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *buttons;

- (id)initWithDelegate:(id<AVISwipeableTableViewCellDelegate>)delegate dataSource:(id<AVISwipeableTableViewCellDataSource>)dataSource;
- (void)closeSlidingView;

@end

@protocol AVISwipeableTableViewCellDataSource <NSObject>

@required
- (NSInteger)numberOfButtonsInSlidingViewForCell:(AVISwipeableTableViewCell*)cell;
- (UIButton*)swipeableTableViewCell:(AVISwipeableTableViewCell*) cell buttonForSlidingViewAtButtonIndex:(NSInteger)buttonIndex;

@optional
- (CGFloat)swipeableTableViewCell:(AVISwipeableTableViewCell*)cell widthOfButtonAtIndex:(NSInteger)index ;


@end

@protocol AVISwipeableTableViewCellDelegate <NSObject>

- (void)swipeableTableViewCell:(AVISwipeableTableViewCell*)cell didTapOnButton:(UIButton*)button buttonIndex:(NSInteger)buttonIndex;

- (BOOL)shouldSlideMenuBeOpenInCell:(AVISwipeableTableViewCell*)cell;


@end
