//
//  EBUIAPopoverTestsViewController.h
//  Cumber-Test
//
//  Created by Chip Snyder on 3/20/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBUIAPopoverTestsViewController : UIViewController
{
    UIPopoverController *popover;
}

@property (weak, nonatomic) IBOutlet UIButton *showPopoverButton;

- (IBAction)showPopover:(id)sender;
@end
