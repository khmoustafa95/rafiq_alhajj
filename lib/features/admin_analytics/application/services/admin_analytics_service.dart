import 'package:rafiq_alhajj/features/admin_analytics/data/repositories/admin_analytics_repository.dart';
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/admin_dashboard_stats.dart';

class AdminAnalyticsService {
  const AdminAnalyticsService(this._repository);

  final AdminAnalyticsRepository _repository;

  Future<AdminDashboardStats> loadDashboard() {
    return _repository.fetchDashboardStats();
  }
}
