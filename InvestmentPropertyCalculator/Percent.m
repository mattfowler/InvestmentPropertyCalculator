//
//  Percent.m
//  InvestmentPropertyCalculator
//
//  Created by MATTHEW FOWLER on 2/24/13.
//
//

#import "Percent.h"

@implementation Percent

NSString* PERCENT_VALUE_KEY = @"percentValue";

+(Percent *) create:(double) percentValue {
    return [[Percent alloc] initWithValue:percentValue];
}

-(id) initWithValue:(double)percentValue {
    self = [super init];
    if (self) {
        self->value = percentValue;
    }
    return self;
}

-(NSString *) getDisplayString {
    NSNumberFormatter *percentFormatter = [[NSNumberFormatter alloc] init];
    [percentFormatter setNumberStyle: NSNumberFormatterPercentStyle];
    return [percentFormatter stringFromNumber:[NSNumber numberWithDouble:value]];
}

-(id) initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self->value = [decoder decodeDoubleForKey:PERCENT_VALUE_KEY];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeDouble:value forKey:PERCENT_VALUE_KEY];
}

@end
