import 'package:build_byte/services/api_services.dart';
import 'package:build_byte/services/user_service.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';

NavigationService get navigationService => locator<NavigationService>();
ApiService get apiservice => locator<ApiService>();
