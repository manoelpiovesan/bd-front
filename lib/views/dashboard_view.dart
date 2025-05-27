import 'package:fl_chart/fl_chart.dart'; // Adicionado para o gráfico
import 'package:flutter/material.dart';
import 'package:projeto_bd_front/consumers/dashboard_consumer.dart';
import 'package:projeto_bd_front/models/dashboard.dart';
import 'package:projeto_bd_front/views/widgets/stats_card.dart';

///
///
///
class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  ///
  ///
  ///
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

///
///
///
class _DashboardViewState extends State<DashboardView> {
  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: FutureBuilder<Dashboard?>(
        future: DashboardConsumer().getDashboard(),
        builder: (
          final BuildContext context,
          final AsyncSnapshot<Dashboard?> snapshot,
        ) {
          if (snapshot.hasData) {
            final Dashboard? dashboard = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      /// Employees
                      StatsCard(
                        title: 'Funcionários',
                        subtitle: (dashboard?.totalEmployees ?? 0).toString(),
                      ),

                      /// Departments
                      StatsCard(
                        title: 'Departamentos',
                        subtitle: (dashboard?.totalDepartments ?? 0).toString(),
                      ),
                    ],
                  ),

                  /// Employees without Department
                  Row(
                    children: <Widget>[
                      StatsCard(
                        title: ' Funcionários sem Departamento',
                        subtitle:
                            (dashboard?.unassignedEmployees ?? 0).toString(),
                      ),
                    ],
                  ),

                  /// Gráfico de pizza de funcionários por departamento
                  if (dashboard != null &&
                      dashboard.employeesByDepartment.isNotEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Funcionários por Departamento',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Container(
                              padding: const EdgeInsets.all(18),
                              height: 300,
                              child: PieChart(
                                PieChartData(
                                  sections: List.generate(
                                    dashboard.employeesByDepartment.length,
                                    (index) {
                                      final dept =
                                          dashboard.employeesByDepartment[index];
                                      final color = Colors.primaries[
                                          index % Colors.primaries.length];
                                      return PieChartSectionData(
                                        value: dept.totalEmployees.toDouble(),
                                        // Mostra nome e quantidade
                                        title: '${dept.name} (${dept.totalEmployees})',
                                        color: color,
                                        radius: 80,
                                        titleStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
