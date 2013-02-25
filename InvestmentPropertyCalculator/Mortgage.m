//
//  Mortgage.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Mortgage.h"
#import "DollarValue.h"

@implementation Mortgage

@synthesize salesPrice;
@synthesize downpaymentPercent;
@synthesize interestRate;
@synthesize amoritizationYears;

static NSString* SALES_PRICE_KEY = @"salesPrice";
static NSString* DOWNPAYMENT_PERCENT_KEY = @"downpaymentPercent";
static NSString* INTEREST_RATE_KEY = @"interestRate";
static NSString* AMORITIZATION_YEARS_KEY = @"amoritizationYears";

-(id) initWithSalesPrice:(DollarValue*)price downpayment:(double)downpayment interestRate:(double)interest years:(double) years {
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
        self.salesPrice = [decoder decodeObjectForKey:SALES_PRICE_KEY];
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

-(DollarValue *) getMonthlyPayment {
    double dollars = [self getInitialPrincipal] * (self.getMonthlyInterest / (1 - pow(1 + self.getMonthlyInterest, -[self mortgageTermInMonths])));
    return [DollarValue createValue:dollars];
}

-(double) getInitialPrincipal {
    return salesPrice.doubleValue - self.getDownpaymentAmount.doubleValue;
}

- (DollarValue *) getDownpaymentAmount {
    return [DollarValue createValue:salesPrice.doubleValue * (downpaymentPercent / 100)];
}

- (DollarValue *) getTotalInterestPaid {
    double interest = (self.getMonthlyPayment.doubleValue * [self mortgageTermInMonths]) - self.getInitialPrincipal;
    return [DollarValue createValue:interest];
}

- (DollarValue *) getInterestPaidInYear:(int) year {
    double yearlyPayments = self.getMonthlyPayment.doubleValue * 12;
    double principalPaidInYear = [self getPrincipalPaidInYear:year];
    return principalPaidInYear == 0 ? DollarValue.zeroDollars : [DollarValue createValue:yearlyPayments - principalPaidInYear];
}

- (double) getPrincipalPaidInYear:(int) year {
    if (year == 0) {
        return 0;
    } else {
        int startMonth = (year - 1) * 12;
        int endMonth = startMonth + 12;
        if (startMonth >= [self mortgageTermInMonths]) {
            return 0.0;
        }
        double startBalance = [self getPrincipalDueAtMonth:startMonth];
        double endBalance = [self getPrincipalDueAtMonth:endMonth];
        return startBalance-endBalance;
    }
}

-(int) mortgageTermInMonths {
    return amoritizationYears * 12;
}

-(double) getPrincipalDueAtMonth:(int) month {
    double monthlyInterestRate = self.getMonthlyInterest;
    return (self.getInitialPrincipal *  pow(1 + monthlyInterestRate, month)) - ((pow(1+monthlyInterestRate, month)-1) / monthlyInterestRate)* self.getMonthlyPayment.doubleValue;
}

-(double) getMonthlyInterest {
    return interestRate / (12 * 100);
}


@end
