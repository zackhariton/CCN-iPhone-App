//
//  XMLParserNews.m
//  CCN
//
//  Created by Zachary Hariton on 1/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XMLParserNews.h"
#import "VideosViewController.h"
#import "Show.h"
#import "Article.h"

@implementation XMLParserNews

@synthesize NewsItems;

- (XMLParserNews *) initXMLParser {
	
	[super init];
	
	appDelegate = (XMLAppDelegate *)[[UIApplication sharedApplication] delegate];
	NewsItems = [[NSMutableArray alloc] init];
	//firstElement = YES;
	
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"Article"])
        useThisElement = YES;
	else
		useThisElement = NO;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string { 
	if (useThisElement) {
		if(!currentElementValue)
			currentElementValue = [[NSMutableString alloc] initWithString:string];
		else
			[currentElementValue setString:string];
		currentElementValue = [currentElementValue stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
		currentElementValue = [currentElementValue stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if (useThisElement) {
		NSMutableArray *data = [[currentElementValue componentsSeparatedByString:@"~"] mutableCopy];
		Article *NewsItemTemp = [[Article alloc] init];
        [NewsItemTemp setName:[data objectAtIndex:0]];
        [NewsItemTemp setSubTitle:[data objectAtIndex:1]];
        [NewsItemTemp setImage:[data objectAtIndex:2]];
        [data removeObjectAtIndex:0];
        [data removeObjectAtIndex:0];
        [data removeObjectAtIndex:0];
        [NewsItemTemp setBody:data];
		[NewsItems addObject:NewsItemTemp];
		
		[NewsItemTemp release];	//Might cause crash
        useThisElement = NO;
	}
}

-(NSMutableArray*)getNewsItems	{
	return NewsItems;
}

- (void) dealloc {
	[NewsItems release];
	[currentElementValue release];
	[appDelegate release];
	[super dealloc];
}

@end
