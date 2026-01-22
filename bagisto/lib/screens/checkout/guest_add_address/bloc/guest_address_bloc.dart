/*
 *   Webkul Software.
 *   @package Mobikul Application Code.
 *   @Category Mobikul
 *   @author Webkul <support@webkul.com>
 *   @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *   @license https://store.webkul.com/license.html
 *   @link https://store.webkul.com/license.html
 */

import 'package:bagisto/screens/checkout/utils/index.dart';

import '../../../../utils/index.dart';
import '../../../address_list/data_model/country_model.dart';
import 'guest_address_event.dart';
import 'guest_address_state.dart';

class GuestAddressBloc
    extends Bloc<GuestAddressBaseEvent, GuestAddressBaseState> {
  GuestAddressRepository? repository;

  GuestAddressBloc(this.repository) : super(GuestAddressInitialState()) {
    on<GuestAddressBaseEvent>(mapEventToState);
  }

  void mapEventToState(
    GuestAddressBaseEvent event,
    Emitter<GuestAddressBaseState> emit,
  ) async {
    if (event is GuestAddressCountryEvent) {
      try {
        CountriesData? countryData = await repository?.callCountriesData();
        emit(GuestAddressCountryState.success(countryData: countryData));
      } catch (e) {
        emit(GuestAddressCountryState.fail(error: e.toString()));
      }
    }
  }
}
