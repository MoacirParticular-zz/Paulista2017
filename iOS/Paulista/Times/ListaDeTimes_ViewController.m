//
//  ListaDeTimes_ViewController.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//
#import "ListaDeTimes_ViewController.h"

@interface ListaDeTimes_ViewController ()

@end

@implementation ListaDeTimes_ViewController
@synthesize arrayClube, clubeCallMethods, tabela;

- (IBAction)Voltar:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:loadingView];
    
    // ********************************* Inicio Ego ******************************************
    if (_refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tabela.bounds.size.height, self.view.frame.size.width, self.tabela.bounds.size.height)];
		view.delegate = self;
		[self.tabela addSubview:view];
		_refreshHeaderView = view;
        //	[view release];
	}
    
    [_refreshHeaderView refreshLastUpdatedDate];
    // ********************************* Fim Ego *********************************************
    
    [self AtualizarListaEgo:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [self AtualizarLista:self];
}

- (IBAction)AtualizarLista:(id)sender {
    arrayClube = [DAOClube fetchAllClubes];
    loadingView.hidden = YES;
    [tabela reloadData];
}

// ********************************* Inicio Ego *********************************************
- (IBAction)AtualizarListaEgo:(id)sender {
    loadingView.hidden = NO;
    
    clubeCallMethods = [[ClubeCallMethods alloc] initWithDelegate:self];
    [clubeCallMethods getAllClubes];
    
    [self AtualizarLista:self];
}

#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return [self carregandoAlgum]; // should return if data source model is reloading
    return YES;
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource{
    [self AtualizarListaEgo:self];
    checarCarregando=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(checarSeEstaCarregando) userInfo:nil repeats:YES];
}
-(void)checarSeEstaCarregando{
    if ([self carregandoAlgum]==NO) {
        [checarCarregando invalidate];
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tabela];
    }
}

-(BOOL)carregandoAlgum{
    BOOL checar=NO;
    //  [self AtualizarLista:self];
    //  checar=YES;
    return checar;
}
// ********************************* Fim Ego *********************************************


-(void)clubeObtidaComSucesso:(NSDictionary *)json
{
    //  loadingView.hidden = YES;
    
    [DAOClube parseAndInsertObjectsWithJson:json];
    
    [self AtualizarLista:self];
    //   NSLog(@"%@", arrayClube);
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    loadingView.hidden = YES;
    NSLog(@"Erro Clube: %@", error);
}

#pragma mark - **************************** Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayClube.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idCelula = @"idClube_Celula";
    ListaTimes_Celula *celula = [tableView dequeueReusableCellWithIdentifier:idCelula];
    
    if (celula == nil)
    {
        celula = [[ListaTimes_Celula alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idCelula];
    }
    
//    if (indexPath.row %2) {
//        celula.bgColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
//    } else {
//        celula.bgColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
//    }
    
    Clube* clube = [arrayClube objectAtIndex:indexPath.row];
    
    UIImage* img = [UIImage imageNamed:clube.sigla];
    
    celula.imgTime.image = img;
    celula.nmTime.text = clube.nome;
    
    return celula;
}

@end



