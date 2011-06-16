//
//  XMLParserVideo.m
//  CCN
//
//  Created by Zachary Hariton on 1/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XMLParserVideo.h"
#import "VideosViewController.h"
#import "Show.h"
#import "Article.h"

@implementation XMLParserVideo

@synthesize Shows;

- (XMLParserVideo *) initXMLParser {
	
	[super init];
	
	appDelegate = (XMLAppDelegate *)[[UIApplication sharedApplication] delegate];
	Shows = [[NSMutableArray alloc] init];
	firstElement = YES;
	
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
		Article *episodeTemp = [[Article alloc] init];
        [episodeTemp setName:[data objectAtIndex:0]];
        [episodeTemp setSubTitle:[data objectAtIndex:1]];
        [episodeTemp setImage:[data objectAtIndex:2]];
        [data removeObjectAtIndex:0];
        [data removeObjectAtIndex:0];
        [data removeObjectAtIndex:0];
        [episodeTemp setBody:data];
        
        int Count = 0;
		currentElementShowLocation = -1;
        
        for (Show *showTemp in Shows)	{
			if ([[showTemp getName] isEqualToString:[episodeTemp getsubTitle]]) {
				currentElementShowLocation = Count;
			}
			Count++;
		}
        
		if (currentElementShowLocation == -1)	{
			Show *showTemp = [[Show alloc] init];
			NSMutableArray *episodesTemp = [[NSMutableArray alloc] init];
			[episodesTemp addObject:episodeTemp];
			[showTemp setEpisodes:episodesTemp];
			[showTemp setName:[episodeTemp getsubTitle]];
			[Shows addObject:showTemp];
			[showTemp release];	//Might cause crash
			//[episodesTemp release];
		}
		else	{
			[[Shows objectAtIndex:currentElementShowLocation] addEpisode:episodeTemp];
		}
		[currentElementValue setString:@""];
		[episodeTemp release];	//Might cause crash
        useThisElement = NO;
	}
}

-(NSMutableArray*)getShows	{
	return Shows;
}

- (void) dealloc {
	[Shows release];
	[currentElementValue release];
	[appDelegate release];
	[super dealloc];
}

@end
