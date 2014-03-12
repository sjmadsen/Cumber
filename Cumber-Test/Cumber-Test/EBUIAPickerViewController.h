//
//  EBUIAPickerViewController.h
//  Cumber-Test
//
//  Created by Chip Snyder on 2/4/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBUIAPickerViewController : UIViewController <UIPopoverControllerDelegate>
{
    UIPopoverController *pickerPopover;
}

@property (weak, nonatomic) IBOutlet UIButton *datePickerButton;
@property (weak, nonatomic) IBOutlet UIButton *showPickerButton;

- (IBAction)showDatePicker:(id)sender;
- (IBAction)showPicker:(id)sender;
@end
