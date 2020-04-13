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
    

    NSString *description;
    if(_viewModel.book.description){
        description = _viewModel.book.description;
        /*NSError *err = nil;
       description = [[[NSAttributedString alloc]
                                   initWithData: [_viewModel.book.description dataUsingEncoding:NSUTF8StringEncoding]
                                   options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                   documentAttributes: nil
                                   error: &err] string ];
         */
        
        // get the ones from label
        NSDictionary *attributes = @{
            NSForegroundColorAttributeName: self.bookDescriptionLabel.textColor,
                                  NSFontAttributeName: self.bookDescriptionLabel.font
                                  };
        
        
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:description attributes:attributes];
        UIFont *boldFont = [UIFont boldSystemFontOfSize:self.bookDescriptionLabel.font.pointSize];
        
   
        
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<b>.*</b>"
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:&error];
        
        NSArray *matches = [regex matchesInString:description options:0 range:NSMakeRange(0, [description length])];
        for (NSTextCheckingResult *match in matches) {
             NSRange matchRange = [match range];
            [attributedText setAttributes:@{NSFontAttributeName: boldFont} range:matchRange];
        }
                
        [attributedText.mutableString replaceOccurrencesOfString:@"<b>" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [attributedText.mutableString length])];
        [attributedText.mutableString replaceOccurrencesOfString:@"</b>" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [attributedText.mutableString length])];
        
        [attributedText.mutableString replaceOccurrencesOfString:@"<p>" withString:@"\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [attributedText.mutableString length])];
        [attributedText.mutableString replaceOccurrencesOfString:@"</p>" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [attributedText.mutableString length])];
    
        
        self.bookDescriptionLabel.attributedText = attributedText;
    }else{
        self.bookDescriptionLabel.text = @"*no description provided*";
    }



    
    
    
    
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
