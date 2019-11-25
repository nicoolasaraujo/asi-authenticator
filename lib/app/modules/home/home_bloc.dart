import 'package:asi_authenticator/app/model/Account.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

enum HomeEvent { increment, decrement }

class HomeBloc extends Bloc<HomeEvent, int> {

  HomeBloc(){
    this.listIssuers = List<Account>();
  }

  @override
  int get initialState => 0;
  @override
  Stream<int> mapEventToState(HomeEvent event) async* {
    switch (event) {
      case HomeEvent.decrement:
        yield state - 1;
        break;
      case HomeEvent.increment:
        yield state + 1;
        break;
    }
  }

  List<Account> listIssuers;
  var _issuersController = BehaviorSubject<List<Account>>();

  Observable<List<Account>> get outIssuers => this._issuersController.stream;
  Sink<List<Account>> get inIssuers => this._issuersController.sink;

  void addIssuers(String uri) {
    var issuer = Account.withUri(uri);
    this.listIssuers.add(issuer);
    this.inIssuers.add(listIssuers);
  }

  void handleUri() {

  }
}


// otpauth://totp/ACME%20Co:john.doe@email.com?secret=HXDMVJECJJWSRB3HWIZR4IFUGFTMXBOZ&issuer=ACME%20Co&algorithm=SHA1&digits=6&period=30