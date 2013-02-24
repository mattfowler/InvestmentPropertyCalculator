//
//  DollarValue.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DollarValueForInterval.h"

@implementation DollarValueForInterval

NSString* DOLLAR_VALUE_KEY = @"dollarValue";
NSString* INTERVAL_KEY = @"interval";

+(DollarValueForInterval*) createValue:(double) value forTimeInterval:(TimeInterval) interval {
    DollarValue* dollarValue = [DollarValue createValue:value];
    return [[DollarValueForInterval alloc] initWithDollarValue:dollarValue andTimeInterval:interval];
}

-(id) initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self->value = [decoder decodeObjectForKey:DOLLAR_VALUE_KEY];
        self->interval = [decoder decodeIntForKey:INTERVAL_KEY];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:value forKey:DOLLAR_VALUE_KEY];
    [coder encodeInt:interval forKey:INTERVAL_KEY];
}

-(id) initWithDollarValue:(DollarValue*)dollarValue andTimeInterval:(TimeInterval)timeInterval  {
    self = [super init];
    if (self) {
        self->value = dollarValue;
        self->interval = timeInterval;
    }
    return self;
}

-(DollarValue*) getDollarValue {
    return value;
}

-(double) getValue {
    return value.doubleValue;
}

-(DollarValue *)getDollarValueForTimeInterval:(TimeInterval)interval {
    if(self->interval == interval) {
        return value;
    } else {
        if (self->interval == Year) {
            return [DollarValue createValue:value.doubleValue / 12.0];
        } else {
            return [DollarValue createValue:value.doubleValue * 12.0];
        }
    }
}

+(NSString *) getStringDollarValueFromDouble:(double)dollarValue {
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *formattedValue = [formatter stringFromNumber:[NSNumber numberWithDouble:dollarValue]];
    return  formattedValue;
}

-(double) getValueAfterYears:(int)years withAppreciationRate:(double)rate andTimeInterval:(TimeInterval) timeInterval {
    return [self getDollarValueForTimeInterval:timeInterval].doubleValue * pow(1.0 + rate, years);
}

@end
