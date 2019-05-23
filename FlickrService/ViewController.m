//
//  ViewController.m
//  FlickrService
//
//  Created by Yoon Lee on 5/21/19.
//  Copyright © 2019 Yoon Lee. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *contents;

@end

@implementation ViewController
@synthesize collectionView, contents;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // TODO:
    CGFloat searchBarHeight = 50.f;
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, searchBarHeight);
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:frame];
    [searchBar setPlaceholder:@""];
    [searchBar setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    frame.size.height = self.view.bounds.size.height - searchBarHeight;
    frame.origin.y = searchBarHeight;
    collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    [self.collectionView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    [self.collectionView setBackgroundColor:UIColor.whiteColor];
    // registering cells
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ThisCell"];
    [self.view addSubview:searchBar];
    [self.view addSubview:self.collectionView];
    
    // web request
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    AFJSONRequestSerializer *serializer = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
    NSURL *URL = [NSURL URLWithString:@"http://httpbin.org/get"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            // parse json
            
            // reload the collection view
            [self.collectionView reloadData];
        }
    }];
    [dataTask resume];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.contents.count;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThisCell" forIndexPath:indexPath];
    
    return cell;
}

@end
