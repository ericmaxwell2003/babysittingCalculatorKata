//
//  BabySittingCalculatorTests.m
//  BabySittingCalculatorTests
//
//  Created by Eric Maxwell on 3/14/15.
//  Copyright (c) 2015 Credible Solutions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Calculator.h"

@interface BabySittingCalculatorTests : XCTestCase

@property (nonatomic, retain) Calculator* calculator;

@end

@implementation BabySittingCalculatorTests

- (void)setUp {
    [super setUp];
    self.calculator = [[Calculator alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCalculateOneNightPayReturnsNonIncomeGreaterThan0 {
    double income = [self.calculator calculateOneNightPayFromStartHour:18 toEndHour:20];
    XCTAssert(income > 0, @"First test should fail to be sure they're working!");
}

@end
