//
//  AVISwipeableTableViewCell.m
//  SwipeableTableView
//
//  Created by Avismara on 06/10/14.
//  Copyright (c) 2014 Avismara. All rights reserved.
//

#import "AVISwipeableTableViewCell.h"

@implementation AVISwipeableTableViewCell

#pragma mark Initializers
- (id)init {
    self = [super init];
    if(self) {
        [self commonInitializers];
    }
    return self;
    
}
- (void)commonInitializers {
    [self addPanGestureRecognizer];
    [self populateButtons];
    [self createSlidingView];
    [self openSlideMenuIfNeeded];
}

- (id)initWithDelegate:(id<AVISwipeableTableViewCellDelegate>)delegate {
    self = [super init];
    if(self) {
        self.delegate = delegate;
        [self commonInitializers];
        
    }
    return self;
}


#pragma mark - Helpers
- (void)populateButtons {
    NSInteger numberOfButtons = [self.delegate numberOfButtonsInSlidingViewForCell:self];
    self.buttons = [[NSMutableArray alloc]initWithCapacity:numberOfButtons];
    for(int i = 0; i < numberOfButtons ; i++) {
        UIButton *currentButton = [self.delegate swipeableTableViewCell:self buttonForSlidingViewAtButtonIndex:i];
        currentButton.tag = i;
        [currentButton addTarget:self action:@selector(leftAccessoryButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:currentButton];
    }
}

#pragma mark Sliding Menu Helpers
- (void)createSlidingView {
    self.slidingView = [[UIView alloc]init];
    CGFloat widthOfSlidingView = 0;
    CGFloat xPositionOfPreviousButton = 0;
    CGFloat xPostionOfCurrentButton = 0;
    for(int i = 0; i < self.buttons.count; i++) {
        CGFloat widthOfCurrentButton;
       
        UIButton *currentButton = [self.buttons objectAtIndex:i];
        if([self.delegate respondsToSelector:@selector(swipeableTableViewCell:widthOfButtonAtIndex:)]) {
            widthOfCurrentButton = [self.delegate swipeableTableViewCell:self widthOfButtonAtIndex:i];
        } else {
            [currentButton sizeToFit];
            CGSize buttonSize = currentButton.frame.size;
            widthOfCurrentButton = buttonSize.width;
        }
        currentButton.frame = CGRectMake(xPostionOfCurrentButton, 0, widthOfCurrentButton, self.contentView.frame.size.height);
        xPostionOfCurrentButton = xPostionOfCurrentButton + widthOfCurrentButton;
        [self.slidingView addSubview:currentButton];
        xPositionOfPreviousButton = currentButton.frame.origin.x;
        widthOfSlidingView = widthOfSlidingView + widthOfCurrentButton;
    }
    if(widthOfSlidingView > self.frame.size.width) {
        NSLog(@"Warning: Slide menu width is greater than the cell. Expect Inconsitencies");
    }
    self.slidingView.frame = CGRectMake(-widthOfSlidingView, 0, widthOfSlidingView,self.frame.size.height);
    self.slidingView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.slidingView];
}

- (void)openSlideMenuIfNeeded {
    if([self.delegate respondsToSelector:@selector(shouldSlideMenuBeOpenInCell:)]) {
        if([self.delegate shouldSlideMenuBeOpenInCell:self]) {
            self.slidingView.frame = CGRectMake(0, 0, self.slidingView.frame.size.width, self.slidingView.frame.size.height);
        }
    }
    
}

#pragma mark Pan Gesture helpers
- (void) addPanGestureRecognizer {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]init];
    [panGesture addTarget:self action:@selector(handlePanGesture:)];
    [self addGestureRecognizer:panGesture];
}


#pragma mark -
#pragma mark Event Handlers
- (void)handlePanGesture:(id)sender {
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer*)sender;
    CGFloat currentPanXPosition = [panGesture locationInView:self].x;
    
    
    if(panGesture.state == UIGestureRecognizerStateBegan) {
        previousPanXPosition = currentPanXPosition;
        previousSlidingViewXPosition = self.slidingView.frame.origin.x;
        return;
    }
   
    CGRect slidingViewFrame = self.slidingView.frame;
    CGFloat slidingViewWidth = self.slidingView.frame.size.width;
    CGFloat slidingViewXPosition = self.slidingView.frame.origin.x;
   
    currentPanXPosition = [panGesture locationInView:self].x;
    CGFloat xMovedDifference = currentPanXPosition - previousPanXPosition;
    CGPoint velocity = [panGesture velocityInView:self];
    
    CGFloat xPoints = self.frame.size.width;
    CGFloat velocityX = velocity.x;
    NSTimeInterval duration = xPoints / velocityX;
    CGPoint offScreenCenter = self.slidingView.center;
    offScreenCenter.x += xPoints;
    
    if(velocity.x > 0) {
        if(slidingViewXPosition <= 0) {
            CGFloat currentSlidingViewXPosition = previousSlidingViewXPosition + xMovedDifference;
            previousPanXPosition = currentPanXPosition;
            
            if(currentSlidingViewXPosition <= 0) {
                slidingViewFrame.origin.x = currentSlidingViewXPosition;
                previousSlidingViewXPosition = currentSlidingViewXPosition;
            } else {
                slidingViewFrame.origin.x =0;
                previousSlidingViewXPosition = 0;
            }
             self.slidingView.frame = slidingViewFrame;
        }
        if(panGesture.state == UIGestureRecognizerStateEnded) {
            if(duration > 0.5) {
                duration = 0.5;
            }
            [UIView animateWithDuration:duration animations:^{
                self.slidingView.frame = CGRectMake(0, 0, slidingViewWidth, self.slidingView.frame.size.height);
            }];
        }
    }
    
    if(velocity.x < 0) {
        if(slidingViewXPosition >= -slidingViewWidth ) {
            CGFloat currentSlidingViewXPosition = previousSlidingViewXPosition + xMovedDifference;
            previousPanXPosition = currentPanXPosition;
            if(currentSlidingViewXPosition >= -slidingViewWidth) {
                slidingViewFrame.origin.x = currentSlidingViewXPosition;
                previousSlidingViewXPosition = currentSlidingViewXPosition;
            } else {
                slidingViewFrame.origin.x = -slidingViewWidth;
                previousSlidingViewXPosition = -slidingViewWidth;
            }
            self.slidingView.frame = slidingViewFrame;
        }
        if(panGesture.state == UIGestureRecognizerStateEnded) {
            if(duration > 0.5) {
                duration = 0.5;
            }
            [UIView animateWithDuration:duration animations:^{
                self.slidingView.frame = CGRectMake(-slidingViewWidth, 0, slidingViewWidth, self.slidingView.frame.size.height);
            }];
        }
    }
}

- (void)leftAccessoryButtonTapped:(id)sender {
    UIButton *tappedButton = (UIButton*)sender;
    [self.delegate swipeableTableViewCell:self didTapOnButton:tappedButton buttonIndex:tappedButton.tag];
}

- (void)closeSlidingView {
    [UIView animateWithDuration:.5 animations:^{
        self.slidingView.frame = CGRectMake(-self.slidingView.frame.size.width, 0, self.slidingView.frame.size.width, self.slidingView.frame.size.height);
    }];
}

#pragma mark - Delegates
#pragma mark UIGestureRecognizer delegates
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint velocity = [panGestureRecognizer velocityInView:self];
        return fabs(velocity.y) > fabs(velocity.x);
    }
    
    return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer {
    if([panGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint velocity = [panGestureRecognizer velocityInView:self];
        return fabs(velocity.y) < fabs(velocity.x);
    }
    return NO;
}




@end
