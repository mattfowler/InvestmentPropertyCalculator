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

-(void) encodeWithCoder:(NSCoder *) coder {
    [coder encodeInt:salesPrice forKey:SALES_PRICE_KEY];
    [coder encodeDouble:downpaymentPercent forKey:DOWNPAYMENT_PERCENT_KEY];
    [coder encodeDouble:interestRate forKey:INTEREST_RATE_KEY];
    [coder encodeInt:amoritizationYears forKey:AMORITIZATION_YEARS_KEY];
}

- (double) getMonthlyPayment {
    return [self getInitialPrincipal] * (self.getMonthlyInterest / (1 - pow(1 + self.getMonthlyInterest, -[self mortgageTermInMonths])));
}

- (double) getInitialPrincipal {
    return salesPrice - [self getDownpaymentAmount];
}

- (double) getDownpaymentAmount {
    return salesPrice * (downpaymentPercent / 100);
}

- (double) getTotalInterestPaid {
    return (self.getMonthlyPayment * [self mortgageTermInMonths]) - self.getInitialPrincipal;
}

- (double) getInterestPaidInYear:(int) year {
    double yearlyPayments = self.getMonthlyPayment * 12;
    double principalPaidInYear = [self getPrincipalPaidInYear:year];
    return principalPaidInYear == 0 ? 0 : yearlyPayments - principalPaidInYear;
}

- (double) getPrincipalPaidInYear:(int) year {
    int startMonth = (year - 1) * 12;
    int endMonth = startMonth + 12;
    if (startMonth >= [self mortgageTermInMonths]) {
        return 0.0;
    }
    double startBalance = [self getPrincipalDueAtMonth:startMonth];
    double endBalance = [self getPrincipalDueAtMonth:endMonth];
    return startBalance-endBalance;
}

-(int) mortgageTermInMonths {
    return amoritizationYears * 12;
}

-(double) getPrincipalDueAtMonth:(int) month {
    double monthlyInterestRate = self.getMonthlyInterest;
    return (self.getInitialPrincipal *  pow(1 + monthlyInterestRate, month)) - ((pow(1+monthlyInterestRate, month)-1) / monthlyInterestRate)* self.getMonthlyPayment;
}

-(double) getMonthlyInterest {
    return interestRate / (12 * 100);
}


@end
