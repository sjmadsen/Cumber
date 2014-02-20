//
//  EBUIAPickerViewController.m
//  Cumber-Test
//
//  Created by Chip Snyder on 2/4/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import "EBUIAPickerViewController.h"

@implementation EBUIAPickerViewController

@synthesize datePickerButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self setTitle:@"UIAPicker Tests"];
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    return self;
}

- (IBAction)showPicker:(id)sender
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    UIViewController *datePickerController = [[UIViewController alloc] init];
    [[datePickerController view] addSubview:datePicker];
    [[datePickerController view] setAccessibilityLabel:@"datePicker"];
    
    UINavigationController *popoverNav = [[UINavigationController alloc] initWithRootViewController:datePickerController];
    
    UIBarButtonItem *acceptButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(selectDone:)];
    [acceptButton setAccessibilityLabel:@"AcceptButton"];
    
    [[datePickerController navigationItem] setRightBarButtonItem:acceptButton];
    
    datePickerPopover = [[UIPopoverController alloc] initWithContentViewController:popoverNav];
    [datePickerPopover setDelegate:self];
    
    CGSize size = CGSizeMake(320, (5 * 44) + 20);
    
    [datePickerPopover setPopoverContentSize:size];
    
    [datePickerPopover presentPopoverFromRect:[datePickerButton frame] inView:datePickerButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)selectDone:(id)sender
{
    [datePickerPopover dismissPopoverAnimated:YES];
}

@end
