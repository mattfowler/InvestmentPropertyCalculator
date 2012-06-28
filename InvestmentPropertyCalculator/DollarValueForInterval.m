//
//  DollarValue.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DollarValueForInterval.h"

@implementation DollarValueForInterval

@synthesize dollarValue = value;
@synthesize timeInterval = interval;

NSString* VALUE_KEY = @"value";
NSString* INTERVAL_KEY = @"interval";

+(DollarValueForInterval*) createValue:(double) value forTimeInterval:(TimeInterval) interval {
    return [[[DollarValueForInterval alloc] initWithValue:value andTimeInterval:interval] autorelease];
}

-(id) initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self->value = [decoder decodeDoubleForKey:VALUE_KEY];
        self->interval = [decoder decodeIntForKey:INTERVAL_KEY];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeDouble:value forKey:VALUE_KEY];
    [coder encodeInt:interval forKey:INTERVAL_KEY];
}

- (id) initWithValue:(double)dollarValue andTimeInterval:(TimeInterval)timeInterval{
    self = [super init];
    if (self) {
        self->value = dollarValue;
        self->interval = timeInterval;
    }    
    return self;
}

-(double) getValue {
    return value;
}

-(double) getValueForTimeInterval:(TimeInterval) timeInterval {
    if(self->interval == timeInterval) {
        return value;
    } else {
        if (self->interval == Year) {
            return value / 12.0;
        } else {
            return value * 12.0;
        }
    }
}

+(NSString *) getStringDollarValueFromDouble:(double)dollarValue {
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *formattedValue = [formatter stringFromNumber:[NSNumber numberWithDouble:dollarValue]];
    [formatter release];
    return  formattedValue;
}

-(double) getValueAfterYears:(int)years withAppreciationRate:(double)rate andTimeInterval:(TimeInterval) timeInterval {
    return [self getValueForTimeInterval:timeInterval] * pow(1.0 + rate, years);
}

@end
