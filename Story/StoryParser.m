//
//  StoryParser.m
//  Story
//
//  Created by Manjit Bedi on 2013-05-18.
//  Copyright (c) 2013 Manjit Bedi. All rights reserved.
//

#import "StoryParser.h"

@interface StoryParser () {
    
}

@property (nonatomic, strong) NSArray *sections;

@end

@implementation StoryParser

+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}


- (void) loadAndParseStory:(NSString *) fileName {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    self.contents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    if(_contents != nil) {
        
        [self parseContents];
    }
}


- (void) parseContents {
    
    // each section is delimieted by ":: "
    NSArray *wholeArray = [_contents componentsSeparatedByString:@"::"];
    NSRange theRange;
    theRange.location = 1;
    theRange.length = [wholeArray count] -1;
    self.sections = [wholeArray subarrayWithRange:theRange];
    _numberOfSection =  [_sections count];
    NSLog(@"number of sections %d", _numberOfSection);
}


- (NSString *) getSection:(NSUInteger) index{
    
    NSString *section = [_sections objectAtIndex:index];
    return  section;
}

@end
