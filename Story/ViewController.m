//
//  ViewController.m
//  Story
//
//  Created by Manjit Bedi on 2013-05-17.
//  Copyright (c) 2013 Manjit Bedi. All rights reserved.
//

#import "ViewController.h"
#import "StoryParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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
    _contentTextView.text = string;
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
@end
