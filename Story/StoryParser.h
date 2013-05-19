//
//  StoryParser.h
//  Story
//
//  Created by Manjit Bedi on 2013-05-18.
//  Copyright (c) 2013 Manjit Bedi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryParser : NSObject

+ (StoryParser *) sharedInstance;

/*
 * fileName : name of text file that conforms to the Twee text file format
 */
- (void) loadAndParseStory:(NSString *) fileName;
- (void) parseContents;
- (NSString *) getSection:(NSUInteger) index;

@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSString *contents;
@property (readonly) NSUInteger numberOfSections;

@end
