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
@synthesize maintainence;
@synthesize vacancyRate;
@synthesize otherExpenses;

static NSString* TAXES_KEY = @"taxes";
static NSString* INSURANCE_KEY = @"insurance";
static NSString* UTILITIES_KEY = @"utilities";
static NSString* MAINTAINENCE_KEY = @"maintainence";
static NSString* VACANCY_RATE = @"vacancyRate";
static NSString* OTHER_KEY = @"otherExpenses";


-(id) initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.taxes = [decoder decodeIntForKey:TAXES_KEY];
        self.insurance = [decoder decodeDoubleForKey:INSURANCE_KEY];
        self.maintainence = [decoder decodeDoubleForKey:MAINTAINENCE_KEY];
        self.vacancyRate = [decoder decodeIntForKey:VACANCY_RATE];
        self.otherExpenses = [decoder decodeIntForKey:OTHER_KEY];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeDouble:taxes forKey:TAXES_KEY];
    [coder encodeDouble:insurance forKey:INSURANCE_KEY];
    [coder encodeDouble:maintainence forKey:MAINTAINENCE_KEY];
    [coder encodeDouble:vacancyRate forKey:VACANCY_RATE];
    [coder encodeDouble:otherExpenses forKey:OTHER_KEY];
}

-(double) getMonthlyExpenses {
    return taxes + insurance + utilities + maintainence + otherExpenses;
}

-(double) getYearlyExpenses {
    return self.getMonthlyExpenses * 12;
}

@end
