//
//  BookViewController.m
//  BookStore
//
//  Created by Pedro Costa on 08/04/2020.
//  Copyright © 2020 Pedro Costa. All rights reserved.
//

#import "BookViewController.h"

@interface BookViewController ()

@end

@implementation BookViewController{
    BookViewModel *_viewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if(!_viewModel ){
         _viewModel = [BookViewModel new];
     }

    
    self.bookTitleLabel.text = _viewModel.book.name;
    self.bookCoverImageView.image = _viewModel.book.coverImage;
    
    // make sure i
    self.bookTitleLabel.numberOfLines = 0;
    [self.bookTitleLabel sizeToFit];
    
    [_viewModel fetchBookByBookId:_viewModel.book.bookId sucessHandler:^(NSDictionary *serverResponsedata){
        [self update];
    } errorHandler:^(NSError *error){
        
    }];
        
}

- (void) update{
    self.bookTitleLabel.text = _viewModel.book.name;
    self.bookDescriptionLabel.text = _viewModel.book.description ? _viewModel.book.description :  @"*no description provided*";
    self.bookPublishedLabel.text = _viewModel.book.publishedDate;
    
    
    if(_viewModel.book.buyLink){
        [self.buyButton setTitle:@"Buy" forState:UIControlStateNormal];
        [self.buyButton setEnabled:YES];
    }else{
        [self.buyButton setTitle:@"Not available" forState:UIControlStateNormal];
        [self.buyButton setEnabled:NO];
    }
    
    
    
    if(_viewModel.book.coverImage){
        self.bookCoverImageView.image = _viewModel.book.coverImage;
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self->_viewModel.book.coverImageURL]];
            self->_viewModel.book.coverImage = [UIImage imageWithData:imageData];
            self.bookCoverImageView.image = self->_viewModel.book.coverImage;
        });
    }
    
    if([_viewModel isBookFavourite]){
        [self.addToFavouritesButton setTitle:@"Remove from favourites" forState:UIControlStateNormal];
    }else{
        [self.addToFavouritesButton setTitle:@"Add to favourites" forState:UIControlStateNormal];
    }
        
}



- (IBAction)onAddToFavouritesClick:(id)sender {
    if([_viewModel isBookFavourite]){
        [_viewModel removeBookFromFavourites];
        [self.addToFavouritesButton setTitle:@"Add to favourites" forState:UIControlStateNormal];
    }else{
        [_viewModel addBookToFavourites];
        [self.addToFavouritesButton setTitle:@"Remove from favourites" forState:UIControlStateNormal];
    }

}

- (IBAction)onBuyButtonClick:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString: _viewModel.book.buyLink] options:@{} completionHandler:nil];
}

- (void)setBook:(Book *)book{
    if(!_viewModel ){
        _viewModel = [BookViewModel new];
    }
    _viewModel.book = book;
}

@end
