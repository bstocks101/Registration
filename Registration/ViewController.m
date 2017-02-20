//
//  ViewController.m
//  Registration
//
//  Created by Bradley Stocks on 2017/02/17.
//  Copyright © 2017 CapeRay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchData:nil];
    // Do any additional setup after loading the view, typically from a nib.
    [self cleanUp];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) cleanUp {
    self.image = [UIImage imageNamed:@"Default.jpg"];
    [self.pictureView setImage:self.image];
    [self.patientNameField setText:@""];
    [self.patientIDField setText:@""];
}

- (IBAction)buttonPushed:(id)sender{
    if (sender == _submitButton){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Submit Patient"
                                                                       message:[NSString stringWithFormat:@"Would you like to submit these details for patient %@", [self.patientNameField text]]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  self.currentPatient = [[PatientInfo alloc] initWithName:self.patientNameField.text
                                                                                                                       ID:self.patientIDField.text image:self.image];
                                                                  
                                                                  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://192.168.1.123:8765"]];
                                                                  [request setHTTPMethod:@"POST"];
                                                                  [request setHTTPBody:[self.currentPatient.patientName dataUsingEncoding:NSUTF8StringEncoding]];
                                                                  
                                                                  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
                                                                  NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
                                                                  
                                                                  NSDictionary *dictionary = @{@"PatientName": self.currentPatient.patientName, @"PatientID":self.currentPatient.patientID};
                                                                  NSError *error = nil;
                                                                  NSData *data1 = [NSJSONSerialization dataWithJSONObject:dictionary
                                                                                                                 options:kNilOptions error:&error];
                                                                  
                                                                  if (!error) {
                                                                      NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                                                                                                 fromData:data1 completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                                                                                                                                     NSLog(@"%@", response);
                                                                                                                                 }];
                                                                      
                                                                      [uploadTask resume];
                                                                  }
                                                                  
                                                                  [self fetchData:nil];
                                                                  [self cleanUp];
                                                              }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if(sender == _cancelButton){
        [self cleanUp];
    }
    if(sender == _pictureButton){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;;
        [picker setDelegate:self];
        [self presentViewController:picker animated:YES
                         completion:^ {
                             
                         }];
        
    }
    if(sender == _ListButton){
        
        /*
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://192.168.1.123:8765"]];
        [request setHTTPMethod:@"GET"];
        [request setHTTPBody:[self.currentPatient.patientName dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        NSError *error = nil;
        
        if (!error) {
            NSURLSessionDataTask *downloadTask = [session dataTaskWithRequest:request
                                                                       completionHandler:^(NSData* data, NSURLResponse *response, NSError *error) {
                                                                           NSLog(@"%@", response);
         
                                                                           NSString* myString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                                                           NSLog(@"%@", myString);
                                                                           
                                                                       }];
            
            
            [downloadTask resume];
        }
        */
        


        
        [self cleanUp];
    }
}

- (IBAction)fetchData:(id)sender{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://192.168.1.123:8765"]];
    [request setHTTPMethod:@"GET"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    NSError *error = nil;
    NSURLSessionDataTask *downloadTask;
    if (!error) {
        downloadTask = [session dataTaskWithRequest:request
                                  completionHandler:^(NSData* data, NSURLResponse *response, NSError *error) {
                                      NSString* myString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                      NSLog(@"%@", myString);
                                      int location = [myString rangeOfString:@"~"].location;
                                      NSString* body = [myString substringFromIndex:location+1]; //strip header
                                      NSLog(@"%@", body);
                                      
                                      NSStringEncoding  encoding = NSASCIIStringEncoding;
                                      NSData * jsonData = [body dataUsingEncoding:encoding];
                                      NSError * error1=nil;
                                      self.patients = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error1]; //extract array of dictionaries
                                      NSLog(@"%@", self.patients);
                                      
                                  }];
        
        [downloadTask resume];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"listSegue"]){
        PatientSelectController *controller = (PatientSelectController *)segue.destinationViewController;
        controller.delegate = self;
        controller.patients = self.patients;
    }
}

-(void) returnValueFromController:(PatientSelectController *)controller value:(NSDictionary *)val{
    NSLog(@"Root controller received patient: %@", val);
}

-(void) deleteValueFromController:(PatientSelectController *)controller value:(NSDictionary *)val{
    NSLog(@"Request to delete patient: %@", val);
    
    

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://192.168.1.123:8765/delete"]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[val[@"PatientID"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSDictionary *dictionary = @{@"PatientID": val[@"PatientID"]};
    NSError *error = nil;
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:dictionary
                                                    options:kNilOptions error:&error];
    
    if (!error) {
        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                                   fromData:data1 completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                                                                       NSLog(@"Response from server: %@", response);
                                                                       [self fetchData:nil];
                                                                   }];
        
        [uploadTask resume];
    }
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.patientIDField) {
        [textField resignFirstResponder];
        [self buttonPushed:self.submitButton];
        return NO;
    }
    if (textField == self.patientNameField){
        [self.patientIDField becomeFirstResponder];
        return NO;
    }
    return YES;
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.pictureView.image = self.image;
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:^{}];
}



@end
