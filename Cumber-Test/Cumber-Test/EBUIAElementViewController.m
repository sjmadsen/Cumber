//
//  EBUIAElementViewController.m
//  Cumber-Test
//
//  Created by Chip Snyder on 1/5/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import "EBUIAElementViewController.h"

@implementation EBUIAElementViewController

@synthesize redButton, blueButton, yellowButton, colorLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        [self setTitle:@"UIAElement Tests"];
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    return self;
}


- (IBAction)redButtonSelected:(id)sender
{
    [colorLabel setText:@"Red"];
    
    [redButton setSelected:YES];
    [redButton setEnabled:NO];
    
    [yellowButton setSelected:NO];
    [yellowButton setEnabled:YES];
    
    [blueButton setSelected:NO];
    [blueButton setEnabled:YES];
}

- (IBAction)blueButtonSelected:(id)sender
{
    [colorLabel setText:@"Blue"];
    
    [redButton setSelected:NO];
    [redButton setEnabled:YES];
    
    [yellowButton setSelected:NO];
    [yellowButton setEnabled:YES];
    
    [blueButton setSelected:YES];
    [blueButton setEnabled:NO];
}

- (IBAction)yellowButtonSelected:(id)sender
{
    [colorLabel setText:@"Yellow"];
    
    [redButton setSelected:NO];
    [redButton setEnabled:YES];
    
    [yellowButton setSelected:YES];
    [yellowButton setEnabled:NO];
    
    [blueButton setSelected:NO];
    [blueButton setEnabled:YES];
}

@end
