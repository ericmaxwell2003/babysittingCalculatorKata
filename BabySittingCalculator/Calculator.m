//
//  Calculator.m
//  BabySittingCalculator
//
//  Created by Eric Maxwell on 3/14/15.
//  Copyright (c) 2015 Credible Solutions, Inc. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

- (double)calculateOneNightPayFromStartHour:(int)startHour toEndHour:(int)endHour
{
    
    if(![self isValidHour:startHour] || ![self isValidHour:endHour]) {
        [NSException raise:INVALID_TIMES_ERROR format:@"Time range given (%d,%d) is invalid, Valid range is from 5pm - 4am", startHour, endHour];
    }
    return 1.0;
}

- (BOOL)isValidHour:(int)time
{
    if([self isHourAm:time]) {
        return time <= 4; //  4am
    } else {
        return time >= 17; // 5pm
    }
}

- (BOOL)isHourAm:(int)hour
{
    return (hour - 12) < 0;
}

@end
