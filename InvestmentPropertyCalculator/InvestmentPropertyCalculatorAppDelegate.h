//
//  InvestmentPropertyCalculatorAppDelegate.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyInvestment.h"
#import "PropertyInvestmentProtocol.h"


@interface InvestmentPropertyCalculatorAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, PropertyInvestmentProtocol> {
    PropertyInvestment* propertyInvestment;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) PropertyInvestment *propertyInvestment;

@end
