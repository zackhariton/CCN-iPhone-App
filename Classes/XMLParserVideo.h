//
//  XMLParserVideo.h
//  CCN
//
//  Created by Zachary Hariton on 1/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>

@class XMLAppDelegate, Book;

@interface XMLParserVideo : NSObject {
	
	NSMutableString *currentElementValue;
	int currentElementShowLocation;
	BOOL useThisElement, firstElement;
	
	XMLAppDelegate *appDelegate;
	NSMutableArray *Shows;
}

@property (nonatomic, retain) NSMutableArray *Shows;

- (XMLParserVideo *) initXMLParser;
-(NSMutableArray*)getShows;

@end