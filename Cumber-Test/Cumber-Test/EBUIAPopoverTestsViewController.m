//
//  EBUIAPopoverTestsViewController.m
//  Cumber-Test
//
//  Created by Chip Snyder on 3/20/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import "EBUIAPopoverTestsViewController.h"

@implementation EBUIAPopoverTestsViewController

@synthesize showPopoverButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        [self setTitle:@"UIAPopover Tests"];
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    return self;
}

- (IBAction)showPopover:(id)sender
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 250, 30)];
    [label setText:@"Popover is being displayed"];
    [label setAccessibilityLabel:@"popoverLabel"];
    
    UIViewController *popoverView = [[UIViewController alloc] init];
    [[popoverView view] setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [[popoverView view] addSubview:label];
    
    popover = [[UIPopoverController alloc] initWithContentViewController:popoverView];
    [[popoverView view] setAccessibilityLabel:@"testPopover"];
    
    [popover presentPopoverFromRect:[showPopoverButton frame] inView:showPopoverButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

@end
