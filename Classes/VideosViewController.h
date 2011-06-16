//
//  FirstViewController.h
//  CCN
//
//  Created by Zachary Hariton on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reachability;
@class OverlayViewController;

@interface FirstViewController : UITableViewController {
	NSMutableArray *Shows;
	NSMutableArray *copyShows;
	IBOutlet UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
	
	OverlayViewController *ovController;
    Reachability* hostReachable;
}

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;
- (void) loadShows;
- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;
- (void) checkNetworkStatus:(NSNotification *)notice;

@end