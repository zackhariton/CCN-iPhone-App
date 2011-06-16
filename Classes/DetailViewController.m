//
//  DetailViewController.m
//  CCN
//
//  Created by Zachary Hariton on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "ImageDownload.h"

@implementation DetailViewController

@synthesize selectedTitle, Title, selectedSubTitle, subTitle, selectedBody, selectedImage, Image, loadImage, ScrollView, navigationBar;

int Height;   //Add to this for each new element.

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
	[super viewDidLoad];

    Height = 64;
    BOOL First = YES;
	Title.text = selectedTitle;
	subTitle.text = selectedSubTitle;
    self.navigationItem.title = navigationBar; //Set the title of the navigation bar
    
    ImageDownload *ImageDownloader = [[ImageDownload alloc] init];
    ImageDownloader.urlString = selectedImage;
    ImageDownloader.imageView = Image;
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setCenter:CGPointMake(281, 34)];
    [self.view addSubview:activityIndicator];
    ImageDownloader.activityIndicator = activityIndicator;
    [activityIndicator startAnimating];
    
    if (ImageDownloader.image == nil) {
        ImageDownloader.delegate = self;
    }
    
    NSString *NextIdentifier;
    for (NSString *currentString in selectedBody)   {
        if (First)
            First = NO;
        else if ([NextIdentifier isEqualToString:@"D"]) {
            UITextView *newDescription = [[UITextView alloc] initWithFrame:CGRectMake(0, Height, 320, 25)];
            newDescription.text = currentString;
            
            [self.view addSubview:newDescription];
            [newDescription release];
            
            [newDescription setFont:[UIFont systemFontOfSize:16]];
            CGRect tempFrame = newDescription.frame;
            tempFrame.size.height = newDescription.contentSize.height;
            newDescription.frame = tempFrame;
            newDescription.scrollEnabled = NO;
            newDescription.editable = NO;
            
            Height += newDescription.contentSize.height;
        }
        else if ([NextIdentifier isEqualToString:@"I"]) {
            UIImageView *newImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, Height, 300, 245)];
            [newImage setBackgroundColor:[UIColor lightGrayColor]];
            [self.view addSubview:newImage];
            [newImage release];
            Height += 240;
            
            ImageDownload *ImageDownloader = [[ImageDownload alloc] init];
            ImageDownloader.urlString = currentString;
            ImageDownloader.imageView = newImage;
            
            UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [activityIndicator setCenter:CGPointMake(160, Height - 123)];
            [self.view addSubview:activityIndicator];
            ImageDownloader.activityIndicator = activityIndicator;
            [activityIndicator startAnimating];
            if (ImageDownloader.image == nil) {
                ImageDownloader.delegate = self;
            }
        }
        else if ([NextIdentifier isEqualToString:@"V"]) {
            [self embedYouTube:currentString frame:CGRectMake(10, Height, 300, 245)];
            Height += 240;
        }
        NextIdentifier = currentString;
    }
    
    [ScrollView setContentSize:CGSizeMake(320, Height)];
}

- (void)downloadDidFinishDownloading:(ImageDownload *)download  {
    if (download.image != nil) {
        [download.activityIndicator stopAnimating];
        [download.activityIndicator release];
    }
    download.imageView.image = download.image;
}

- (void)embedYouTube:(NSString *)urlString frame:(CGRect)frame {
	NSString *embedHTML = @"\
    <html><head>\
	<style type=\"text/css\">\
	body {\
	background-color: transparent;\
	color: white;\
	}\
	</style>\
	</head><body style=\"margin:0\">\
    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
	width=\"%0.0f\" height=\"%0.0f\"></embed>\
    </body></html>";
	NSString *html = [NSString stringWithFormat:embedHTML, urlString, frame.size.width, frame.size.height];
	UIWebView *videoView = [[UIWebView alloc] initWithFrame:frame];
	[videoView loadHTMLString:html baseURL:nil];
    [[[videoView subviews] lastObject] setScrollEnabled:NO];
	[self.view addSubview:videoView];
	[videoView release];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
	//[selectedTitle release];
	//[Title release];
	//[selectedSubTitle release];
	//[subTitle release];
	//[selectedDescription release];
	//[Description release];
    [selectedBody release];
	[Image release];
	[ScrollView release];
	[super dealloc];
}


@end
