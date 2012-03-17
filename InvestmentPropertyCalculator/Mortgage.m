//
//  Mortgage.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Mortgage.h"

@implementation Mortgage

@synthesize salesPrice;
@synthesize downpaymentPercent;
@synthesize interestRate;
@synthesize amoritizationYears;

static NSString* SALES_PRICE_KEY = @"salesPrice";
static NSString* DOWNPAYMENT_PERCENT_KEY = @"downpaymentPercent";
static NSString* INTEREST_RATE_KEY = @"interestRate";
static NSString* AMORITIZATION_YEARS_KEY = @"amoritizationYears";

- (id) initWithSalesPrice:(int)price downpayment:(double)downpayment interestRate:(double)interest years:(double) years {
    self = [super init];
    if (self) {
        salesPrice = price;
        downpaymentPercent = downpayment;
        interestRate = interest;
        amoritizationYears = years;
    }    
    return self;
}

-(id) initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.salesPrice = [decoder decodeIntForKey:SALES_PRICE_KEY];
        self.downpaymentPercent = [decoder decodeDoubleForKey:DOWNPAYMENT_PERCENT_KEY];
        self.interestRate = [decoder decodeDoubleForKey:INTEREST_RATE_KEY];
        self.amoritizationYears = [decoder decodeIntForKey:AMORITIZATION_YEARS_KEY];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeInt:salesPrice forKey:SALES_PRICE_KEY];
    [coder encodeDouble:downpaymentPercent forKey:DOWNPAYMENT_PERCENT_KEY];
    [coder encodeDouble:interestRate forKey:INTEREST_RATE_KEY];
    [coder encodeInt:amoritizationYears forKey:AMORITIZATION_YEARS_KEY];
}

- (double) getMonthlyPayment {
    double monthlyInterest = interestRate / (12 * 100);
    int monthsOfLoan = amoritizationYears * 12;
    return [self getInitialPrincipal] * (monthlyInterest / (1 - pow(1 + monthlyInterest, -monthsOfLoan)));
}

- (double) getInitialPrincipal {
    return salesPrice - [self getDownpaymentAmount];
}

- (double) getDownpaymentAmount {
    return salesPrice * (downpaymentPercent / 100);
}

- (double) getTotalInterestPaid {
    return (self.getMonthlyPayment * (amoritizationYears * 12)) - self.getInitialPrincipal;
}

- (double) getInterestPaidInYear:(int)year {
    //TODO: (1+r)^N*P - (((1+r)^N-1)/ r) * C
    return 0;
}


@end
