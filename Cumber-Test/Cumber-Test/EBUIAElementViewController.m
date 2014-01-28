//
//  EBUIAElementViewController.m
//  Cumber-Test
//
//  Created by Chip Snyder on 1/5/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import "EBUIAElementViewController.h"

@implementation EBUIAElementViewController

@synthesize redButton, blueButton, yellowButton, colorLabel, imageView, delayedExistance, delayedEnabled;

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

-(void)viewDidLoad
{
    [super viewDidLoad];
    [imageView setImage:[UIImage imageNamed:@"BearImage"]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self countDownToShowingLabel];
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

- (void)countDownToShowingLabel
{
    displayTimer = [NSTimer timerWithTimeInterval:20 target:self selector:@selector(showDelayedExistanceLabel) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop]addTimer:displayTimer forMode:NSRunLoopCommonModes];
}

- (void)showDelayedExistanceLabel
{
    [displayTimer invalidate];
    displayTimer = nil;
    
    [delayedEnabled setEnabled:YES];
    
    CGRect frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y + imageView.frame.size.height + 20, imageView.frame.size.width, 50);
    delayedExistance = [[UILabel alloc] initWithFrame:frame];
    [delayedExistance setText:@"Delayed Existance Label"];
    [delayedExistance setAccessibilityLabel:@"delayedExistance"];
    
    [[self view] addSubview:delayedExistance];
}

@end
