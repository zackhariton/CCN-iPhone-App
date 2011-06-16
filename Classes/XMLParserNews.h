//
//  XMLParserNews.h
//  CCN
//
//  Created by Zachary Hariton on 1/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>

@class XMLAppDelegate, Book;

@interface XMLParserNews : NSObject {
	
	NSMutableString *currentElementValue;
	BOOL useThisElement, firstElement;
	
	XMLAppDelegate *appDelegate;
	NSMutableArray *NewsItems;
}

@property (nonatomic, retain) NSMutableArray *NewsItems;

- (XMLParserNews *) initXMLParser;
-(NSMutableArray*)getNewsItems;

@end