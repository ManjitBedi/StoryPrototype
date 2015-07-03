//
//  ViewController.m
//  Story
//
//  Created by Manjit Bedi on 2013-05-17.
//  Copyright (c) 2013 Manjit Bedi. All rights reserved.
//

#import "ViewController.h"
#import "StoryParser.h"


static inline NSRegularExpression * NameRegularExpression() {
    static NSRegularExpression *_nameRegularExpression = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _nameRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"^\\w+" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    
    return _nameRegularExpression;
}

static inline NSRegularExpression * ParenthesisRegularExpression() {
    static NSRegularExpression *_parenthesisRegularExpression = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _parenthesisRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"\\([^\\(\\)]+\\)" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    
    return _parenthesisRegularExpression;
}


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadStoryResource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void) loadStoryResource {
    
    StoryParser *parser = [StoryParser sharedInstance];
    _sectionIndex = 0;
    
    // parse the content
    [parser loadAndParseStory:@"story_prologue"];
    
    // get the string for the content section from the first section.
    NSString *contentString  = [parser getSection:_sectionIndex];
    
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor darkGrayColor];
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.numberOfLines = 0;
    _contentLabel.opaque = NO;
    _contentLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contentLabel];
    [_contentLabel setText:contentString];
    
    // Search for links in the resource & set up a link
    NSError *error = nil;
    
    // A link looks like:  [[Next ->|Prologue 2]]
    // 'Next' is indicating the navigation direction
    // 'Prologue 2' is the desciptive tag
    NSString *regularExpression = @"\\[\\[(.*)\\]\\]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpression options:0 error:&error];
    
    [regex enumerateMatchesInString:contentString options:0 range:NSMakeRange(0, contentString.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {

        NSString *tag = [contentString substringWithRange:[result rangeAtIndex:0]];
        NSLog(@"tag '%@'", tag);
    }];
}


- (IBAction)prevSection:(id)sender {
    
    if(_sectionIndex > 0) {
        _sectionIndex--;
    
        NSString *string  = [[StoryParser sharedInstance] getSection:_sectionIndex];
        _contentLabel.text = string;
    }
}


- (IBAction)nextButton:(id)sender {

    StoryParser *parser = [StoryParser sharedInstance];
    if(_sectionIndex < [parser numberOfSections] -2) {
        _sectionIndex++;

        NSString *string  = [parser getSection:_sectionIndex];
        _contentLabel.text = string;
    }
}

#pragma mark - 
//- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTextCheckingResult:(NSTextCheckingResult *)result {
//    
//    NSString *string = [label.text substringWithRange:[result range]];
//    NSLog(@"link tapped %@, %@", result, string);
//    
//    NSArray *array = [string componentsSeparatedByString:@"|"];
//    NSString *string2 = [array objectAtIndex:1];
//    NSString *link = [string2 substringToIndex:[string2 length]- 2];
//    NSString *contentString = [[StoryParser sharedInstance] getSectionByTag:link];
//    
//    if(contentString) {
//        [_contentLabel setText:contentString];
//        // Note: do we need to clear any links?
//        NSError *error = nil;
//        NSString *regularExpression = @"\\[\\[(.*)\\]\\]";
//        NSString *testString = contentString;
//        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpression options:0 error:&error];
//        NSArray *matches = [regex matchesInString:testString options:0 range:NSMakeRange(0, [testString length])];
//        for (NSTextCheckingResult *match in matches) {
//            
//            [_contentLabel addLinkWithTextCheckingResult:match];
//        }
//    }
//}
@end
