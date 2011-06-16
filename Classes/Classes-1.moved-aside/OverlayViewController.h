#import <UIKit/UIKit.h>

@class RootViewController;

@interface OverlayViewController : UIViewController {

	RootViewController *rvController;
}

@property (nonatomic, retain) RootViewController *rvController;

@end