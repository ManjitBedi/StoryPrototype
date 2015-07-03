//
//  ViewController.h
//  Story
//
//  Created by Manjit Bedi on 2013-05-17.
//  Copyright (c) 2013 Manjit Bedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;


@property NSUInteger sectionIndex;

- (IBAction)prevSection:(id)sender;
- (IBAction)nextButton:(id)sender;
@end
