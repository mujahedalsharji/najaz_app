/*
 *   Webkul Software.
 *   @package Mobikul Application Code.
 *   @Category Mobikul
 *   @author Webkul <support@webkul.com>
 *   @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *   @license https://store.webkul.com/license.html
 *   @link https://store.webkul.com/license.html
 */

import 'package:bagisto/screens/checkout/checkout_save_order/bloc/save_order_event.dart';
import 'package:bagisto/screens/checkout/checkout_save_order/bloc/save_order_repositroy.dart';
import 'package:bagisto/screens/checkout/checkout_save_order/bloc/save_oredr_state.dart';

import '../../../../utils/index.dart';
import '../../data_model/save_order_model.dart';

class SaveOrderBloc extends Bloc<SaveOrderBaseEvent, SaveOrderBaseState> {
  SaveOrderRepository? repository;

  SaveOrderBloc(this.repository) : super(SaveOrderInitialState()) {
    on<SaveOrderBaseEvent>(mapEventToState);
  }
  void mapEventToState(
    SaveOrderBaseEvent event,
    Emitter<SaveOrderBaseState> emit,
  ) async {
    if (event is SaveOrderFetchDataEvent) {
      try {
        SaveOrderModel? saveOrderModel = await repository?.savePaymentReview(
          serverPayload: event.serverPayload,
        );
        if (saveOrderModel?.success == true) {
          emit(SaveOrderFetchDataState.success(saveOrderModel: saveOrderModel));
        } else {}
        // }
      } catch (e) {
        emit(SaveOrderFetchDataState.fail(error: e.toString()));
      }
    }
  }
}
