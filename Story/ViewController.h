//
//  ViewController.h
//  Story
//
//  Created by Manjit Bedi on 2013-05-17.
//  Copyright (c) 2013 Manjit Bedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTTAttributedLabel;

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) TTTAttributedLabel *contentLabel;
@property NSUInteger sectionIndex;

- (IBAction)prevSection:(id)sender;
- (IBAction)nextButton:(id)sender;
@end
