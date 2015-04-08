//
//  InboxTableViewController.m
//  ELHS Sports
//
//  Created by Alex Atwater on 1/23/15.
//  Copyright (c) 2015 Alex Atwater. All rights reserved.
//

#import "InboxTableViewController.h"
#import "ELHS_Sports-Swift.h"


@interface InboxTableViewController () {
    
    NSArray *messagesArray;
    
}



@end

@implementation InboxTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    [self.tableView registerNib:[UINib nibWithNibName:@"MessagesTableViewCell" bundle:nil] forCellReuseIdentifier:@"messageCell"];
    
    
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    MBProgressHUD *loadingProgress = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    loadingProgress.detailsLabelText = @"Loading...";
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Messages"];
    [query orderByAscending:@"createdAt"];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
       
        if (error) {
            NSLog(@"%@", [NSString stringWithFormat:@"\nError: %@", error.description]);
            
            loadingProgress.mode = MBProgressHUDModeText;
            loadingProgress.detailsLabelText = @"Error!";
            [MBProgressHUD hideAllHUDsForView:self.view animated:true];
            
            
            
        } else {
            messagesArray = objects;
            [MBProgressHUD hideAllHUDsForView:self.view animated:self];
            [self.tableView reloadData];
        }
        
    }];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    
    if (messagesArray) {
        return messagesArray.count;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 1;
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 194;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    
    PFObject *messageObject =[messagesArray objectAtIndex:indexPath.row];
    
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"EEE MMMM d, YYYY"];
    NSString *date = [df stringFromDate:messageObject.createdAt];
    
    cell.dateLabel.text = date;
    
   
    
    
    NSString *title = [messageObject objectForKey:@"title"];
    NSString *message = [messageObject objectForKey:@"message"];
    
    cell.titleLabel.text = title;
    cell.messageLabel.text = message;
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

























@end
