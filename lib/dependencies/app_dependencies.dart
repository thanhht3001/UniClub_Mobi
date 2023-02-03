import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/dependencies/bloc_dependencies.dart';
import 'package:unicec_mobi/dependencies/current_user_dependencies.dart';
import 'package:unicec_mobi/dependencies/page_dependencies.dart';
import 'package:unicec_mobi/dependencies/service_dependencies.dart';

import '../firebase_options.dart';

class AppDependencies{
  static GetIt get _injector => GetIt.I;

  static Future<void> setup() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
    await ServiceDependencies.setup(_injector);
    await CurrentUserDependencies.setup(_injector);
    await PageDependencies.setup(_injector);
    await BlocDependencies.setup(_injector);
  }
}