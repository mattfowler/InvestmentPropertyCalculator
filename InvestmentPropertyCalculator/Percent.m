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

- (id) initWithValue:(double)percentValue {
    self = [super init];
    if (self) {
        self->value = percentValue;
    }
    return self;
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
