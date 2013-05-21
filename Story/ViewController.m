//
//  ViewController.m
//  Story
//
//  Created by Manjit Bedi on 2013-05-17.
//  Copyright (c) 2013 Manjit Bedi. All rights reserved.
//

#import "ViewController.h"
#import "StoryParser.h"
#import "TTTAttributedLabel.h"

static CGFloat const kEspressoDescriptionTextFontSize = 17.0f;

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
	// Do any additional setup after loading the view, typically from a nib.
    
    self.contentLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor darkGrayColor];
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.numberOfLines = 0;
    
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
    [parser loadAndParseStory:@"story_prologue"];
    NSString *string  = [parser getSection:_sectionIndex];
    
    
    
    self.contentLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 360)];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor darkGrayColor];
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.numberOfLines = 0;
    _contentLabel.opaque = NO;
    _contentLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contentLabel];
    _contentLabel.delegate = (id) self;
    [_contentLabel setText:string];
    
    NSError *error = nil;
    NSString *regularExpression = @"\\[\\[(.*)\\]\\]";
    NSString *testString = string;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpression options:0 error:&error];
    NSArray *matches = [regex matchesInString:testString options:0 range:NSMakeRange(0, [testString length])];
    for (NSTextCheckingResult *match in matches) {

        [_contentLabel addLinkWithTextCheckingResult:match];
    }
}


- (IBAction)prevSection:(id)sender {
    
    if(_sectionIndex > 0) {
        _sectionIndex--;
    
        NSString *string  = [[StoryParser sharedInstance] getSection:_sectionIndex];
        _contentTextView.text = string;
    }
}


- (IBAction)nextButton:(id)sender {

    StoryParser *parser = [StoryParser sharedInstance];
    if(_sectionIndex < [parser numberOfSections] -2) {
        _sectionIndex++;

        NSString *string  = [parser getSection:_sectionIndex];
        _contentTextView.text = string;
    }
}

#pragma mark - 
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTextCheckingResult:(NSTextCheckingResult *)result {
    
    NSString *string = [label.text substringWithRange:[result range]];
    NSLog(@"link tapped %@, %@", result, string);
    
    NSArray *array = [string componentsSeparatedByString:@"|"];
    NSString *string2 = [array objectAtIndex:1];
    NSString *link = [string2 substringToIndex:[string2 length]- 2];
    NSString *contentString = [[StoryParser sharedInstance] getSectionByTag:link];
    
    if(contentString) {
        [_contentLabel setText:contentString];
        // Note: do we need to clear any links?
        NSError *error = nil;
        NSString *regularExpression = @"\\[\\[(.*)\\]\\]";
        NSString *testString = contentString;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpression options:0 error:&error];
        NSArray *matches = [regex matchesInString:testString options:0 range:NSMakeRange(0, [testString length])];
        for (NSTextCheckingResult *match in matches) {
            
            [_contentLabel addLinkWithTextCheckingResult:match];
        }
    }
}
@end
