//
//  MainMenuViewController.m
//  ELHS Sports
//
//  Created by Alex Atwater on 3/13/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "MainMenuViewController.h"
#import "Reachability.h"
#import "SharedValues.h"
#import "AppDelegate.h"


@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    //check for internet connection
    if (![Reachability checkForInternetWithString:Nil]) {
        //show alert from the class
        [[Reachability showAlertNoInternet] show];
    }
    
    
    
    //The ad
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBanner) name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerError) name:@"bannerError" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToWeb) name:@"performSegue" object:nil];
    
    self.adBanner = SharedAdBannerView;
    
    [self setTableContentToDisplay];
    
    
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tableContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSArray *tableData = self.tableContent;
    
    cell.textLabel.text = [[tableData objectAtIndex:indexPath.row] objectForKey:@"Title"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //when the user selectes the row
    
    
    
    //decide what to set the value as
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"Home"]) {
        [[SharedValues allValues] setUrlToLoadAsString:@""];
    } else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"Swimming & Diving"]) {
        [[SharedValues allValues] setUrlToLoadAsString:@"Swimming"];
    } else {
        //set the webpage to load as the given title in the table that was selected
        [[SharedValues allValues] setUrlToLoadAsString:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    }
    
    //switch the view
    //check for internet connection
    if (![Reachability checkForInternetWithString:Nil]) {
        //show alert from the class
        [[Reachability showAlertNoInternet] show];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"performSegue" object:nil];
    }
    
    
    
}

- (void)setTableContentToDisplay {
    
    NSDictionary *home = [[NSDictionary alloc] initWithObjectsAndKeys:@"Home", @"Title", nil];
    NSDictionary *soccer = [[NSDictionary alloc] initWithObjectsAndKeys:@"Soccer", @"Title", nil];
    NSDictionary *basketball = [[NSDictionary alloc] initWithObjectsAndKeys:@"Basketball", @"Title", nil];
    NSDictionary *skiing = [[NSDictionary alloc] initWithObjectsAndKeys:@"Skiing", @"Title", nil];
    NSDictionary *wrestling = [[NSDictionary alloc] initWithObjectsAndKeys:@"Wrestling", @"Title", nil];
    NSDictionary *swimming = [[NSDictionary alloc] initWithObjectsAndKeys:@"Swimming & Diving", @"Title", nil];
    NSDictionary *hockey = [[NSDictionary alloc] initWithObjectsAndKeys:@"Hockey", @"Title", nil];
    NSDictionary *track = [[NSDictionary alloc] initWithObjectsAndKeys:@"Track", @"Title", nil];
    
    NSArray *allSports = [[NSArray alloc] initWithObjects:soccer, basketball, skiing, home, wrestling, swimming, hockey, home, track, nil];
    
    self.tableContent = [[NSArray alloc] initWithArray:allSports copyItems:true];
}










- (void)loadBanner {
    
    
    
}

- (void)bannerError {
    
    
}

- (void)switchToWeb {
    //swith to the web view
    [self performSegueWithIdentifier:@"showWebPage" sender:Nil];
}

@end
