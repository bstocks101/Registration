//
//  PatientSelectController.m
//  Registration
//
//  Created by Bradley Stocks on 2017/02/20.
//  Copyright © 2017 CapeRay. All rights reserved.
//

#import "PatientSelectController.h"

@interface PatientSelectController ()

@end

@implementation PatientSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.selectedPatient = nil;
    //self.patients = [[NSArray alloc] initWithObjects:@"Brad", @"Tim", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedPatient = self.patients[indexPath.row];
    NSLog(@"Selected patient: %@", self.selectedPatient);
    //[self.delegate returnValueFromController:self value:self.selectedPatient];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)close:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)delete:(id)sender{
    [self.delegate deleteValueFromController:self value:self.selectedPatient];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)select:(id)sender{
    [self.delegate returnValueFromController:self value:self.selectedPatient];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.patients count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Patient";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [self.patients objectAtIndex:indexPath.row][@"PatientName"];

    return cell;
}

- (NSArray*) arrayFromString: (NSString*) response{
    NSArray *strings = [response componentsSeparatedByString:@"\n"];
    NSLog(@"%ld", (unsigned long)[strings count]);
    return strings;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
