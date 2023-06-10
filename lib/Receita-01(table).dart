import 'package:flutter/material.dart';

void main() => runApp(const DataTableExampleApp());

class DataTableExampleApp extends StatelessWidget {
  const DataTableExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: Scaffold(
        appBar: AppBar(title: const Text("Cervejas Online")),
        body: const DataTableExample(),
      ),
    );
  }
}

class DataTableExample extends StatelessWidget {
  const DataTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text("Nome", style: TextStyle(fontStyle: FontStyle.italic)),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text("Estilo", style: TextStyle(fontStyle: FontStyle.italic)),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text("IBU", style: TextStyle(fontStyle: FontStyle.italic)),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text("La Fin Du Monde")),
            DataCell(Text("Bock")),
            DataCell(Text("65")),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text("Sapporo Premium")),
            DataCell(Text("Sour Ale")),
            DataCell(Text("54")),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text("Duvel")),
            DataCell(Text("Pilsner")),
            DataCell(Text("82")),
          ],
        ),
      ],
    );
  }
}
