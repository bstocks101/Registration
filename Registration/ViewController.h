//
//  ViewController.h
//  Registration
//
//  Created by Bradley Stocks on 2017/02/17.
//  Copyright © 2017 CapeRay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientInfo.h"
#include "PatientSelectController.h"


@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, NSURLSessionDelegate, UIPopoverPresentationControllerDelegate, PatientSelectControllerDelegate, UITextFieldDelegate>

@property IBOutlet UITextField* patientNameField;
@property IBOutlet UITextField* patientIDField;
@property IBOutlet UIButton* pictureButton;
@property IBOutlet UIButton* submitButton;
@property IBOutlet UIButton* cancelButton;
@property IBOutlet UIButton* ListButton;
@property IBOutlet UIImageView* pictureView;
@property UIImage* image;
@property PatientInfo* currentPatient;
@property NSArray* patients;

- (IBAction)buttonPushed:(id)sender;
- (IBAction)fetchData:(id)sender;


@end

