import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/http/http_service.dart';
import 'package:smartmarktclient/repositories/configuration_repository.dart';

import '../bloc.dart';

class ConfigureBloc extends Bloc<ConfigureEvent, ConfigureState> {
  late ConfigurationRepository _configurationRepository;

  ConfigureBloc() : super(LoadConfigureMenuState()) {
    _configurationRepository = ConfigurationRepository();
  }

  @override
  Stream<ConfigureState> mapEventToState(ConfigureEvent event) async* {
    if (event is LoadConfigurePageEvent) {
      yield LoadConfigureMenuState();
    } else if (event is ScanShopCodeEvent) {
      String storeAddress = '192.168.56.1:8080';
      if (storeAddress.isNotEmpty) {
        final checkShopCodeEvent =
            CheckShopCodeEvent(storeAddress: storeAddress);
        add(checkShopCodeEvent);
      }
    } else if (event is CheckShopCodeEvent) {
      yield* checkShopAvailability(event);
    }
  }

  Stream<ConfigureState> checkShopAvailability(
    CheckShopCodeEvent event,
  ) async* {
    String storeAddress = event.storeAddress;
    bool isServerAvailable = await _configurationRepository.isServerAvailable(
      storeAddress: storeAddress,
    );
    if (isServerAvailable) {
      HttpService.hostUrl = storeAddress;
      yield ShopAvailableState(UniqueKey());
    } else {
      HttpService.hostUrl = "";
      yield ShopUnAvailableState(UniqueKey());
    }
  }
}
