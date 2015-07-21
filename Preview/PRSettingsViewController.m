//
//  PRSettingsViewController.m
//  Preview
//
//  Created by SaiKiran Dasika on 21/07/15.
//  Copyright (c) 2015 Burst. All rights reserved.
//

#import "PRSettingsViewController.h"
#import "MSCellAccessory.h"
#import "PRColorWheel.h"
#import "PRDetailSettingViewController.h"


@interface PRSettingsViewController ()

@end

@implementation PRSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.settingsTableView.delegate = self;
    self.settingsTableView.dataSource = self;
    self.settingsTitles = [NSArray arrayWithObjects:@"About Us", @"Terms of use", @"Privacy Policy", nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoah!" message:@"Looks like you are low on memory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.settingsTitles count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.settingsTableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PRColorWheel *colorwheel = [[PRColorWheel alloc] init];
    cell.textLabel.text = [self.settingsTitles objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [colorwheel randomColor];
    cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:[colorwheel randomColor]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //we just have to use a switch statement
    NSString *settingTitle = [self.settingsTitles objectAtIndex:indexPath.row];
    NSLog(@"%@", settingTitle);
    [self setPropertiesWithTitle:settingTitle];
}

-(void)setPropertiesWithTitle:(NSString *)settingTitle{
    if ([settingTitle isEqualToString:@"About Us"]) {
        //change detail url link to the about us
        self.detailSettingURL = [NSURL URLWithString:@"http://burst.co.in/preview/about_us.php"];
        [self performSegueWithIdentifier:@"showDetailSetting" sender:self];
        
    }
    else if ([settingTitle isEqualToString:@"Terms of use"]){
        //change detail url to terms of use
        self.detailSettingURL = [NSURL URLWithString:@"http://burst.co.in/preview/terms.php"];
        [self performSegueWithIdentifier:@"showDetailSetting" sender:self];
    }
    else{
        //change to privacy policy
        self.detailSettingURL = [NSURL URLWithString:@"http://burst.co.in/preview/privacy.php"];
        [self performSegueWithIdentifier:@"showDetailSetting" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetailSetting"]) {
        PRDetailSettingViewController *viewController = (PRDetailSettingViewController *)segue.destinationViewController;
        viewController.detailSettingURL = self.detailSettingURL;
    }
}

@end
