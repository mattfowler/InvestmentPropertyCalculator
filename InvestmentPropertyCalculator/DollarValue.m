//
//  DollarValue.m
//  InvestmentPropertyCalculator
//
//  Created by MATTHEW FOWLER on 2/8/13.
//
//

#import "DollarValue.h"

@implementation DollarValue

@synthesize doubleValue = value;

NSString* VALUE_KEY = @"value";

- (id) initWithValue:(double)dollarValue {
    self = [super init];
    if (self) {
        self->value = dollarValue;
    }
    return self;
}

+(DollarValue *) createValue:(double) value {
    return [[DollarValue alloc] initWithValue:value];
}

+(DollarValue *) zeroDollars {
    return [DollarValue createValue:0.0];
}

-(NSString *) getCurrencyString {
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    return [formatter stringFromNumber:[NSNumber numberWithDouble:value]];
}

-(NSString *)getDecimalString {
    return [NSString stringWithFormat:@"%1.2f", value];
}

-(id) initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self->value = [decoder decodeDoubleForKey:VALUE_KEY];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeDouble:value forKey:VALUE_KEY];
}

@end
