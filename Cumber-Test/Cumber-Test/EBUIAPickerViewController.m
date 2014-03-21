//
//  EBUIAPickerViewController.m
//  Cumber-Test
//
//  Created by Chip Snyder on 2/4/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import "EBUIAPickerViewController.h"
#import "EBPickerViewController.h"

@implementation EBUIAPickerViewController

@synthesize datePickerButton, showPickerButton;

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

- (IBAction)showDatePicker:(id)sender
{
    [pickerPopover dismissPopoverAnimated:YES];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setDate:[NSDate dateWithTimeIntervalSince1970:1395364172.180692]];
    
    UIViewController *datePickerController = [[UIViewController alloc] init];
    [[datePickerController view] addSubview:datePicker];
    [[datePickerController view] setAccessibilityLabel:@"datePicker"];
    
    UINavigationController *popoverNav = [[UINavigationController alloc] initWithRootViewController:datePickerController];
    
    UIBarButtonItem *acceptButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(selectDone:)];
    [acceptButton setAccessibilityLabel:@"AcceptButton"];
    
    [[datePickerController navigationItem] setRightBarButtonItem:acceptButton];
    
    pickerPopover = [[UIPopoverController alloc] initWithContentViewController:popoverNav];
    [pickerPopover setDelegate:self];
    
    CGSize size = CGSizeMake(320, (5 * 44) + 20);
    
    [pickerPopover setPopoverContentSize:size];
    
    [pickerPopover presentPopoverFromRect:[datePickerButton frame] inView:datePickerButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)selectDone:(id)sender
{
    [pickerPopover dismissPopoverAnimated:YES];
}

- (IBAction)showPicker:(id)sender
{
    [pickerPopover dismissPopoverAnimated:YES];
    
    EBPickerViewController *pickerController = [[EBPickerViewController alloc] init];
    
    UINavigationController *popoverNav = [[UINavigationController alloc] initWithRootViewController:pickerController];
    
    UIBarButtonItem *acceptButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(selectDone:)];
    [acceptButton setAccessibilityLabel:@"AcceptButton"];
    
    [[pickerController navigationItem] setRightBarButtonItem:acceptButton];
    
    pickerPopover = [[UIPopoverController alloc] initWithContentViewController:popoverNav];
    [pickerPopover setDelegate:self];
    
    CGSize size = CGSizeMake(350, (5 * 44) + 20);
    
    [pickerPopover setPopoverContentSize:size];
    
    [pickerPopover presentPopoverFromRect:[datePickerButton frame] inView:datePickerButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
@end
