//
//  EBMenuTableViewController.m
//  Cumber-Test
//
//  Created by Chip Snyder on 1/24/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import "EBMenuTableViewController.h"
#import "EBConstants.h"
#import "EBUIAElementViewController.h"
#import "EBUIAKeyboardViewController.h"
#import "EBUIAAlertViewController.h"
#import "EBUIAPickerViewController.h"
#import "EBUIATableTestsViewController.h"

@implementation EBMenuTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        [self setTitle:@"Test Classes"];
    }
    return self;
}

#pragma mark - Table view data source

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self tableView] setAccessibilityLabel:@"testTable"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch ([indexPath row])
    {
        case UIAElementTests:
            cell = [self setCellForUIAElementTests:cell];
            break;
            
        case UIAKeyboardTests:
            cell = [self setCellForUIAKeyboardTests:cell];
            break;
            
        case UIAAlertTests:
            cell = [self setCellForUIAAlertTests:cell];
            break;
            
        case UIAPickerTests:
            cell = [self setCellForUIAPickerTests:cell];
            break;
            
        case UIATableTests:
            cell = [self setCellForUIATableTests:cell];
            break;
            
        default:
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row])
    {
        case UIAElementTests:
            [self pushUIAElementTestScreen];
            break;
            
        case UIAKeyboardTests:
            [self pushUIAKeyboardTestScreen];
            break;
            
        case UIAAlertTests:
            [self pushUIAAlertTestScreen];
            break;
            
        case UIAPickerTests:
            [self pushUIAPickerTestScreen];
            break;
            
        case UIATableTests:
            [self pushUIATableTestScreen];
            break;
            
            
        default:
            break;
    }
}

#pragma mark UIAElement Tests

- (UITableViewCell *)setCellForUIAElementTests:(UITableViewCell *)cell
{
    [[cell textLabel] setText:@"UIAElement Tests"];
    [cell setAccessibilityLabel:@"UIAElement Tests"];
    return cell;
}

- (void)pushUIAElementTestScreen
{
    EBUIAElementViewController *elementTests = [[EBUIAElementViewController alloc] init];
    [[self navigationController] pushViewController:elementTests animated:YES];
}

#pragma mark UIAKeyboard Tests

- (UITableViewCell *)setCellForUIAKeyboardTests:(UITableViewCell *)cell
{
    [[cell textLabel] setText:@"UIAKeyboard Tests"];
    [cell setAccessibilityLabel:@"UIAKeyboard Tests"];
    return cell;
}

- (void)pushUIAKeyboardTestScreen
{
    EBUIAKeyboardViewController *keyboardTests = [[EBUIAKeyboardViewController alloc] init];
    [[self navigationController] pushViewController:keyboardTests animated:YES];
}

#pragma mark UIAAlert Tests

- (UITableViewCell *)setCellForUIAAlertTests:(UITableViewCell *)cell
{
    [[cell textLabel] setText:@"UIAAlert Tests"];
    [cell setAccessibilityLabel:@"UIAAlert Tests"];
    return cell;
}

- (void)pushUIAAlertTestScreen
{
    EBUIAAlertViewController *alertTests = [[EBUIAAlertViewController alloc] init];
    [[self navigationController] pushViewController:alertTests animated:YES];
}

#pragma mark UIAPicker Tests

- (UITableViewCell *)setCellForUIAPickerTests:(UITableViewCell *)cell
{
    [[cell textLabel] setText:@"UIAPicker Tests"];
    [cell setAccessibilityLabel:@"UIAPicker Tests"];
    return cell;
}

- (void)pushUIAPickerTestScreen
{
    EBUIAPickerViewController *pickerTests = [[EBUIAPickerViewController alloc] init];
    [[self navigationController] pushViewController:pickerTests animated:YES];
}

#pragma mark UIAPicker Tests

- (UITableViewCell *)setCellForUIATableTests:(UITableViewCell *)cell
{
    [[cell textLabel] setText:@"UIATable Tests"];
    [cell setAccessibilityLabel:@"UIATable Tests"];
    return cell;
}

- (void)pushUIATableTestScreen
{
    EBUIATableTestsViewController *tableTests = [[EBUIATableTestsViewController alloc] init];
    [[self navigationController] pushViewController:tableTests animated:YES];
}

@end
