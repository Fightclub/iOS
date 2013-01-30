//
//  FCFriendSelectViewController.m
//  Givair
//
//  Created by Peter Tsoi on 1/29/13.
//  Copyright (c) 2013 Fightclub. All rights reserved.
//

#import "FCFriendSelectViewController.h"
#import "FCAppDelegate.h"
#import "FCGraph.h"

@interface FCFriendSelectViewController ()

@end

@implementation FCFriendSelectViewController

- (id)initWithGift:(FCProduct*)gift {
    self = [super initWithStyle:UITableViewCellStyleDefault];
    if (self) {
        mGift = gift;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:
            [cell.textLabel setText:@"Jeremy Fiance"];
            break;
        case 1:
            [cell.textLabel setText:@"Jordan Greene"];
            break;
        case 2:
            [cell.textLabel setText:@"Peter Lee"];
            break;
        case 3:
            [cell.textLabel setText:@"Peter Tsoi"];
            break;
        case 4:
            [cell.textLabel setText:@"Zach Hargreaves"];
            break;
        default:
            break;
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [AppDelegate.graph sendNewGift:mGift
                                  fromUser:[[NSUserDefaults standardUserDefaults] objectForKey:@"apikey"]
                                    toUser:@"Jeremy.fiance@gmail.com"];
            break;
        case 1:
            [AppDelegate.graph sendNewGift:mGift
                                  fromUser:[[NSUserDefaults standardUserDefaults] objectForKey:@"apikey"]
                                    toUser:@"jordangre314@gmail.com"];
            break;
        case 2:
            [AppDelegate.graph sendNewGift:mGift
                                  fromUser:[[NSUserDefaults standardUserDefaults] objectForKey:@"apikey"]
                                    toUser:@"nadapeter@gmail.com"];
            break;
        case 3:
            [AppDelegate.graph sendNewGift:mGift
                                  fromUser:[[NSUserDefaults standardUserDefaults] objectForKey:@"apikey"]
                                    toUser:@"petertsoi@gmail.com"];
            break;
        case 4:
            [AppDelegate.graph sendNewGift:mGift
                                  fromUser:[[NSUserDefaults standardUserDefaults] objectForKey:@"apikey"]
                                    toUser:@"hargreaves.z@gmail.com"];
            break;
        default:
            break;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
