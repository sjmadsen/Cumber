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
    UIPopoverController *datePickerPopover;
}

@property (weak, nonatomic) IBOutlet UIButton *datePickerButton;

- (IBAction)showPicker:(id)sender;
@end
