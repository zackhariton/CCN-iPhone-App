//
//  Episode.h
//  CCN
//
//  Created by Zachary Hariton on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject {
	NSString *Name, *subTitle, *Image;	//Episode Data
    NSMutableArray *Body;
}

@property (nonatomic, retain) NSString *Name;
@property (nonatomic, retain) NSString *subTitle;
@property (nonatomic, retain) NSString *Image;
@property (nonatomic, retain) NSMutableArray *Body;

- (void) setName:(NSString *)newName setsubTitle:(NSString *)newsubTitle setImage:(NSString *)newImage setBody:(NSMutableArray *)newBody;
- (void) setName:(NSString *)newName;
- (void) setSubTitle:(NSString *)newSubTitle;
- (void) setImage:(NSString *)newImage;
- (void) setBody:(NSMutableArray *)newBody;
- (NSString*)getName;
- (NSString*)getsubTitle;
- (NSString*)getImage;
- (NSString*)getDescription;
- (NSMutableArray*)getBody;
- (Article*)deepCopy;

@end