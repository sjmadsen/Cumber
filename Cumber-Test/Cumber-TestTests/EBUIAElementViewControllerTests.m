//
//  EBUIAElementViewControllerTests.m
//  Cumber-Test
//
//  Created by Chip Snyder on 1/19/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EBUIAElementViewController.h"

@interface EBUIAElementViewControllerTests : XCTestCase
{
    EBUIAElementViewController *controller;
}
@end

@implementation EBUIAElementViewControllerTests

- (void)setUp
{
    controller = [[EBUIAElementViewController alloc] init];
    [controller loadView];
    [controller viewDidLoad];
    
    [super setUp];
}

- (void)testElementSearchPresets
{
    XCTAssertEqualObjects([[controller elementSearch] accessibilityLabel], @"ElementSearch", @"The accessibility label should be 'ElementSearch'");
    XCTAssertEqualObjects([[controller elementSearch] accessibilityValue], @"Element Found", @"The accessibility value should be 'Element Found'");
    XCTAssertTrue(![[controller elementSearch] isHidden], @"The Element Search item should not be hidden");
}

- (void)testElementHiddenPresets
{
    XCTAssertEqualObjects([[controller elementHidden] accessibilityLabel], @"ElementHidden", @"The accessibility label should be 'ElementHidden'");
    XCTAssertEqualObjects([[controller elementHidden] accessibilityValue], @"Hidden", @"The accessibility value should be 'Hidden'");
    XCTAssertTrue([[controller elementHidden] isHidden], @"The Element Hidden item should be hidden");
}

- (void)testColorLabelPresets
{
    XCTAssertEqualObjects([[controller colorLabel] accessibilityLabel], @"colorLabel", @"The accessibility label should be 'colorLabel'");
    XCTAssertEqualObjects([[controller colorLabel] accessibilityValue], @"Red", @"The accessibility value should be 'Red'");
    XCTAssertTrue(![[controller colorLabel] isHidden], @"The Color Label item should not be hidden");
}

- (void)testRedButtonPresets
{
    XCTAssertEqualObjects([[controller redButton] accessibilityLabel], @"redButton", @"The accessibility label should be 'redButton'");
    XCTAssertEqualObjects([[controller redButton] titleForState:UIControlStateNormal], @"Red", @"The title should be 'Red'");
    XCTAssertTrue(![[controller redButton] isHidden], @"The Red Button item should not be hidden");
    XCTAssertTrue([[controller redButton] isSelected], @"The Red Button item should be selected");
    XCTAssertTrue(![[controller redButton] isEnabled], @"The Red Button item should not be enabled");
}

- (void)testBlueButtonPresets
{
    XCTAssertEqualObjects([[controller blueButton] accessibilityLabel], @"blueButton", @"The accessibility label should be 'blueButton'");
    XCTAssertEqualObjects([[controller blueButton] titleForState:UIControlStateNormal], @"Blue", @"The title should be 'Blue'");
    XCTAssertTrue(![[controller blueButton] isHidden], @"The Blue Button item should not be hidden");
    XCTAssertTrue(![[controller blueButton] isSelected], @"The Blue Button item should not be selected");
    XCTAssertTrue([[controller blueButton] isEnabled], @"The Blue Button item should be enabled");
}

- (void)testYellowButtonPresets
{
    XCTAssertEqualObjects([[controller yellowButton] accessibilityLabel], @"yellowButton", @"The accessibility label should be 'yellowButton'");
    XCTAssertEqualObjects([[controller yellowButton] titleForState:UIControlStateNormal], @"Yellow", @"The title should be 'Yellow'");
    XCTAssertTrue(![[controller yellowButton] isHidden], @"The Yellow Button item should not be hidden");
    XCTAssertTrue(![[controller yellowButton] isSelected], @"The Yellow Button item should not be selected");
    XCTAssertTrue([[controller yellowButton] isEnabled], @"The Yellow Button item should be enabled");
}

- (void)testBlueButtonPressed
{
    [controller blueButtonSelected:nil];
    
    XCTAssertTrue(![[controller yellowButton] isSelected], @"The Yellow Button item should not be selected");
    XCTAssertTrue([[controller yellowButton] isEnabled], @"The Yellow Button item should be enabled");
    
    XCTAssertTrue(![[controller redButton] isSelected], @"The Red Button item should not be selected");
    XCTAssertTrue([[controller redButton] isEnabled], @"The Red Button item should be enabled");
    
    XCTAssertTrue([[controller blueButton] isSelected], @"The Blue Button item should be selected");
    XCTAssertTrue(![[controller blueButton] isEnabled], @"The blue Button item should not be enabled");
    
    XCTAssertEqualObjects([[controller colorLabel] accessibilityValue], @"Blue", @"The accessibility value should be 'Blue'");
}

- (void)testYellowButtonPressed
{
    [controller yellowButtonSelected:nil];
    
    XCTAssertTrue([[controller yellowButton] isSelected], @"The Yellow Button item should be selected");
    XCTAssertTrue(![[controller yellowButton] isEnabled], @"The Yellow Button item should not be enabled");
    
    XCTAssertTrue(![[controller redButton] isSelected], @"The Red Button item should not be selected");
    XCTAssertTrue([[controller redButton] isEnabled], @"The Red Button item should be enabled");
    
    XCTAssertTrue(![[controller blueButton] isSelected], @"The Blue Button item should not be selected");
    XCTAssertTrue([[controller blueButton] isEnabled], @"The blue Button item should be enabled");
    
    XCTAssertEqualObjects([[controller colorLabel] accessibilityValue], @"Yellow", @"The accessibility value should be 'Yellow'");
}

- (void)testRedButtonPressed
{
    [controller yellowButtonSelected:nil];
    [controller redButtonSelected:nil];
    
    XCTAssertTrue(![[controller yellowButton] isSelected], @"The Yellow Button item should not be selected");
    XCTAssertTrue([[controller yellowButton] isEnabled], @"The Yellow Button item should be enabled");
    
    XCTAssertTrue([[controller redButton] isSelected], @"The Red Button item should be selected");
    XCTAssertTrue(![[controller redButton] isEnabled], @"The Red Button item should not be enabled");
    
    XCTAssertTrue(![[controller blueButton] isSelected], @"The Blue Button item should not be selected");
    XCTAssertTrue([[controller blueButton] isEnabled], @"The blue Button item should be enabled");
    
    XCTAssertEqualObjects([[controller colorLabel] accessibilityValue], @"Red", @"The accessibility value should be 'Red'");
}

@end
