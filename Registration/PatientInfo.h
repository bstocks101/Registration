//
//  PatientInfo.h
//  Registration
//
//  Created by Bradley Stocks on 2017/02/17.
//  Copyright © 2017 CapeRay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PatientInfo : NSObject

@property NSString* patientName, *patientID;
@property UIImage* patientImage;

- (id) initWithName:(NSString*) name ID: (NSString*) idNum image: (UIImage*) image;

@end
