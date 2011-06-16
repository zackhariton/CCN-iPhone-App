//
//  Show.m
//  CCN
//
//  Created by Zachary Hariton on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Show.h"
#import "Article.h"

@implementation Show

@synthesize Name, Episodes;

-(void)addEpisode:(Article*)episode	{
	if (Episodes) {
		[Episodes addObject:episode];
	}
	else {
		Episodes = [[NSMutableArray alloc] init];
		[Episodes addObject:episode];
	}
}

-(void)setEpisodes:(NSMutableArray *)newEpisodes	{
	Episodes = newEpisodes;
}

-(NSMutableArray*)getEpisodes	{
	return Episodes;
}

-(NSMutableArray*)getEpisodeNames	{
	NSMutableArray *EpisodeNames;
	for (Article *currentEpisode in Episodes)	{
		[EpisodeNames addObject:[currentEpisode getName]];
	}
	return EpisodeNames;
}

-(NSString*)getName	{
	return Name;
}

-(void)setName:(NSString *)newName	{
	Name = newName;
}

-(Show*)deepCopy	{
	Show *copy = [[Show alloc] init];
	[copy setName:[Name copy]];
	for (Article *tempEpisode in Episodes)	{
		[copy addEpisode:[tempEpisode deepCopy]];
	}
	return copy;
}

-(void)dealloc	{
	[Name release];
	[Episodes release];
	[super dealloc];
}

@end