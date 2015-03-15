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
    
    if(![self isWorkDurationValidForStartHour:startHour andEndHour:endHour] || ![self isValidBedtime:bedtime]) {
        [NSException raise:INVALID_TIMES_ERROR format:@"Time range given (%d,%d,%d) is invalid, Valid range is from 5pm - 4am, and bedtime should fall within that range", startHour, endHour, bedtime];
    }
    
    int hoursAtMidnightRate = 0;
    if([self isHourAm:endHour]) {
        if([self isHourAm:startHour]) {
            hoursAtMidnightRate = endHour - startHour;
        } else {
            hoursAtMidnightRate = endHour;
        }
    }
    
    int hoursAtEarlyRate = 0;
    int hoursAtBedtimeRate = 0;
    if([self isHourPm:startHour]) {
        if([self isHourPm:endHour]) {
            hoursAtEarlyRate = endHour - startHour;
            if(bedtime >= startHour && bedtime < endHour) {
                hoursAtBedtimeRate = bedtime - startHour + 1;
                hoursAtEarlyRate -= hoursAtBedtimeRate;
            }
        } else {
            hoursAtEarlyRate = 24 - startHour;
            if(bedtime >= startHour && bedtime <= 23) {
                hoursAtBedtimeRate = 24 - bedtime;
                hoursAtEarlyRate -= hoursAtBedtimeRate;
            }
        }
    }

    double pay = (hoursAtMidnightRate * 16) + (hoursAtBedtimeRate * 8) + (hoursAtEarlyRate * 12);
    
    return pay;
    
}

- (BOOL)isValidBedtime:(int)time
{
    return time >= 0 && time <= 23;
}

- (BOOL)isWorkDurationValidForStartHour:(int)startHour andEndHour:(int)endHour
{
    BOOL individualHoursValid = [self isStartOrEndHour:startHour] && [self isStartOrEndHour:endHour];
    if(!individualHoursValid) {
        return NO;
    } else {
        // looking at the same am/pm
        if(([self isHourAm:startHour] && [self isHourAm:endHour]) || ([self isHourPm:startHour] && [self isHourPm:endHour])) {
            return endHour - startHour >= 0;
            
        // start hour is am, but end hour is pm.  Since our range is 5pm->4am, it's not possible to flip from am->pm, only pm->am or no flips at all!
        } else if([self isHourAm:startHour]) {
            return NO;
            
        // It's always valid when the start is pm and the end is am.   We've already checked that each individua time falls within our 5pm-4am range.
        } else {
            return YES;
        }
    }
}

- (BOOL)isStartOrEndHour:(int)time
{
    if(time < 0 || time > 23) {
        return NO;
    } else {
        if([self isHourAm:time]) {
            return time <= 4; //  4am
        } else {
            return time >= 17; // 5pm
        }
    }
}

- (BOOL)isHourAm:(int)hour
{
    return (hour - 12) < 0;
}

- (BOOL)isHourPm:(int)hour
{
    return ![self isHourAm:hour];
}

            
@end
