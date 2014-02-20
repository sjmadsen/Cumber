//
//  EBUIAAlertViewController.h
//  Cumber-Test
//
//  Created by Chip Snyder on 1/31/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBUIAAlertViewController : UIViewController <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *resultText;

- (IBAction)popAlert:(id)sender;

@end
