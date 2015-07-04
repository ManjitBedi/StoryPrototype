//
//  StoryParser.h
//  Story
//
//  Created by Manjit Bedi on 2013-05-18.
//  Copyright (c) 2013 Manjit Bedi. All rights reserved.
//
//  Given a Twine resource file, parse it's contents such that the sections can be used in this iOS app.
//

#import <Foundation/Foundation.h>

@interface StoryParser : NSObject

+ (StoryParser *) sharedInstance;


// given a resource filename open the file for processing
- (void) loadAndParseStory:(NSString *) fileName;

// Take the loaded data and parse the file & create foundation class representations of the data.
// A story is made up of sections.
// The sections are held in dictionary objects.
- (void) parseContents;

// Get the section by index in the story resource
- (NSString *) getSection:(NSUInteger) index;

// Get the section by the named tag.

- (NSString *) getSectionByTag:(NSString *) string;

@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSString *contents;
@property (readonly) NSUInteger numberOfSections;

@end
