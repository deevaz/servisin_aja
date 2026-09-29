abstract class Routes {
  Routes._();
  static const main = _Paths.main;
  static const home = _Paths.home;
  static const vehicleSelect = _Paths.vehicleSelect;
  static const serviceConfig = _Paths.serviceConfig;
  static const schedule = _Paths.schedule;
  static const bookingSummary = _Paths.bookingSummary;
  static const bookingSuccess = _Paths.bookingSuccess;
  static const tracking = _Paths.tracking;
  static const workshopRating = _Paths.workshopRating;
  static const invoiceDetail = _Paths.invoiceDetail;
  static const bookingHistory = _Paths.bookingHistory;
}

abstract class _Paths {
  _Paths._();
  static const main = '/main';
  static const home = '/home';
  static const vehicleSelect = '/vehicle-select';
  static const serviceConfig = '/service-config';
  static const schedule = '/schedule';
  static const bookingSummary = '/booking-summary';
  static const bookingSuccess = '/booking-success';
  static const tracking = '/tracking';
  static const workshopRating = '/workshop-rating';
  static const invoiceDetail = '/invoice-detail';
  static const bookingHistory = '/booking-history';
}
