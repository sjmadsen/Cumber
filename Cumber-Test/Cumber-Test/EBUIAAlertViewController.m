//
//  EBUIAAlertViewController.m
//  Cumber-Test
//
//  Created by Chip Snyder on 1/31/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import "EBUIAAlertViewController.h"

@implementation EBUIAAlertViewController

@synthesize resultText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        [self setTitle:@"UIAAlert Tests"];
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    return self;
}

- (IBAction)popAlert:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert Title" message:@"Alert Message" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [resultText setText:@"Canceled"];
    }
    else if (buttonIndex == 1)
    {
        [resultText setText:@"Confirmed"];
    }
}

@end
