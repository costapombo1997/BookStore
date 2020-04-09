//
//  BookViewController.h
//  BookStore
//
//  Created by Pedro Costa on 08/04/2020.
//  Copyright © 2020 Pedro Costa. All rights reserved.
//

#import "ViewController.h"
#import "BookViewModel.h"
#import "Book.h"
NS_ASSUME_NONNULL_BEGIN

@interface BookViewController : ViewController
@property NSString *bookId;


@property (weak, nonatomic) IBOutlet UIImageView *bookCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIButton *addToFavouritesButton;
@property (weak, nonatomic) IBOutlet UILabel *bookDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookPublishedLabel;


- (IBAction)onAddToFavouritesClick:(id)sender;
- (IBAction)onBuyButtonClick:(id)sender;


- (void) setBook:(Book *)book;



@end

NS_ASSUME_NONNULL_END
