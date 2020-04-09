//
//  SearchViewController.m
//  BookStore
//
//  Created by Pedro Costa on 08/04/2020.
//  Copyright © 2020 Pedro Costa. All rights reserved.
//

#import "SearchViewController.h"
#import "BookTableViewCell.h"
#import "SearchViewModel.h"
#import "Book.h"
#import "BookViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController{
    SearchViewModel *_viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BookCell" bundle:nil] forCellReuseIdentifier:@"BookCell" ];
    
    _viewModel = [SearchViewModel new];
    
    /*
    UISearchController *searchController = [UISearchController new];
    searchController.delegate = self;
    searchController.searchBar.delegate = self;
    searchController.automaticallyShowsScopeBar = YES;
      self.navigationItem.titleView = searchController.searchBar;
     */
    
    [self refresh];
   
}


- (void) refresh{
    if(_viewModel.books && _viewModel.books.count){
        self.messagesLabel.hidden = YES;
        self.tableView.hidden = NO;
        [self.tableView reloadData];
        return;
    }
    
    self.tableView.hidden = YES;
    
    if(self.searchBar.text.length){
        self.messagesLabel.text = @"No results found :(";
    }else{
        self.messagesLabel.text = @"Type something :)";
    }
    self.messagesLabel.hidden = NO;
}


- (void) search:(NSString *)name{
    [_viewModel clear];
    

    [_viewModel fetchListByName:name sucessHandler:^(NSMutableArray * books){
        [self refresh];
    } errorHandler:^(NSError *error){
        [self refresh];
    }];
       
    
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self search:searchBar.text];
    NSLog(@"Searching for: %@", searchBar.text);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return _viewModel.books.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookCell" forIndexPath:indexPath];
    
    Book *book = _viewModel.books[indexPath.row];
    
    cell.bookTitleLabel.text = book.name;
    cell.bookDescriptionLabel.text = book.publishedDate;
    
    // tbh this "cache" is useless, everything gets reloaded unless then a cell is outside the view, the OS destroys it and then reloads it again onScroll. 🤷‍♂️
    // "Allow Arbitrary Loads" @ plist was changed to YES to allow http requests
    if(book.coverImage){
        cell.bookCoverImage.image = book.coverImage;
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.coverImageURL]];
             book.coverImage = [UIImage imageWithData:imageData];
            cell.bookCoverImage.image =  book.coverImage;
            cell.imageLoadingActivityIndicator.hidden = YES;
        });
    }
    
    
    
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
    BookViewController *bookViewController = [ self.storyboard instantiateViewControllerWithIdentifier:@"BookViewController"];
   
    // <b>still</b> not sure if this is anti-pattern in MVVM :/
    Book *book = _viewModel.books[indexPath.row];
    [bookViewController setBook:book];
    [self.navigationController pushViewController:bookViewController animated:YES];
}




@end
