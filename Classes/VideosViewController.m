//
//  FirstViewController.m
//  CCN
//
//  Created by Zachary Hariton on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VideosViewController.h"
#import "CCNAppDelegate.h"
#import "DetailViewController.h"
#import "OverlayViewController.h"
#import "Show.h"
#import "Article.h"
#import "XMLParserVideo.h"
#import "Reachability.h"
#import "ImageDownload.h"

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];

	hostReachable = [[Reachability reachabilityWithHostName: @"www.clarku.edu"] retain];
	[hostReachable startNotifier];
	
	Shows = [[NSMutableArray alloc] init];
	
	[self loadShows];
	
	//Initialize the copy array.
	copyShows = [[NSMutableArray alloc] init];
	
	self.navigationItem.title = @"Videos";
	
	//Add the search bar
	self.tableView.tableHeaderView = searchBar;
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	
	searching = NO;
	letUserSelectRow = YES;
}

-(void)loadShows	{
	NSURL *url = [[NSURL alloc] initWithString:@"http://www.clarku.edu/students/ccn/App/Videos.xml"];
	UIApplication *app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = YES;
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	app.networkActivityIndicatorVisible = NO;
	[url release];
	
	//Initialize the delegate.
	XMLParserVideo *parser = [[XMLParserVideo alloc] initXMLParser];
	
	//Set delegate
	[xmlParser setDelegate:parser];
	
	[xmlParser parse];
	
    //Shows = [[NSMutableArray alloc] initWithArray:[parser getShows] copyItems:YES];
    
	for (Show *showTemp in [parser getShows])	{
		[Shows addObject:[showTemp deepCopy]];
	}
	
	//[xmlParser release];
}

#pragma mark Table view methods

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier {
	
    CGRect CellFrame = CGRectMake(0, 0, 300, 70);
	CGRect Label1Frame = CGRectMake(10, 2, 230, 20);
	CGRect Label2Frame = CGRectMake(10, 24, 230, 15);
	UILabel *lblTemp;
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(240, 6, 58, 58)];
	
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithFrame:CellFrame reuseIdentifier:cellIdentifier] autorelease];
	
	//Initialize Label with tag 1.
	lblTemp = [[UILabel alloc] initWithFrame:Label1Frame];
	lblTemp.tag = 1;
	lblTemp.font = [UIFont boldSystemFontOfSize:17];
	[cell.contentView addSubview:lblTemp];
	[lblTemp release];
	
	//Initialize Label with tag 2.
	lblTemp = [[UILabel alloc] initWithFrame:Label2Frame];
	lblTemp.tag = 2;
	lblTemp.font = [UIFont systemFontOfSize:12];
	[cell.contentView addSubview:lblTemp];
	[lblTemp release];
    
    image.tag = 3;
    [image setBackgroundColor:[UIColor lightGrayColor]];
    [cell.contentView addSubview:image];
    [image release];
	
	return cell;
}

