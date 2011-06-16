#import "OverlayViewController.h"
#import "FirstViewController.h"

@implementation OverlayViewController

@synthesize rvController;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[rvController doneSearching_Clicked:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
	[rvController release];
    [super dealloc];
}


@end