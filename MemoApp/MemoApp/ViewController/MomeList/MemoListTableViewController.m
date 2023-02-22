//
//  MemoListTableViewController.m
//  MemoApp
//
//  Created by 오국원 on 2023/02/22.
//

#import "MemoListTableViewController.h"
#import "Memo.h"
#import "DetailViewController.h"
#import "DataManager.h"

@interface MemoListTableViewController ()

@property (strong, nonatomic) NSDateFormatter* formatter;

@end

@implementation MemoListTableViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath* indexPath = [self.tableView indexPathForCell:(UITableViewCell*)sender];
    if (indexPath != nil) {
        Memo* target = [[[DataManager sharedInstance] memoList] objectAtIndex:indexPath.row];
        DetailViewController* vc = (DetailViewController*)segue.destinationViewController;
        vc.memo = target;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[DataManager sharedInstance] fetchMemo];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateStyle = NSDateFormatterLongStyle;
    self.formatter.timeStyle = NSDateFormatterNoStyle;
    self.formatter.locale = [NSLocale localeWithLocaleIdentifier:@"Ko_kr"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[DataManager sharedInstance] memoList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"memoListTableViewCell" forIndexPath:indexPath];
    
    Memo* target = [[[DataManager sharedInstance] memoList] objectAtIndex:indexPath.row];
    cell.textLabel.text = target.content;
    cell.detailTextLabel.text = [self.formatter stringFromDate:target.insertDate];
    
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Memo* taget = [[DataManager sharedInstance] memoList][indexPath.row];
        [[DataManager sharedInstance] deleteMemo:taget];
        [[[DataManager sharedInstance] memoList] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