- (void)downloadDidFinishDownloading:(ImageDownload *)download  {
    if (download.image != nil) {
        [download.activityIndicator stopAnimating];
        [download.activityIndicator release];
    }
    download.imageView.image = download.image;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (searching) {
		return 44;
	}
	return [self tableView:tableView cellForRowAtIndexPath:indexPath].frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [self getCellContentView:CellIdentifier];
	
	UILabel *lblTemp1 = (UILabel *)[cell viewWithTag:1];
	UILabel *lblTemp2 = (UILabel *)[cell viewWithTag:2];
	
	// Set up the cell...
	if (searching)	{
		lblTemp1.text = [NSString stringWithFormat:@"%@%@%@",[[copyShows objectAtIndex:indexPath.row] getsubTitle], @": ",[[copyShows objectAtIndex:indexPath.row] getName]];
		lblTemp2.frame = CGRectMake(10, 24, 290, 15);
		lblTemp2.numberOfLines = 1;
		[self tableView:tableView heightForRowAtIndexPath:indexPath];
		lblTemp2.text = [[copyShows objectAtIndex:indexPath.row] getDescription];
        [[cell viewWithTag:3] setHidden:YES];
	}
	else	{
		NSString *Temp = [[[[Shows objectAtIndex:indexPath.section] getEpisodes] objectAtIndex:indexPath.row] getDescription];
		lblTemp1.text = [[[[Shows objectAtIndex:indexPath.section] getEpisodes] objectAtIndex:indexPath.row] getName];
        lblTemp2.numberOfLines = 3;
        lblTemp2.frame = CGRectMake(10, 24, 230, 45);
        cell.frame = CGRectMake(0, 0, 300, 70);
		lblTemp2.text = Temp;
        
        ImageDownload *ImageDownloader = [[ImageDownload alloc] init];
        ImageDownloader.urlString = [[[[Shows objectAtIndex:indexPath.section] getEpisodes] objectAtIndex:indexPath.row] getImage];
        ImageDownloader.imageView = (UIImageView *) [cell viewWithTag:3];
        
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activityIndicator setCenter:CGPointMake(269, 35)];
        [cell.contentView addSubview:activityIndicator];
        ImageDownloader.activityIndicator = activityIndicator;
        [activityIndicator startAnimating];
        if (ImageDownloader.image == nil) {
            ImageDownloader.delegate = self;
        }
	}
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {	
	if (searching)
		return 1;
	else
		return [Shows count];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (searching)
		return [copyShows count];
	else
		return [[[Shows objectAtIndex:section] getEpisodes] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (searching)
		return @"";
	else
		return [[Shows objectAtIndex:section] getName];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//Get the selected episode
	Article *selectedEpisode = [[Article alloc] init];
	
	if (searching)
		selectedEpisode = [copyShows objectAtIndex:indexPath.row];
	else
		selectedEpisode = [[[Shows objectAtIndex:indexPath.section] getEpisodes] objectAtIndex:indexPath.row];
	//Initialize the detail view controller and display it.
	
	DetailViewController *dvController = [[DetailViewController alloc] initWithNibName:@"DetailView" bundle:[NSBundle mainBundle]];
	dvController.selectedTitle = [selectedEpisode getsubTitle];
	dvController.selectedSubTitle = [selectedEpisode getName];
    dvController.selectedImage = [selectedEpisode getImage];
    dvController.selectedBody = [selectedEpisode getBody];
	dvController.navigationBar = @"Selected Episode";
	[self.navigationController pushViewController:dvController animated:YES];
	[dvController release];
	dvController = nil;
}

- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(letUserSelectRow)
		return indexPath;
	else
		return nil;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
	return UITableViewCellAccessoryDisclosureIndicator;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	[self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark -
#pragma mark Search Bar 

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	//Add the overlay view.
	if(ovController == nil)
		ovController = [[OverlayViewController alloc] initWithNibName:@"OverlayView" bundle:[NSBundle mainBundle]];
	
	CGFloat yaxis = self.navigationController.navigationBar.frame.size.height;
	CGFloat width = self.view.frame.size.width;
	CGFloat height = self.view.frame.size.height;
	
	//Parameters x = origion on x-axis, y = origon on y-axis.
	CGRect frame = CGRectMake(0, yaxis, width, height);
	ovController.view.frame = frame;
	ovController.view.backgroundColor = [UIColor grayColor];
	ovController.view.alpha = 0.5;
	
	ovController.rvController = self;
	
	[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
	
	searching = YES;
	letUserSelectRow = NO;
	self.tableView.scrollEnabled = NO;
	
	//Add the done button.
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
											   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
											   target:self action:@selector(doneSearching_Clicked:)] autorelease];
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
	//Remove all objects first.
	[copyShows removeAllObjects];
	
	if([searchText length] > 0) {
		[ovController.view removeFromSuperview];
		searching = YES;
		letUserSelectRow = YES;
		self.tableView.scrollEnabled = YES;
		[self searchTableView];
	}
	else {
		[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
		
		searching = NO;
		letUserSelectRow = NO;
		self.tableView.scrollEnabled = NO;
	}
	
	[self.tableView reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	[self searchTableView];
}

- (void) searchTableView {
	NSString *searchText = searchBar.text;
	NSMutableArray *searchArray = [[NSMutableArray alloc] init];
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	for (Show *currentShow in Shows)
	{
		array = [currentShow getEpisodes];
		[searchArray addObjectsFromArray:array];
	}
	
	int Count = 0;
	for (Article *episodeTemp in searchArray)
	{
		BOOL added = NO;
		NSString *sTemp = [episodeTemp getName];
		NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
		
		if (titleResultsRange.length > 0)	{
			[copyShows addObject:[searchArray objectAtIndex:Count]];
			added = YES;
		}
		
		sTemp = [episodeTemp getsubTitle];
		titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
		if (titleResultsRange.length > 0 && !added)
			[copyShows addObject:[searchArray objectAtIndex:Count]];
		
		Count++;
	}
	
	[searchArray release];
	searchArray = nil;
}

- (void) doneSearching_Clicked:(id)sender {
	searchBar.text = @"";
	[searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	self.tableView.scrollEnabled = YES;
	
	[ovController.view removeFromSuperview];
	[ovController release];
	ovController = nil;
	
	[self.tableView reloadData];
}

- (void) checkNetworkStatus:(NSNotification *)notice
{
	// called after network status changes
	
	NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
	if (hostStatus == NotReachable) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed"
														message:@"The connection to the server failed. Unable to download data"
													   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
		[alert release];
	}
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


-(void)dealloc	{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[Shows release];
	[searchBar release];
	[ovController release];
	[copyShows release];
	[super dealloc];
}

@end
