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
    double income = [self.calculator calculateOneNightPayFromStartHour:18 toEndHour:20 withBedTimeAt:19];
    XCTAssert(income > 0);
}

- (void)testWeCanStartAt5pm {
    double income = [self.calculator calculateOneNightPayFromStartHour:17 toEndHour:20 withBedTimeAt:19];
    XCTAssert(income > 0);
}

- (void)testWeCannotStartBefore5pm
{
    NSException *e = nil;
    @try {
        [self.calculator calculateOneNightPayFromStartHour:16 toEndHour:20 withBedTimeAt:19];
    }
    @catch (NSException *exception) {
        e = exception;
    }
    XCTAssert(e != nil && [e.name isEqualToString:INVALID_TIMES_ERROR]);
}

- (void)testWeCanStartAt11pm
{
    double income = [self.calculator calculateOneNightPayFromStartHour:23 toEndHour:3 withBedTimeAt:19];
    XCTAssert(income > 0);
}


- (void)testWeCanStartAtMidnight
{
    double income = [self.calculator calculateOneNightPayFromStartHour:0 toEndHour:3 withBedTimeAt:19];
    XCTAssert(income > 0);
}

- (void)testWeCanStartAfterMidnight
{
    double income = [self.calculator calculateOneNightPayFromStartHour:1 toEndHour:3 withBedTimeAt:19];
    XCTAssert(income > 0);
}

- (void)testWeCanEndAt4am
{
    double income = [self.calculator calculateOneNightPayFromStartHour:23 toEndHour:4 withBedTimeAt:19];
    XCTAssert(income > 0);
}

- (void)testWeCanEndAfter4am
{
    NSException *e = nil;
    @try {
        [self.calculator calculateOneNightPayFromStartHour:17 toEndHour:5 withBedTimeAt:19];
    }
    @catch (NSException *exception) {
        e = exception;
    }
    XCTAssert(e != nil && [e.name isEqualToString:INVALID_TIMES_ERROR]);
}

@end
