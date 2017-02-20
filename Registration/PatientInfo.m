//
//  PatientInfo.m
//  Registration
//
//  Created by Bradley Stocks on 2017/02/17.
//  Copyright © 2017 CapeRay. All rights reserved.
//

#import "PatientInfo.h"

@implementation PatientInfo

- (id) initWithName:(NSString*) name ID: (NSString*) idNum image: (UIImage*) image{
    self.patientName = name;
    self.patientID = idNum;
    self.patientImage = image;
    return self;
}

@end
