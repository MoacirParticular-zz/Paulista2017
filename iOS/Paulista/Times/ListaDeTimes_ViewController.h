//
//  ListaDeTimes_ViewController.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAOClube.h"
#import "globals.h"
#import "ClubeCallMethods.h"
#import "EGORefreshTableHeaderView.h"
#import "ListaTimes_Celula.h"


@interface ListaDeTimes_ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, FutebasConnectionDelegate, ClubeMethodsDelegate, EGORefreshTableHeaderDelegate> {
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSTimer* checarCarregando;
}

@property (strong, nonatomic) ClubeCallMethods *clubeCallMethods;
@property (strong, nonatomic) NSArray* arrayClube;
@property (strong, nonatomic) IBOutlet UITableView *tabela;



- (IBAction)Voltar:(id)sender;

@end
