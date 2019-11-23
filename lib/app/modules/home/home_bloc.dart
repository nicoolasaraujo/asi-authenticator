import 'package:asi_authenticator/app/model/KeyUri.dart';
import 'package:bloc/bloc.dart';
import 'package:countdown/countdown.dart';
import 'package:rxdart/rxdart.dart';

enum HomeEvent { increment, decrement }

class HomeBloc extends Bloc<HomeEvent, int> {

  HomeBloc(){
    this.listIssuers = List<UriKey>();
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

  List<UriKey> listIssuers;
  var _issuersController = BehaviorSubject<List<UriKey>>();

  Observable<List<UriKey>> get outIssuers => this._issuersController.stream;
  Sink<List<UriKey>> get inIssuers => this._issuersController.sink;

  void addIssuers(String uri) {
    var issuer = UriKey('5HTNVFARMIDCAFSXV7QBMBTJRUVIZ2TQ', 'teste');
    this.listIssuers.add(issuer);
    this.inIssuers.add(listIssuers);
  }
}
