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

#pragma mark - Setup/Tear Down
- (void)setUp {
    [super setUp];
    self.calculator = [[Calculator alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - Sanity Check
- (void)testCalculateOneNightPayReturnsNonIncomeGreaterThan0 {
    double income = [self.calculator calculateOneNightPayFromStartHour:18 toEndHour:20 withBedTimeAt:19];
    XCTAssert(income > 0);
}

#pragma mark - Tests for Job Range Validation
- (void)testTimeRangesForStopAndStart {
    NSArray *times = @[@16, @17, @18, @19, @20, @21, @22, @23, @0, @1, @2, @3, @4, @5];
    int arbitraryBedtime = 19;
    for(int b = 0; b < times.count; b++) {
        for(int e = 0; e < times.count; e++) {
            BOOL expectException = (e < b) || // we know when the index of e < b that the end time is before the begin, which is invalid.
                                   // also if the begin or end index is at the first or last element in the times, because the values
                                   // at those indexes are just over the invalid mark either before or after the valid range.
                                   (e == 0 || e == (times.count - 1) || b == 0 || b == (times.count - 1));
            int startTime = [times[b] intValue];
            int endTime = [times[e] intValue];
            [self runWithTimes:startTime end:endTime bedtime:arbitraryBedtime expectingException:expectException];
        }
    }
}

- (void)runWithTimes:(int)start end:(int)end bedtime:(int)bedtime expectingException:(BOOL)expectingException
{
    NSLog(@"Testing: [self.calculator calculateOneNightPayFromStartHour:%d toEndHour:%d withBedTimeAt:%d] expectedException: %@",
          start, end, bedtime, (expectingException ? @"Yes": @"No"));
          
    NSException *e = nil;
    @try {
        [self.calculator calculateOneNightPayFromStartHour:start toEndHour:end withBedTimeAt:bedtime];
    }
    @catch (NSException *exception) {
        e = exception;
    }
    if(expectingException) {
        XCTAssert(e != nil && [e.name isEqualToString:INVALID_TIMES_ERROR]);
    } else {
        XCTAssert(e == nil);
    }
    
}

#pragma mark - Test Calculations
- (void)testCalculateOneNightPayReturnsNonIncomeGreaterThan0 {
    double income = [self.calculator calculateOneNightPayFromStartHour:18 toEndHour:20 withBedTimeAt:19];
    XCTAssert(income > 0);
}


@end
