//
//  BaseToolbarController.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyInvestment.h"
#import "PropertyFileManager.h"

@interface BaseOpenAndSaveViewController : UIViewController {
    @private
    UITextField *alertTextField;
    
    @protected
    PropertyFileManager *fileManager;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UIToolbar *keyboardToolbar;

- (PropertyInvestment *) getPropertyInvestment;

- (IBAction)saveButtonClicked:(id)sender;

- (IBAction)openButtonClicked:(id)sender;

@end
