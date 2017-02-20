//
//  PatientSelectController.h
//  Registration
//
//  Created by Bradley Stocks on 2017/02/20.
//  Copyright © 2017 CapeRay. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "PatientInfo.h"

@class PatientSelectController;

@protocol PatientSelectControllerDelegate <NSObject>
-(void)returnValueFromController:(PatientSelectController*) controller value:(NSDictionary*) val;
-(void)deleteValueFromController:(PatientSelectController*) controller value:(NSDictionary*) val;
@end


@interface PatientSelectController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate>


@property IBOutlet UITableView* table;
@property IBOutlet UIButton* cancelButton;
@property NSArray *patients;
@property NSDictionary* selectedPatient;
@property BOOL dataFetched;
@property id<PatientSelectControllerDelegate> delegate;

- (IBAction)close:(id)sender;
- (IBAction)select:(id)sender;
- (IBAction)delete:(id)sender;

@end
