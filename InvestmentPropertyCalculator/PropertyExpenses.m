//
//  PropertyExpenses.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PropertyExpenses.h"

@implementation PropertyExpenses

@synthesize taxes;
@synthesize insurance;
@synthesize utilities;
@synthesize maintenance;
@synthesize vacancyRate;
@synthesize otherExpenses;

static NSString* TAXES_KEY = @"taxes";
static NSString* INSURANCE_KEY = @"insurance";
static NSString* UTILITIES_KEY = @"utilities";
static NSString* MAINTENANCE_KEY = @"maintenance";
static NSString* VACANCY_RATE = @"vacancyRate";
static NSString* OTHER_KEY = @"otherExpenses";


-(id) initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.taxes = [decoder decodeObjectForKey:TAXES_KEY];
        self.insurance = [decoder decodeObjectForKey:INSURANCE_KEY];
        self.utilities = [decoder decodeObjectForKey:UTILITIES_KEY];
        self.maintenance = [decoder decodeObjectForKey:MAINTENANCE_KEY];
        self.vacancyRate = [decoder decodeDoubleForKey:VACANCY_RATE];
        self.otherExpenses = [decoder decodeObjectForKey:OTHER_KEY];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:taxes forKey:TAXES_KEY];
    [coder encodeObject:insurance forKey:INSURANCE_KEY];
    [coder encodeObject:utilities forKey:UTILITIES_KEY];
    [coder encodeObject:maintenance forKey:MAINTENANCE_KEY];
    [coder encodeDouble:vacancyRate forKey:VACANCY_RATE];
    [coder encodeObject:otherExpenses forKey:OTHER_KEY];
}

-(double)getYearlyExpensesAsDouble {
    return [taxes getDollarValueForTimeInterval:Year].doubleValue + [insurance getDollarValueForTimeInterval:Year].doubleValue + [utilities getDollarValueForTimeInterval:Year].doubleValue + [maintenance getDollarValueForTimeInterval:Year].doubleValue + [otherExpenses getDollarValueForTimeInterval:Year].doubleValue;
}

-(DollarValue *) getYearlyExpenses {
    return [DollarValue createValue:self.getYearlyExpensesAsDouble];
}

-(DollarValue *) getMonthlyExpenses {
    return [DollarValue createValue:self.getYearlyExpensesAsDouble / 12.0];
}

@end
