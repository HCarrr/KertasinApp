import 'package:get/get.dart';

import '../../../model/invoice/history_pembelian/history_pembelian_model.dart';

class HistoryPembelianController extends GetxController {
  var filters = <HistoryPembelianModel>[
    HistoryPembelianModel(label: 'All'),
    HistoryPembelianModel(label: 'January'),
    HistoryPembelianModel(label: 'February'),
    HistoryPembelianModel(label: 'March'),
    HistoryPembelianModel(label: 'April'),
    HistoryPembelianModel(label: '1oaksoikask'),
    HistoryPembelianModel(label: '2oaksoaksas'),
  ].obs;

  var selectedIndex = 0.obs;

  void selectFilter(int index) {
    selectedIndex.value = index;
  }
}
