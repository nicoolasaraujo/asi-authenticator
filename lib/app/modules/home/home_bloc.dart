import 'package:bloc/bloc.dart';
import 'package:countdown/countdown.dart';

enum HomeEvent { increment, decrement }

class HomeBloc extends Bloc<HomeEvent, int> {
  @override
  int get initialState => 0;
    
      CountDown cd = CountDown(Duration(seconds : 10));
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
    
      void initializeState() async {
        var sub = cd.stream.listen(null);
        
        // start your countdown by registering a listener
        sub.onData((Duration d) {
            print(d);
        });
    
        // when it finish the onDone cb is called
        sub.onDone(() {
            print("done");
        });

      }

}

