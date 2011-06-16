//
//  JoinUsViewController.m
//  CCN
//
//  Created by Zachary Hariton on 3/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JoinUsViewController.h"

@implementation JoinUsViewController

@synthesize ScrollView, Button;

- (void)viewDidLoad {
    [super viewDidLoad];
    //image.frame = CGRectMake(10, 44, 300, 195);
    //UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    //[self.view addSubview:button];
}

-(IBAction)ButtonPressed:(id)sender    {
    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
	mail.mailComposeDelegate = self;
    
    [mail setSubject:@"I want to join CCN!"];
    [mail setToRecipients:[NSArray arrayWithObject:@"clarkcablenetwork@gmail.com"]];
    [mail setMessageBody:@"I'd like to be put on the CCN email list." isHTML:NO];
    
    [self presentModalViewController:mail animated:YES];
    [mail release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error    {
    [self dismissModalViewControllerAnimated:YES];
}

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
