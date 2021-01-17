import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/repositories/configuration_repository.dart';

import '../bloc.dart';

class ConfigureBloc extends Bloc<ConfigureEvent, ConfigureState> {
  ConfigurationRepository _configurationRepository;

  ConfigureBloc() : super(LoadConfigureMenuState()) {
    _configurationRepository = ConfigurationRepository();
  }

  @override
  Stream<ConfigureState> mapEventToState(
    ConfigureEvent event,
  ) async* {
    if (event is LoadConfigurePageEvent) {
      yield LoadConfigureMenuState();
    } else if (event is ScanShopCodeEvent) {
      String storeAddress = await _configurationRepository.getStoreAddress();
      if (storeAddress.isNotEmpty) {
        add(CheckShopCodeEvent(storeAddress: storeAddress));
      }
    } else if (event is CheckShopCodeEvent) {
      Map<String, dynamic> _serverAvailableInfo = await _configurationRepository
          .isServerAvailable(storeAddress: event.storeAddress);
      bool serverAvailableInfo = _serverAvailableInfo["success"];
      if (serverAvailableInfo) {
        yield ShopAvailableState();
      } else {
        yield ShopUnAvailableState();
      }
    }
  }
}
