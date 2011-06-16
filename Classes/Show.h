//
//  Show.h
//  CCN
//
//  Created by Zachary Hariton on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Article.h"

@interface Show : NSObject {
	NSString *Name;	//Name of Show
	NSMutableArray *Episodes;	//Array of Episodes
}

@property (nonatomic, retain) NSString *Name;
@property (nonatomic, retain) NSMutableArray *Episodes;

-(void)addEpisode:(Article*)episode;
-(void)setEpisodes:(NSMutableArray *)newEpisodes;
-(void)setName:(NSString *)newName;
-(NSMutableArray*)getEpisodes;
-(NSMutableArray*)getEpisodeNames;
-(NSString*)getName;
-(Show*)deepCopy;

@end