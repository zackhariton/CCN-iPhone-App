//
//  FirstViewController.h
//  CCN
//
//  Created by Zachary Hariton on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OverlayViewController;

@interface NewsViewController : UITableViewController {
	NSMutableArray *NewsItems;
	NSMutableArray *copyNewsItems;
	IBOutlet UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
	
	OverlayViewController *ovController;
}

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;
- (void) loadNewsItems;
- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;

@end