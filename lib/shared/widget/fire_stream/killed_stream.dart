import 'dart:developer';




class KilledStream {
  Future getKilledStream(Stream s) async {
    log("getKILLEDSTREAM !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

    log("s.isBroadcast: ${s.isBroadcast}");

    // await s.drain();
    // var subs = s.listen((event) {});
    // await subs.cancel();

    // var ref = FireDartFirestore.instance.collection('test');
    // ref.stream.listen((document) => print('updated: $document'));

    log("s.isBroadcast: x ${s.isBroadcast}");
  }
}
