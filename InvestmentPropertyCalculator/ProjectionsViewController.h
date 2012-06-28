//
//  ProjectionsViewController.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ProjectionsViewController : BaseViewController <UITextFieldDelegate> {
    @private
    UITableViewController* projectionsTableViewController;
}

@property (nonatomic, retain) IBOutlet UITextField *rentIncreaseField;
@property (nonatomic, retain) IBOutlet UITableView *projectionsTableView;

@end
