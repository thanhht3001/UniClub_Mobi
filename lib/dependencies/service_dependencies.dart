import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/services/notification_svc/i_notification_service.dart';

import '../services/competition_detail_svc/competition_detail_service.dart';
import '../services/competition_detail_svc/i_competition_detail_service.dart';
import '../services/competition_round_svc/competition_round_service.dart';
import '../services/competition_round_svc/i_competition_round_service.dart';
import '../services/i_services.dart';
import '../services/match_svc/i_match_service.dart';
import '../services/match_svc/match_service.dart';
import '../services/notification_svc/notification_service.dart';
import '../services/services.dart';

class ServiceDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<ICityService>(() => CityService());

    //import splash service
    injector.registerFactory<ISplashService>(() => SplashService());

    //import login service
    injector.registerFactory<ILoginService>(() => LoginService());

    //import university_selection_service
    injector.registerFactory<IUniversitySelectionService>(
        () => UniversitySelectionService());

    // user
    injector.registerFactory<IUserService>(() => UserService());

    //import club_service
    injector.registerFactory<IClubService>(() => ClubService());

    // competition
    injector.registerFactory<ICompetitionService>(() => CompetitionService());
    
    // competition detail
    injector.registerFactory<ICompetitionDetailService>(
        () => CompetitionDetailService());
    
    //round
    injector.registerFactory<ICompetitionRoundService>(
        () => CompetitionRoundService());

    // match
    injector.registerFactory<IMatchService>(() => MatchService());    

    // list team
    injector.registerFactory<IViewListTeamService>(() => ViewListTeamService());

    // team
    injector.registerFactory<ITeamService>(() => TeamService());

    // seeds wallet
    injector.registerFactory<ISeedsWalletService>(() => SeedsWalletService());

    // member
    injector.registerFactory<IMemberService>(() => MemberService());

    //competition activity
    injector.registerFactory<ICompetitionActivityService>(
        () => CompetitionActivityService());

    // notification
    injector.registerFactory<INotificationService>(
      () => NotificationService());
  }
}
