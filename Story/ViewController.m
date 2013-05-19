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
    
    [parser loadAndParseStory:@"story_prologue"];
    NSString *string  = [parser getSection:0];
    _contentTextView.text = string;
}


- (IBAction)prevSection:(id)sender {
    
}


- (IBAction)nextButton:(id)sender {

}
@end
