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

abstract class GuestAddressRepository {
  Future<CountriesData?> callCountriesData();
}

class GuestAddressRepositoryImp implements GuestAddressRepository {
  @override
  Future<CountriesData?> callCountriesData() async {
    CountriesData? countryData;
    try {
      countryData = await ApiClient().getCountryStateList();
    } catch (error, stacktrace) {
      debugPrint("Error --> $error");
      debugPrint("StackTrace --> $stacktrace");
    }
    return countryData;
  }
}
