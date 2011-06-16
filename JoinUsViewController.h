//
//  JoinUsViewController.h
//  CCN
//
//  Created by Zachary Hariton on 3/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface JoinUsViewController : UIViewController {
    IBOutlet UIScrollView *ScrollView;
    IBOutlet UIButton *Button;
}

-(IBAction)ButtonPressed:(id)sender;

@property (nonatomic, retain) UIScrollView *ScrollView;
@property (nonatomic, retain) UIButton *Button;

@end