//
//  EBUIAElementViewController.h
//  Cumber-Test
//
//  Created by Chip Snyder on 1/5/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBUIAElementViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *elementSearch;
@property (weak, nonatomic) IBOutlet UILabel *elementHidden;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *yellowButton;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;

- (IBAction)redButtonSelected:(id)sender;
- (IBAction)blueButtonSelected:(id)sender;
- (IBAction)yellowButtonSelected:(id)sender;

@end
