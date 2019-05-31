import 'dart:async';
import 'package:flutter_simpleapp_blocpattern/eventCounter.dart';


class Bloc{
  int _counter=0;


  final _streamController=StreamController<int>();

  StreamSink<int> get _inCounter=>_streamController.sink;
  Stream<int> get counter=> _streamController.stream;


  final _streamEventController=StreamController<EventCounter>();

  Sink<EventCounter> get eventControllerSink=>_streamEventController.sink;

  Bloc(){
    _streamEventController.stream.listen(_mapEventToState);
  }
  _mapEventToState(EventCounter event){
    if (event is IncrementEvent)
      _counter++;
    else
      _counter--;

    _inCounter.add(_counter);
  }
  void dispose(){
    _streamEventController.close();
    _streamController.close();
  }
}