//
//  DetailViewController.h
//  CCN
//
//  Created by Zachary Hariton on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController {
	IBOutlet UILabel *Title;
	IBOutlet UILabel *subTitle;
	//IBOutlet UITextView *Description;
	IBOutlet UIScrollView *ScrollView;
	IBOutlet UIImageView *Image;
	NSString *selectedTitle, *selectedSubTitle, *selectedImage, *navigationBar;
    NSMutableArray *selectedBody;
	NSThread *loadImage;
	BOOL videoExists;
}

- (void)embedYouTube:(NSString *)urlString frame:(CGRect)frame;

@property (nonatomic, retain) NSString *selectedTitle;
@property (nonatomic, retain) NSString *selectedSubTitle;
@property (nonatomic, retain) NSString *selectedImage;
@property (nonatomic, retain) NSString *navigationBar;
@property (nonatomic, retain) NSMutableArray *selectedBody;
@property (nonatomic, retain) UIScrollView *ScrollView;
@property (nonatomic, retain) UIImageView *Image;
@property (nonatomic, retain) NSThread *loadImage;
@property (assign) IBOutlet UILabel *Title;
@property (assign) IBOutlet UILabel *subTitle;

@end