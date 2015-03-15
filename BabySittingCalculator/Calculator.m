//
//  Calculator.m
//  BabySittingCalculator
//
//  Created by Eric Maxwell on 3/14/15.
//  Copyright (c) 2015 Credible Solutions, Inc. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

- (double)calculateOneNightPayFromStartHour:(int)startHour toEndHour:(int)endHour withBedTimeAt:(int)bedtime
{
    
    if(![self isStartOrEndHour:startHour] || ![self isStartOrEndHour:endHour] || ![self isValidBedtime:bedtime]) {
        [NSException raise:INVALID_TIMES_ERROR format:@"Time range given (%d,%d,%d) is invalid, Valid range is from 5pm - 4am, and bedtime should fall within that range", startHour, endHour, bedtime];
    }
    return 1.0;
}

- (BOOL)isValidBedtime:(int)time
{
    return time >= 0 && time <= 23;
}

- (BOOL)isStartOrEndHour:(int)time
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
