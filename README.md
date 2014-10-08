SwipeableTableViewCell
======================

An UITableViewCell subclass that lets you add your custom buttons drawer.

Important delegates: 

- (NSInteger)numberOfButtonsInSlidingViewForCell:(AVISwipeableTableViewCell*)cell
Supply the number of buttons that your sliding view holds. Note that if you add more number of buttons, it compromises
with the structure of the cell and might make it look ugly.


- (UIButton*)swipeableTableViewCell:(AVISwipeableTableViewCell*) cell buttonForSlidingViewAtButtonIndex:(NSInteger)buttonIndex
Supply your button at the given index. You need not have to add target to this button. Whenever these buttons are clicked
the events are notfied accordingly. 


- (CGFloat)swipeableTableViewCell:(AVISwipeableTableViewCell*)cell widthOfButtonAtIndex:(NSInteger)index
Supply the width of each button.

- (void)swipeableTableViewCell:(AVISwipeableTableViewCell*)cell didTapOnButton:(UIButton*)button buttonIndex:(NSInteger)buttonIndex;
You can recieve the button click events in this delegate. You can identify the button index by the variable buttonIndex.

- (BOOL)shouldSlideMenuBeOpenInCell:(AVISwipeableTableViewCell*)cell;
return YES if you want the sliding menu to be open by default. 

Usage:

1. Copy the .h .m files of SwipableTableViewCell that are present in the example project. 
2. Subclass your custom cell with SwipableTableViewCell as the parent.
3. Implement SwipeTableViewCellDelegates and supply the data. 
4. Have a cup of coffee. 


