//
//  UITableViewCell.h
//  SwipeableTableView
//
//  Created by Avismara on 06/10/14.
//  Copyright (c) 2014 Rare Mile. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SwipeableTableViewCellDataSource;
@protocol SwipeableTableViewCellDelegate;

typedef NS_ENUM(NSInteger, SlidingViewSwipingDirection) {
    SlidingViewSwipingDirectionRight,
    SlidingViewSwipingDirectionLeft
};


@interface SwipeableTableViewCell : UITableViewCell {
    CGFloat previousPanXPosition;
    CGFloat previousSlidingViewXPosition;
}

@property (nonatomic,strong) UIView *slidingView;
@property (nonatomic,weak) id <SwipeableTableViewCellDataSource> dataSource;
@property (nonatomic,weak) id <SwipeableTableViewCellDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *buttons;

- (id)initWithDelegate:(id<SwipeableTableViewCellDelegate>)delegate dataSource:(id<SwipeableTableViewCellDataSource>)dataSource;
- (void)closeSlidingView;

@end

@protocol SwipeableTableViewCellDataSource <NSObject>

@required
- (NSInteger)numberOfButtonsInSlidingViewForCell:(SwipeableTableViewCell*)cell;
- (UIButton*)swipeableTableViewCell:(SwipeableTableViewCell*) cell buttonForSlidingViewAtButtonIndex:(NSInteger)buttonIndex;

@optional
- (CGFloat)swipeableTableViewCell:(SwipeableTableViewCell*)cell widthOfButtonAtIndex:(NSInteger)index ;


@end

@protocol SwipeableTableViewCellDelegate <NSObject>

- (void)swipeableTableViewCell:(SwipeableTableViewCell*)cell didTapOnButton:(UIButton*)button buttonIndex:(NSInteger)buttonIndex;

- (BOOL)shouldSlideMenuBeOpenInCell:(SwipeableTableViewCell*)cell;


@end
