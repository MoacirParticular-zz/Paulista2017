//
//  Artilharia_ViewController.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artilharia_Celula.h"
#import "DAOArtilharia.h"
#import "ArtilhariaCallMethods.h"
#import "globals.h"
#import "EGORefreshTableHeaderView.h"

//#import "GADBannerView.h"
//#import "GADBannerViewDelegate.h"
//#import "GADRequest.h"


@interface Artilharia_ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, FutebasMethodsDelegate, ArtilhariaCallMethodsDelegate, EGORefreshTableHeaderDelegate> {
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSTimer* checarCarregando;
}

@property int alturaTabela;

@property (strong, nonatomic) ArtilhariaCallMethods *artilhariaCallMethods;
@property (strong, nonatomic) NSArray* arrayArtilharia;
@property (strong, nonatomic) IBOutlet UITableView *tabela;

@end
