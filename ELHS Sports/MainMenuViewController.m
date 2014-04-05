//
//  MainMenuViewController.m
//  ELHS Sports
//
//  Created by Alex Atwater on 3/13/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "MainMenuViewController.h"
#import "SharedValues.h"
#import "AppDelegate.h"


@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    
    
    
    //The ad
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBanner) name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerError) name:@"bannerError" object:nil];
    
    
    
   
   //set the shared content to the local content
    self.tableContent = [[SharedValues allValues] sharedTableContent];
    

 
}

- (void)viewDidAppear:(BOOL)animated {
    
    
    
    self.adBanner = SharedAdBannerView;
    
    
    
    if ([[SharedValues allValues] adIsLoaded]) {
        [self loadBanner];
    } else {
        [self bannerError];
    }
    
    [self.view addSubview:self.adBanner];
    
}

- (void)viewDidLayoutSubviews {
    

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        
        //iPhone
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait) {
            
            //if portrait
            
            
            if (![[SharedValues allValues] adIsLoaded]) {
                //if no ad present
                
                if ((int)[[UIScreen mainScreen] bounds].size.height == 568) {
                    //4 inch
                    [self.tableView setFrame:CGRectMake(0, 0, 320, 568)];
                    [self.adBanner setFrame:CGRectMake(0, 518, 320, 50)];
                    
                    
                } else {
                    //3.5 inch
                    [self.tableView setFrame:CGRectMake(0, 0, 320, 480)];
                    [self.adBanner setFrame:CGRectMake(0, 430, 320, 50)];
                    
                }
                
            } else {
                
                //if ad is present
                if ((int)[[UIScreen mainScreen] bounds].size.height == 568) {
                    //4 inch
                    [self.tableView setFrame:CGRectMake(0, 0, 320, 518)];
                    [self.adBanner setFrame:CGRectMake(0, 518, 320, 50)];
                    
                    
                } else {
                    //3.5 inch
                    [self.tableView setFrame:CGRectMake(0, 0, 320, 430)];
                    [self.adBanner setFrame:CGRectMake(0, 430, 320, 50)];
                }
                
            }
            
        } else {
            
            
            
            
            //if landscape
            if (![[SharedValues allValues] adIsLoaded]) {
                //if no ad present
                if ((int)[[UIScreen mainScreen] bounds].size.height == 568) {
                    //4 inch
                    [self.tableView setFrame:CGRectMake(0, 0, 568, 320)];
                    [self.adBanner setFrame:CGRectMake(0, 288, 568, 32)];
                    
                } else {
                    //3.5 inch
                    [self.tableView setFrame:CGRectMake(0, 0, 480, 320)];
                    [self.adBanner setFrame:CGRectMake(0, 288, 480, 32)];
                
                }
                
            } else {
            
                //if ad is present
                if ((int)[[UIScreen mainScreen] bounds].size.height == 568) {
                    //4 inch
                    [self.tableView setFrame:CGRectMake(0, 0, 568, 288)];
                    [self.adBanner setFrame:CGRectMake(0, 288, 568, 32)];

                } else {
                    //3.5 inch
                    [self.tableView setFrame:CGRectMake(0, 0, 480, 288)];
                    [self.adBanner setFrame:CGRectMake(0, 288, 480, 32)];
                    
                }
                
            }
            
        }
        
        
        
        
        
    } else {
        //iPad
    }
        
    
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.tableContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSArray *tableData = self.tableContent;
    
    cell.textLabel.text = [[tableData objectAtIndex:indexPath.row] objectForKey:@"Title"];
    
    //image
    if ([[tableData objectAtIndex:indexPath.row] objectForKey:@"image"]) {
        //if valid image, set it
        cell.imageView.image = [[tableData objectAtIndex:indexPath.row] objectForKey:@"image"];
    }
    
    
    //be able to show the picture in the background
    cell.backgroundColor = [UIColor clearColor];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //when the user selectes the row
    
    
    
    //deselect the selected row
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
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

    
    [self performSegueWithIdentifier:@"showWebPage" sender:Nil];
    
}

#pragma mark iAds

- (void)loadBanner {
    
    [self.adBanner setAlpha:1];
    
    //maybe remove that
    [self viewDidLayoutSubviews];
    
    
    
    
}

- (void)bannerError {
    
    [self.adBanner setAlpha:0];
    
    //maybe remove that
    [self viewDidLayoutSubviews];
    
}



@end
