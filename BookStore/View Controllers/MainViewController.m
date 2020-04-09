//
//  MainViewController.m
//  BookStore
//
//  Created by Pedro Costa on 08/04/2020.
//  Copyright © 2020 Pedro Costa. All rights reserved.
//

#import "MainViewController.h"
#import "BooksRepo.h"
#import "BookCollectionViewCell.h"
#import "MainViewModel.h"
#import "BookViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController{
    MainViewModel *_viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewModel = [MainViewModel new];
    [self.booksCollectionView registerNib:[UINib nibWithNibName:@"BookCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BookCollectionViewCell"];
    
    [self update];
}

- (void)viewWillAppear:(BOOL)animated{
    [self update];
}


- (void) update{
    [_viewModel update];
    [self.booksCollectionView reloadData];
    
    if([_viewModel.books count]){
        self.booksCollectionView.hidden = NO;
        self.messagesLabel.hidden = YES;
        
    }else{
        self.booksCollectionView.hidden = YES;
        self.messagesLabel.hidden = NO;
    }
    
}







- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[BooksRepo getFavourites] count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BookCollectionViewCell *cell = [self.booksCollectionView dequeueReusableCellWithReuseIdentifier:@"BookCollectionViewCell" forIndexPath:indexPath];
    
    Book *book = _viewModel.books[indexPath.row];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        [self->_viewModel fetchBookByBookId:book.bookId sucessHandler:^(Book *nbook){
            cell.bookTitleLabel.text = nbook.name;
            if(nbook.coverImage){
                            cell.bookCoverImage.image = book.coverImage;
            }else{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:nbook.coverImageURL]];
                                 nbook.coverImage = [UIImage imageWithData:imageData];
                                cell.bookCoverImage.image =  nbook.coverImage;
                            });
             }
            
                             
        } errorHandler:^(NSError *error){
            
        }];
    });
    
    
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat height = 300.0;

    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait) {
        CGFloat columns = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 3.0 : 2.0;

        CGFloat width = CGRectGetWidth(self.view.frame) / columns;

        return CGSizeMake(width, height);
    }
    else { // landscape
        CGFloat columns = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 4.0 : 3.0;

        CGFloat width = CGRectGetWidth(self.view.frame) / columns;

        return CGSizeMake(width, height);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        
     BookViewController *bookViewController = [ self.storyboard instantiateViewControllerWithIdentifier:@"BookViewController"];
    
     // <b>still</b> not sure if this is anti-pattern in MVVM :/
     Book *book = _viewModel.books[indexPath.row];
     NSLog(@"%@", book.bookId);
     [bookViewController setBook:book];
     
     //[self.navigationController performSegueWithIdentifier:@"showBookDetailSegue" sender:self];
     
     [self.navigationController pushViewController:bookViewController animated:YES];

}
@end
