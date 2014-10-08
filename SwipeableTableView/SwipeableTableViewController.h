//
//  SwipeableTableViewController.h
//  SwipeableTableView
//
//  Created by Avismara on 06/10/14.
//  Copyright (c) 2014 Rare Mile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeableTableViewCell.h"


@interface SwipeableTableViewController : UITableViewController <SwipeableTableViewCellDataSource,SwipeableTableViewCellDelegate>

@end
