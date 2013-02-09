//
//  DollarValue.m
//  InvestmentPropertyCalculator
//
//  Created by MATTHEW FOWLER on 2/8/13.
//
//

#import "DollarValue.h"

@implementation DollarValue

NSString* VALUE_KEY = @"value";

@synthesize dollarValue = value;

- (id) initWithValue:(double)dollarValue {
    self = [super init];
    if (self) {
        self->value = dollarValue;
    }
    return self;
}

+(DollarValue*) createValue:(double) value {
    return [[DollarValue alloc] initWithValue:value];
}

-(NSString*) getStringValue {
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *formattedValue = [formatter stringFromNumber:[NSNumber numberWithDouble:value]];
    return  formattedValue;
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
