//
//  Episode.m
//  CCN
//
//  Created by Zachary Hariton on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Article.h"

@implementation Article

@synthesize Name, subTitle, Image, Body;

- (void) setName:(NSString *)newName setsubTitle:(NSString *)newsubTitle setImage:(NSString *)newImage setBody:(NSMutableArray *)newBody	{
	Name = newName;
	subTitle = newsubTitle;
    Image = newImage;
    Body = newBody;
}

- (void) setBody:(NSMutableArray *)newBody  {
    Body = newBody;
}

- (void) setName:(NSString *)newName    {
    Name = newName;
}
- (void) setSubTitle:(NSString *)newSubTitle    {
    subTitle = newSubTitle;
}
- (void) setImage:(NSString *)newImage  {
    Image = newImage;
}

- (NSMutableArray*) getBody {
    return Body;
}

- (NSString*)getName	{
	return Name;
}

- (NSString*)getsubTitle	{
	return subTitle;
}

- (NSString*)getImage   {
    return Image;
}

- (NSString*)getDescription {
    NSString *Result = [[NSString alloc] init];
    BOOL UseNext = NO;
    for (NSString *currentString in Body)   {
        if ([currentString isEqualToString:@"D"]) {
            UseNext = YES;
        }
        else if (UseNext)    {
            if (Result == nil)
                Result = [NSString stringWithFormat:@"%@%@", currentString, @" "];
            else
                Result = [NSString stringWithFormat:@"%@%@%@", Result, currentString, @" "];
            UseNext = NO;
        }
    }
    return Result;
}

- (Article*)deepCopy	{
	Article *copy = [[Article alloc] init];
    NSMutableArray *bodyCopy = [[NSMutableArray alloc] initWithArray:Body copyItems:YES];
    [copy setName:[Name copy]];
    [copy setSubTitle:[subTitle copy]];
    [copy setImage:[Image copy]];
    [copy setBody:bodyCopy];
	return copy;
}

-(void)dealloc	{
	[Name release];
	[subTitle release];
    [Body release];
	[super dealloc];
}

@end